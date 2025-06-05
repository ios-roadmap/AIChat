//
//  FirebaseAuthService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 31.05.2025.
//

import FirebaseAuth
import SwiftUI
import SignInAppleAsync

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = .init()
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
        return result.asAuthInfo
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = await SignInWithAppleHelper()
        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        // MARK: Try to link to existing anonymous account
        if let user = Auth.auth().currentUser,
           user.isAnonymous {
            
            do {
                let result = try await user.link(with: credential)
                return result.asAuthInfo
            } catch let error as NSError {
                let authError = AuthErrorCode(rawValue: error.code)
                switch authError {
                case .providerAlreadyLinked, .credentialAlreadyInUse:
                    if let secondaryCredential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: secondaryCredential)
                        return result.asAuthInfo
                    }
                default:
                    break
                }
            }
        }
        
        
        // MARK: Otherwise sign in to new account
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            fatalError("No user signed in.")
        }
        try await user.delete()
    }
    
    enum AuthError: LocalizedError {
        case userNotFound
        
        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Current authenticated user not found."
            }
        }
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

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
