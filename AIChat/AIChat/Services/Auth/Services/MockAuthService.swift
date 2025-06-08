//
//  MockAuthService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 7.06.2025.
//

import Foundation

struct MockAuthService: AuthService {
    
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        (UserAuthInfo.mock(isAnonymous: true), true)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        (UserAuthInfo.mock(), false)
    }
    
    func signOut() throws {
        
    }
    
    func deleteAccount() async throws {
        
    }
}
