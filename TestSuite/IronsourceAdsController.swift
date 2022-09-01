//
//  nickDelegate.swift
//  TestSuite
//
//  Created by Nick Holden on 22/08/2022.
//

import Foundation
import UIKit
import WebKit

class IronsourceAdsController: NSObject, ISRewardedVideoDelegate, ISInterstitialDelegate, ISImpressionDataDelegate, ISBannerDelegate {
    
    private var _isWebView: WKWebView!
    var isWebView: WKWebView {
        set (isWebView) {_isWebView = isWebView}
        get {return _isWebView}
    }
    
    private var _mISBannerView: ISBannerView!
    var mISBannerView: ISBannerView {
        set (mISBannerView) {_mISBannerView = mISBannerView}
        get {return _mISBannerView}
    }
    
    func runJsInWebView(_ jsSciprt: String) {
        self.isWebView.evaluateJavaScript(jsSciprt, completionHandler: nil)
    }
    
    func initializationDidComplete() {
    }

    func rewardedVideoHasChangedAvailability(_ available: Bool) {
        self.runJsInWebView("adUnitReady('rewardedVideo')")
        
    }
    
    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
    }
    
    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
        self.runJsInWebView("adUnitFailToLoad('rewardedVideo')")
    }
    
    func rewardedVideoDidOpen() {
    }
    
    func rewardedVideoDidClose() {
    }
    
    func rewardedVideoDidStart() {
    }
    
    func rewardedVideoDidEnd() {
    }
    
    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
        
    }
    
    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        
    }
    
    var delegateCustom: String?
    
        
    func interstitialDidLoad() {
        self.runJsInWebView("adUnitReady('interstitialShow')")
    }
    
    func interstitialDidFailToLoadWithError(_ error: Error!) {
        self.runJsInWebView("adUnitFailToLoad('interstitialShow')")
    }
    
    func interstitialDidOpen() {
    }
    
    func interstitialDidClose() {
    }
    
    func interstitialDidShow() {
    }
    
    func interstitialDidFailToShowWithError(_ error: Error!) {
        
    }
    
    func didClickInterstitial() {
    }
    
    
//    Banners!
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.runJsInWebView("thisIsJustATest('stam')")
        self.runJsInWebView("adUnitReady('bannerShow')")
        mISBannerView = bannerView
//        let bannerView = MyCustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    }
    
    func showBanner(xPos: Float64, yPos: Float64, width: Float64, height: Float64) {
        print("mISBannerView")
        print(mISBannerView)
        mISBannerView.frame.origin.y = yPos
        mISBannerView.frame.origin.x = xPos
        mISBannerView.frame.size.width = width
        mISBannerView.frame.size.height = height
        isWebView.addSubview(mISBannerView)
    }
    
    func bannerDidFailToLoadWithError(_ error: Error!) {
        self.runJsInWebView("adUnitFailToLoad('bannerShow')")
    }
    
    func didClickBanner() {
        
    }
    
    func bannerWillPresentScreen() {
        
    }
    
    func bannerDidDismissScreen() {
        
    }
    
    func bannerWillLeaveApplication() {
        
    }

}
