//
//  UserModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI

struct UserModel {
    
    let userId: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else {
            return .accent
        }
        
        return Color(hex: profileColorHex)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            UserModel(
                userId: "user_123",
                dateCreated: now.addingTimeInterval(-86400),
                didCompleteOnboarding: true,
                profileColorHex: "#FF5733"
            ),
            UserModel(
                userId: "user_456",
                dateCreated: now.addingTimeInterval(-172800),
                didCompleteOnboarding: false,
                profileColorHex: "#33C1FF"
            ),
            UserModel(
                userId: "user_789",
                dateCreated: now.addingTimeInterval(-259200),
                didCompleteOnboarding: true,
                profileColorHex: "#8E44AD"
            ),
            UserModel(
                userId: "user_321",
                dateCreated: now.addingTimeInterval(-432000),
                didCompleteOnboarding: nil,
                profileColorHex: nil
            )
        ]
    }
}
