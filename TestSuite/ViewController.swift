//
//  ViewController.swift
//  TestSuite
//
//  Created by Nick Holden on 18/08/2022.
//

import UIKit
import WebKit

let kAPPKEY = "46197aed"
let INTERSTITIAL_AD_UNIT = "INTERSTITIAL"

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
        let url = URL(string: "https://fb78-82-81-228-240.ngrok.io/testHtml.html")!
        let urlReq = URLRequest(url: url)
        self.isWebView.load(urlReq)
        self.view.addSubview(self.isWebView)
    }

    func setupAndInitIronsourceSdk() -> Void {
        IronSource.setRewardedVideoDelegate(delegate)
        IronSource.setInterstitialDelegate(delegate)
        IronSource.initWithAppKey(kAPPKEY)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "testsuiteBridge"{
            let body = message.body as? [String: AnyObject]
            let keys = body?.keys
            keys?.forEach({ key in
                if key.compare("showRewardsAd") == .orderedSame {
                    print("NICK - Show RV")
                    IronSource.showRewardedVideo(with: self)
                } else if key.compare("loadInterstitialAd") == .orderedSame {
                    print("NICK - Load IS")
                    IronSource.loadInterstitial()
                } else if key.compare("showInterstitialAd") == .orderedSame {
                    print("NICK - Show IS")
                    IronSource.showInterstitial(with: self)
                } else {
                    print("Dict key was not found in Bridge: \(key)")
                }
            })
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
