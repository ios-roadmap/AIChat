//
//  RemoteUserService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
    func doSomething(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}
