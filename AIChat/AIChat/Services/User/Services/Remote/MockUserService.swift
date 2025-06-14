//
//  MockUserService.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 14.06.2025.
//

struct MockUserService: RemoteUserService {
    var currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func saveUser(user: UserModel) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        
    }
    
    func doSomething(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continutation in
            if let currentUser {
                continutation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
}
