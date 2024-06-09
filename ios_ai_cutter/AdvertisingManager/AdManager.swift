//
//  AdsManager.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 1.10.2023.
//

import SwiftUI
import GoogleMobileAds

final class AdManager {
    
    static let shared = AdManager()
    static var rewardedAd: GADRewardedAd?
    
    private init() { }
    
    // load ad with mediation adapter
    func initializeAdMob() {
            let ads = GADMobileAds.sharedInstance()
            ads.start { status in
                // Optional: Log each adapter's initialization latency.
                let adapterStatuses = status.adapterStatusesByClassName
                for adapter in adapterStatuses {
                    let adapterStatus = adapter.value
                    NSLog("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                          adapterStatus.description, adapterStatus.latency)
                }
                // Load ad in adapter
                self.loadRewardedAd()
            }
        }
    
    func loadRewardedAd() {
        let request = GADRequest()
        // Load
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/5224354917",
                           request: request,
                           completionHandler: { ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            
            AdManager.rewardedAd = ad
            print("Rewarded ad loaded.")
            
            let responseInfo = ad?.responseInfo
            print("\(String(describing: responseInfo))")
            
            let loadedAdNetworkResponseInfo = responseInfo?.loadedAdNetworkResponseInfo
            let adNetworkClassName = loadedAdNetworkResponseInfo?.adNetworkClassName
            
            // Know which ad network wins
            print("Ad Network Class Name:")
            print("\(String(describing: adNetworkClassName))")
        }) // ends of load()
    }
    
    /*func showRewardedAd() {
        let root = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
        
        if let ad = AdManager.rewardedAd {
            ad.present(fromRootViewController: root!) {
                let reward = ad.adReward
                print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
                // TODO: Reward the user.
                print("Reward the user.")
            }
        } else {
            print("Ad wasn't ready")
        }
    } */
    
    func showRewardedAd(completion: @escaping () -> Void) {
        let root = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
        
        if let ad = AdManager.rewardedAd {
            ad.present(fromRootViewController: root!) {
                let reward = ad.adReward
                print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
                // TODO: Reward the user.
                print("Reward the user.")
                
                // Reklam kapatıldığında yapılacak işlemler
                completion()
            }
        } else {
            print("Ad wasn't ready")
        }
    }

    
}

// load Ad with AppTrackingTransparency
/*func loadRewardedAd() {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                DispatchQueue.main.async {
                    self.load()
                }
            })
        } else {
            // Fallback on earlier versions load
            self.load()
        }
    }
} */


/*
 // RewardedAd
 extension SubscriptionNavigationButton {
 
 func loadRewardedAd() {
 let request = GADRequest()
 
 GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/5224354917",
 request: request,
 completionHandler: { [self] ad, error in
 if let error = error {
 print("Failed to load rewarded ad with error: \(error.localizedDescription)")
 return
 }
 rewardedAd = ad
 print("Rewarded ad loaded.")
 
 let responseInfo = ad?.responseInfo
 print("\(String(describing: responseInfo))")
 
 let loadedAdNetworkResponseInfo = responseInfo?.loadedAdNetworkResponseInfo
 let adNetworkClassName = loadedAdNetworkResponseInfo?.adNetworkClassName
 
 // Know which ad network wins
 print("Ad Network Class Name:")
 print("\(String(describing: adNetworkClassName))")
 
 
 }
 )
 }
 
 func showRewardedAd() {
 
 let root = UIApplication.shared.connectedScenes
 .filter({$0.activationState == .foregroundActive})
 .compactMap({$0 as? UIWindowScene})
 .first?.windows
 .filter({$0.isKeyWindow}).first?.rootViewController
 
 if let ad = rewardedAd {
 ad.present(fromRootViewController: root!) {
 let reward = ad.adReward
 print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
 // TODO: Reward the user.
 }
 } else {
 print("Ad wasn't ready")
 }
 }
 } */


/*
 // RewardedInterstitialAd
 extension SubscriptionNavigationButton {
 
 func showRewardedInterstitialAd() {
 
 let root = UIApplication.shared.connectedScenes
 .filter({$0.activationState == .foregroundActive})
 .compactMap({$0 as? UIWindowScene})
 .first?.windows
 .filter({$0.isKeyWindow}).first?.rootViewController
 
 guard let rewardedInterstitialAd = rewardedInterstitialAd else {
 return print("Ad wasn't ready.")
 }
 
 rewardedInterstitialAd.present(fromRootViewController: root!) {
 let reward = rewardedInterstitialAd.adReward
 // TODO: Reward the user!
 }
 }
 
 func loadRewardedInterstitialAd() {
 
 //Ad load
 GADRewardedInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/6978759866", request: GADRequest()) { ad, error in
 if let error = error {
 return print("Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
 }
 
 self.rewardedInterstitialAd = ad
 }
 }
 
 }
 */
