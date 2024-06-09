//
//  AnalyticsView.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 25.09.2023.
//

import SwiftUI
// Tutorial
struct AnalyticsView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Click me!") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_ButtonClick")
            }
            
            Button("Click me too!") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_SecondaryButtonClick", params: [ "screen_title" : "Hello, world!" ])
            }
        }// ends of VStack
        .analyticsScreen(name: "AnalyticsView")
        .onAppear {
            //For event
            AnalyticsManager.shared.logEvent(name: "AnalyticsView_Appear")

            // For screen
            AnalyticsManager.shared.logEvent(screenName: "Birinci Ekran")
        }
        
        .onDisappear {
            
            AnalyticsManager.shared.logEvent(name: "AnalyticsView_Disappear")
            AnalyticsManager.shared.setUserId(userId: "ABC123")
            AnalyticsManager.shared.setUserProperty(value: true.description, property: "user_is_premium")
            
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
