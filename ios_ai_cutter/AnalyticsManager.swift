//
//  AnalyticsManager.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 1.10.2023.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private init() { }
    
    // LogEvent for special parameter event
    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    // LogEvent for screen_view event
    // Use with onAppear
    func logEvent(screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: screenName ])
    }
    
    func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    // Set properties needed like AnalyticsEventAddPaymentInfo
    func setUserProperty(value: String?, property: String) {
        Analytics.setUserProperty(value, forName: property)
    }
}
