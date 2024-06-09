//
//  SubscriptionViewModel.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 28.08.2023.
//

import Foundation
import SwiftUI
import StoreKit

class SubscriptionViewModel: ObservableObject{
    
    @AppStorage("isPurchased") var isPurchased : Bool?
    @AppStorage("isPlanChanged") var isPlanChanged : Bool?
    @AppStorage("selectedPlan") var selectedPlan : String?
    private var upgradePlan = ""

    static let shared = SubscriptionViewModel()
        
    let subscriptionMethods: [SubscriptionMethod] = [
        .Onetime,
        .Weekly,
        .Yearly
    ]
    
    var orderOfMethods: [Int]{
        didSet{
            selectedMethod = subscriptionMethods[orderOfMethods[1]]
        }
    }
    
    var selectedMethod: SubscriptionMethod{
        didSet{
            print("selected Method")
            print(selectedMethod)
            
        }
    }
    
    init() {
        orderOfMethods = Array(subscriptionMethods.indices)
        selectedMethod = subscriptionMethods[orderOfMethods[1]]

    }
}

extension SubscriptionViewModel{
    
    func tappedToSubscribe() async {
        AnalyticsManager.shared.logEvent(name: "TappedToSubscribe")
        
        for product in StoreVM.shared.subscriptions {
            if product.id == "\(self.selectedMethod)" {
                do {
                    if try await StoreVM.shared.purchase(product) != nil {
                        DispatchQueue.main.async {
                            self.isPurchased = true
                            
                            if "\(self.selectedMethod)" == "Weekly" {
                                self.selectedPlan = "Weekly"
                            }
                            else if "\(self.selectedMethod)" == "Yearly" {
                                self.selectedPlan = "Yearly"
                            } else {
                                self.selectedPlan = "Onetime"
                            }
                        }
                    }
                } catch {
                    print("Purchase failed for product with id: \(product.id)")
                }
            }
        }
    }
    
    func tappedToChangePlan() async {
        
        AnalyticsManager.shared.logEvent(name: "TappedToChangePlan")
        await MainActor.run {
            
            if self.selectedPlan == "Weekly" {
                self.upgradePlan = "Yearly"
            }
            else if self.selectedPlan == "Yearly" {
                self.upgradePlan = "Weekly"
            }

        }
        for product in StoreVM.shared.subscriptions {
            if product.id == self.upgradePlan {

                do {
                    if try await StoreVM.shared.purchase(product) != nil {
                        DispatchQueue.main.async {
                            self.isPlanChanged = true
                            self.isPurchased = true // not necessery
                            self.selectedPlan = self.upgradePlan
                        }
                    }
                } catch {
                    print("Purchase failed for product with id: \(product.id)")
                }
            }
        }
    }
    
    func tappedToRestore() {
        
       // self.isPurchased = false // For test
        
        AnalyticsManager.shared.logEvent(name: "TappedToRestore")
        Task {
            // Reauthorization for maintenance
            try? await AppStore.sync()
            
            for await result in Transaction.currentEntitlements {
                if case let .verified(transaction) = result {
                    
                    // Switch to the main thread for UI updates
                    await MainActor.run {
                        print("Transaction: ", transaction)
                    }
                }
            }
        }
    }

    func tappedToTermsConditions(){
        AnalyticsManager.shared.logEvent(name: "TappedToTermsConditions")
        RemoteConfigManager.shared.fetchRemoteConfig {
            if let url = URL(string: RemoteConfigManager.shared.terms_conditions) {
                UIApplication.shared.open(url) }
        }
    }
    
    func tappedToPrivacyPolicy(){
        AnalyticsManager.shared.logEvent(name: "TappedToPrivacyPolicy")
        RemoteConfigManager.shared.fetchRemoteConfig {
            if let url = URL(string: RemoteConfigManager.shared.privacy_policy) {
                UIApplication.shared.open(url) }
        }
    }
        
}

func showPopupMessage(title:String, message: String) {
    
    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )
    
    let okAction = UIAlertAction(
        title: "Ok",
        style: .default,
        handler: nil
    )
    
    alertController.addAction(okAction)
    
    if let viewController = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.rootViewController {
        viewController.present(alertController, animated: true, completion: nil)
    }
    else {
        print("view controller not found")
    }
}
