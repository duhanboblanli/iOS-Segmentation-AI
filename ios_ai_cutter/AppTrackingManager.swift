//
//  AppTrackingManager.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 1.10.2023.
//

import SwiftUI
import AppTrackingTransparency

final class AppTrackingManager {
    
    static let shared = AppTrackingManager()
    private init() { }
    
    func requestDataPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("ATT Authorized")
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("ATT Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("ATT Not Determined")
                case .restricted:
                    print("ATT Restricted")
                @unknown default:
                    print("ATT Unknown")
                }
            })
        } else {
            //you got permission to track, iOS 14 is not yet installed
        }
    }
}
