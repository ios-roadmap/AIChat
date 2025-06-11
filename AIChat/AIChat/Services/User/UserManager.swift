//
//  UserManager.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 11.06.2025.
//

import SwiftUI

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func doSomething(userId: String) -> AsyncThrowingStream<UserModel, Error>
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: UserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
    
    func doSomething(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
//    func doSomething(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
//        collection.streamDocument(id: userId, onListenerConfigured: onListenerConfigured)
//    }
}

@MainActor
@Observable
class UserManager {
    
    private let service: UserService
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in service.doSomething(userId: userId) {
                    self.currentUser = value
                    print("Successfully listened to user: \(value.userId)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }
}

dakika 7.00
