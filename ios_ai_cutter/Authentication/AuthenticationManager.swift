//
//  AuthenticationManager.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 25.10.2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    
    let uid: String
    //let email: String?
    //let photoUrl: String?
    let isAnonymous: Bool
    
    init (user: User) {
        
        self.uid = user.uid
        //self.email = user.email
        //self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser () throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
        
    }
    
    @discardableResult
    func signInAnonymous ( ) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    /*@discardableResult
    func createUser (email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser (withEmail: email, password: password)
        return AuthDataResultModel (user: authDataResult.user)
    } */
    
    /*func signOut() throws {
        try Auth.auth().signOut()
    } */
    
}
