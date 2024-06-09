//
//  AuthenticationViewModel.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 25.10.2023.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    static let shared = AuthenticationViewModel()
    
    func signInAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
        print("signInAnonymous succesful")
    }
}

