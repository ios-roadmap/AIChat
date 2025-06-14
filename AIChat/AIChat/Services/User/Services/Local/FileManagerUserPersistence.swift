//
//  FileManagerUserPersistence.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

import Foundation

struct FileManagerUserPersistence: LocalUserPersistence {
    
    private let userDocumentKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(_ user: UserModel?) {
        try? FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
