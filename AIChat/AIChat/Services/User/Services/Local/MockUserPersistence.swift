//
//  MockUserPersistence.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

struct MockUserPersistence: LocalUserPersistence {
    var currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(_ user: UserModel?) throws {
        
    }
}
