//
//  ios_ai_cutterApp.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 6.07.2023.
//

import SwiftUI
import Firebase
import FBAudienceNetwork

@main
struct AICutterApp: App {
    
    @ObservedObject var storeVM = StoreVM.shared
    @ObservedObject var subscriptionVM = SubscriptionViewModel.shared
    @ObservedObject var navigationController = NavigationController.shared
    @ObservedObject var swipeAnimation = SubscribeSwipeAnimation.shared
    @StateObject var authViewModel = AuthenticationViewModel.shared
    @StateObject var userViewModel = UserViewModel.shared
    //@ObservedObject var persistenceController = PersistenceController.shared
    //@ObservedObject var pect1Controller = PECtl.shared
    //@ObservedObject var photoEditorDataController = PhotoEditorData.shared
 
    @AppStorage("isDarkModeOn") var isOn = false
    @AppStorage("isOnboarding") var isOnboarding = true
    @AppStorage("language") private var language = LocalizationService.shared.language
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // First, init method calls and then AppDelegate’s didFinishLaunchWithOptions method calls.
    init() {
        
        FirebaseApp.configure()
        
        // Facebook reklam izleme ayarları
        // Key Point: Mobile Ads SDK'yı başlatmadan önce bu bayrağı ayarlamanız gerekir
        FBAdSettings.setAdvertiserTrackingEnabled(true)
        
        // FetchRemoteConfig: AWS EndPoint
        RemoteConfigManager.shared.fetchRemoteConfig {
            if let url = URL(string: RemoteConfigManager.shared.endpoint_url) {
                @AppStorage("endPointURL") var endPointURL = url
            }
        }
        
        if isOnboarding {
            navigationController.path.append(NavigationScreen.onboarding)
        }
    }
    
    var body: some Scene {
        WindowGroup {
           
            /*
            PhotoEditView(image: UIImage(named: "png-example")!)
                .environmentObject(PECtl.shared)
                .environmentObject(PhotoEditorData.shared)
                .preferredColorScheme(.dark)
           */
        
            
         NavigationStack(path: $navigationController.path){
                MainView()
                    .environmentObject(navigationController)
                    //.environmentObject(aiCutViewModel)
                    .environmentObject(authViewModel)
                    .environmentObject(userViewModel)
                    .preferredColorScheme(isOn ? .dark : .light)
                    .onAppear {
                        AnalyticsManager.shared.logEvent(name: "ContentView_Appear")
                    }
                    .navigationDestination(for: NavigationScreen.self){ screen in
                        switch screen{
                        case .onboarding:
                            OnboardingContentView()
                                .environmentObject(navigationController)
                                .preferredColorScheme(isOn ? .dark : .light)
                                .onAppear {
                                    print("Onboarding Working")
                                    AnalyticsManager.shared.logEvent(name: "OnboardingContentView_Appear")
                                }
                        case .subscription:
                            SubscriptionContentView()
                                .environmentObject(navigationController)
                                .environmentObject(subscriptionVM)
                                .environmentObject(swipeAnimation)
                                .environmentObject(userViewModel)
                                //.environmentObject(storeVM)
                            
                        case .aicut:
                            let items = navigationController.getAICutItems()
                            if let image = items.0, let imageURL = items.1{
                                AICutView(image: image, imageURL: imageURL)
                                .environmentObject(navigationController)
                            }
                        case .settings:
                            SettingsView(selectedMenuItem: "settings-string".localized(LocalizationService.shared.language))
                                .environmentObject(navigationController)
                        case .FAQs:
                            FAQView(selectedMenuItem: "faq-string".localized(language))
                                .environmentObject(navigationController)
                        case .about:
                            AboutView(selectedMenuItem: "about-string".localized(language))
                                .environmentObject(navigationController)
                        case .language:
                            LanguageView()
                                .environmentObject(navigationController)
                        }
                    }
            } // ends of NStack
            
            
        }
    }
}


/*
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
} */


