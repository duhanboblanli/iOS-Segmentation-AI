//
//  UserManager.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 25.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    
    let userId: String
    let isAnonymous: Bool?
    //let email: String?
    //let photoUrl: String?
    let dateCreated: Date?
    //let isPremium: Bool?
    var userCoin: Int?
    var currentDay: Int?
    let selectedPlan: String?

    init (auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        //self.email = auth.email
        //self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        //self.isPremium = false
        self.userCoin = 0
        self.currentDay = 0
        self.selectedPlan = ""
    }
    
    init(
    userId: String,
    isAnonymous: Bool? = nil,
    //email: String? = nil,
    //photoUrl: String? = nil,
    dateCreated: Date? = nil,
    //isPremium: Bool? = nil,
    userCoin: Int? = nil,
    currentDay: Int? = nil,
    selectedPlan: String? = nil
    
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        //self.email = email
        //self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        //self.isPremium = isPremium
        self.userCoin = userCoin
        self.currentDay = currentDay
        self.selectedPlan = selectedPlan
        
    }
        
    /*mutating func togglePremiumStatus() {
        let currentValue = isPremium ?? false
        isPremium = !currentValue
    } */
    
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    func getUser (userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    // Update fields
    func updateUserCoinStatus(userId: String, userCoin: Int, currentDay: Int) async throws {
        let data : [String:Any] = [
            "user_coin" : userCoin,
            "current_day" : currentDay
        ]
        try await userDocument(userId: userId).updateData(data)
     }
    
    // Update fields
    func updateUserCoinAndPlanStatus(userId: String, userCoin: Int, currentDay: Int, selectedPlan: String) async throws {
        let data : [String:Any] = [
            "user_coin" : userCoin,
            "current_day" : currentDay,
            "selected_plan" : selectedPlan
        ]
        try await userDocument(userId: userId).updateData(data)
     }
    
    // Update fields
    func updateUserSelectedPlanStatus(userId: String, selectedPlan: String ) async throws {
        let data : [String:Any] = [
            "selected_plan" : selectedPlan
        ]
        try await userDocument(userId: userId).updateData(data)
     }
    
    // Change just one field - use if data already created
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data : [String:Any] = [
            "is_premium" : isPremium
        ]
        try await userDocument(userId: userId).updateData(data)
     }
    
    /*
    // Change all user data - use if data not created
    func updateUserPremiumStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData (from: user, merge: true, encoder: encoder)
     } */
}
