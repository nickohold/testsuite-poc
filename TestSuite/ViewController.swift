//
//  ViewController.swift
//  TestSuite
//
//  Created by Nick Holden on 18/08/2022.
//

import UIKit
import WebKit

//let kAPPKEY = "46197aed"
//let kAPPKEY = "13c0123e9"
let kAPPKEY = "9c5d9d55"

//let INTERSTITIAL_AD_UNIT = "INTERSTITIAL"

class ViewController: UIViewController, WKScriptMessageHandler {
    
    private var isWebView: WKWebView!
    let delegate = IronsourceAdsController()
    
    let config = WKWebViewConfiguration()
    let preferences = WKPreferences()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initJSWebView()
        delegate.isWebView = self.isWebView
        self.setupAndInitIronsourceSdk()
        
    }
    
    func initJSWebView() {
        self.isWebView = WKWebView(
            frame: self.view.bounds,
            configuration: self.getWKWebViewConfiguration()
        )
        self.isWebView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        let webViewHtml: String = "https://run.mocky.io/v3/6b2006f7-f915-42a4-a64b-fa4ccd04a6d2"
        let url = URL(string: webViewHtml)!
        let urlReq = URLRequest(url: url)
        self.isWebView.load(urlReq)
        self.view.addSubview(self.isWebView)
    }

    func setupAndInitIronsourceSdk() -> Void {
        IronSource.setRewardedVideoDelegate(delegate)
        IronSource.setInterstitialDelegate(delegate)
        IronSource.setBannerDelegate(delegate)

        IronSource.initWithAppKey(kAPPKEY)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "testsuiteBridge"{
            let body = message.body as? [String: AnyObject]
//            let keys = body?.keys
            for (key, value) in body! {
                if key.compare("showRewardsAd") == .orderedSame {
                    IronSource.showRewardedVideo(with: self)
                } else if key.compare("loadInterstitialAd") == .orderedSame {
                    IronSource.loadInterstitial()
                } else if key.compare("showInterstitialAd") == .orderedSame {
                    IronSource.showInterstitial(with: self)
                } else if key.compare("loadBannerAd") == .orderedSame {
                    let ISBannerSize: ISBannerSize? = ISBannerSize(width: value["width"] as! Int, andHeight: value["height"] as! Int)
                    IronSource.loadBanner(with: self, size: ISBannerSize!)
                } else if key.compare("showBannerAd") == .orderedSame {
                    delegate.showBanner(
                        xPos: value["xPos"] as! Float64,
                        yPos: value["yPos"] as! Float64,
                        width: value["width"] as! Float64,
                        height: value["height"] as! Float64
                    )
                } else if key.compare("destroyBanner") == .orderedSame {
                    IronSource.destroyBanner(delegate.mISBannerView)
                } else if key.compare("hasInterstitial") == .orderedSame {
                    delegate.runJsInWebView("hasInterstitial(\(IronSource.hasInterstitial()))")
                } else {
                    print("Dict key was not found in Bridge: \(key)")
                }

            }
        } else {
            print(message.body as! String)
        }
    }
    
    private func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
        userController.add(self, name: "testsuiteBridge")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }
}
