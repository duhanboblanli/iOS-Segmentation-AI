//
//  ProfileView.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 25.10.2023.
//

import SwiftUI

@MainActor
final class UserViewModel: ObservableObject {
    
    static let shared = UserViewModel()
    
    @Published private(set) var user: DBUser? = nil
        
    func loadCurrentUser () async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        print("loadCurrentUser succesful")
    }
    
    func updateUserCoin(newCoin:Int, currentDay:Int) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserCoinStatus(userId: user.userId, userCoin: newCoin, currentDay: currentDay)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
            print("updateUserCoin succesful")
        }
    }
    
    func updateUserCoinAndPlan(newCoin:Int, currentDay:Int, newPlan: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserCoinAndPlanStatus(userId: user.userId, userCoin: newCoin, currentDay: currentDay, selectedPlan: newPlan)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
            print("updateUserCoinAndPlan succesful")
        }
    }
    
    func updateUserSelectedPlan(newPlan: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserSelectedPlanStatus(userId: user.userId, selectedPlan: newPlan)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
            print("updateUserSelectedPlan succesful")
        }
    }
    
    /*
    // Set is premium = true
    func togglePremiumStatus() {
        
        guard let user else { return }
        
        //let currentValue = user.isPremium ?? false

        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: true)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func togglePremiumStatusFalse() {
        
        guard let user else { return }
        
        //let currentValue = user.isPremium ?? false

        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: false)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    } */
    
    /*
    func togglePremiumStatus() {
        
        guard let user else { return }
        
        let currentValue = user.isPremium ?? false

        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    } */
}


// Usage Demo
/*
struct ProfileView: View {
    
    @StateObject private var viewModel = UserViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.userId)")
                
                if let isAnonymous = user.isAnonymous {
                    Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                }
                
                if let userCoin = user.userCoin {
                    Text("User Coin: \(userCoin)")
                }
                
                Button(action: {
                    viewModel.togglePremiumStatus()
                }, label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                })
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AuthSettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    ProfileView(showSignInView: .constant(false))
} */
    
