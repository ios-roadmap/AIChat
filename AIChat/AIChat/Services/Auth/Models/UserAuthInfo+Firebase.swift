//
//  UserAuthInfo+Firebase.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 1.06.2025.
//

import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
