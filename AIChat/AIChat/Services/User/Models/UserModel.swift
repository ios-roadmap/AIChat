//
//  UserModel.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI
import IdentifiableByString

struct UserModel: Codable, StringIdentifiable {
    
    var id: String {
        userId
    }
    
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
        )
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
                creationDate: now.addingTimeInterval(-86400),
                didCompleteOnboarding: true,
                profileColorHex: "#FF5733"
            ),
            UserModel(
                userId: "user_456",
                creationDate: now.addingTimeInterval(-172800),
                didCompleteOnboarding: false,
                profileColorHex: "#33C1FF"
            ),
            UserModel(
                userId: "user_789",
                creationDate: now.addingTimeInterval(-259200),
                didCompleteOnboarding: true,
                profileColorHex: "#8E44AD"
            ),
            UserModel(
                userId: "user_321",
                creationDate: now.addingTimeInterval(-432000),
                didCompleteOnboarding: nil,
                profileColorHex: nil
            )
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
    }
}
