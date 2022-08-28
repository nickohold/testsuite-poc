//
//  nickDelegate.swift
//  TestSuite
//
//  Created by Nick Holden on 22/08/2022.
//

import Foundation
import UIKit
import WebKit

class IronsourceAdsController: NSObject, ISRewardedVideoDelegate, ISInterstitialDelegate, ISImpressionDataDelegate {
    
    private var _isWebView: WKWebView!
    var isWebView: WKWebView {
        set (isWebView) {_isWebView = isWebView}
        get {return _isWebView}
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
    
}
