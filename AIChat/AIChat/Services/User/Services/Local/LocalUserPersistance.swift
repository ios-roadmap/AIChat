//
//  LocalUserPersistence.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(_ user: UserModel?) throws
}
