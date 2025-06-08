//
//  AuthService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 7.06.2025.
//

import SwiftUI

// MARK: Bunun yerine Auth Manager yapıldı. Servisi direkt sayfalara bağlamak yerine.
//extension EnvironmentValues {
//    @Entry var authService: AuthService = MockAuthService()
//}

protocol AuthService: Sendable {
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
