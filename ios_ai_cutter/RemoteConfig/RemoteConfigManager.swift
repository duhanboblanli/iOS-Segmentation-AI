//
//  RemoteConfigManager.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 30.10.2023.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigManager: ObservableObject {
    
    static let shared = RemoteConfigManager()
    @Published var subscribed_user_coin: Int = 0
    @Published var default_user_coin: Int = 0
    @Published var terms_conditions: String = ""
    @Published var privacy_policy: String = ""
    
    // URL Components
    @Published var endpoint_url: String = ""
    
    private var remoteConfig: RemoteConfig
    private var completion: (() -> Void)?
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // NOTE: This value only for debugging
        remoteConfig.configSettings = settings
    }
    
    func fetchRemoteConfig(completion: (() -> Void)? = nil) {
        self.completion = completion
        remoteConfig.fetch { (_, error) -> Void in
            if let error {
                print("Config not fetched")
                print("Error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    
                    self.readRemoteConfigData()
                }
                self.remoteConfig.activate { changed, error in
                    if let error {
                        print("Activate remote config data error:", error)
                    } else if changed {
                        print("Successfully fetched and activated the remote config data")
                    } else {
                        print("Failed to activate remote config data (Nothing changed on firebase)")
                    }
                }
            }
        }
    }
    
    /*func fetchRemoteConfig(completion: (() -> Void)? = nil) {
     self.completion = completion
     remoteConfig.fetch { (_, error) -> Void in
     if let error {
     print("Config not fetched")
     print("Error: \(error.localizedDescription)")
     } else {
     DispatchQueue.main.async {
     self.completion?()
     self.readRemoteConfigData()
     }
     self.remoteConfig.activate { changed, error in
     if let error {
     print("Activate remote config data error:", error)
     } else if changed {
     print("Successfully fetched and activated the remote config data")
     
     } else {
     print("Failed to activate remote config data (Nothing changed on firebase)")
     }
     }
     }
     }
     } */
    
    
    func readRemoteConfigData() {
        let remoteConfigValue =  remoteConfig["ios_segment_ai"]
        if let json = remoteConfigValue.jsonValue as? [String: Any],
           let subsCoin = json["subscribed_user_coin"] as? Int,
           let defaultCoin = json["default_user_coin"] as? Int,
           let termsConditions = json["terms_conditions"] as? String,
           let privacyPolicy = json["privacy_policy"] as? String,
           let endpointUrl = json["endpoint_url"] as? String {
            
            DispatchQueue.main.async {
                self.subscribed_user_coin = subsCoin
                self.default_user_coin = defaultCoin
                self.terms_conditions = termsConditions
                self.privacy_policy = privacyPolicy
                self.endpoint_url = endpointUrl
                self.completion?()
            }
        }
    }
}



