//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 31.05.2025.
//

import FirebaseAuth
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = .init()
}

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?
    
    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}

struct FirebaseAuthService {
    func getAuthenticatedUser() -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        
        return UserAuthInfo(user: user)
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        let user = UserAuthInfo(user: result.user)
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}

//Why struct?
///✅ No stored state: The struct doesn’t hold any internal data; it's stateless.
///✅ No reference sharing needed: There's no need to share the same instance across the app.
///✅ No inheritance required: There's no subclassing or override logic involved.
///✅ Lightweight & safe: struct offers value semantics, better for thread safety.
///✅ Functional style: All methods behave like pure functions, ideal for structs.
///❌ Use class only if:
///You need to observe auth state changes and keep internal state
///You need reference semantics (e.g. shared instance)
///You plan to subclass for mocking/testing
