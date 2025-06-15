//
//  MockLocalAvatarPersistance.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 15.06.2025.
//

@MainActor
struct MockLocalAvatarPersistance: LocalAvatarPersistance {
    
    func addRecentAvatar(avatar: AvatarModel) throws {
        
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
