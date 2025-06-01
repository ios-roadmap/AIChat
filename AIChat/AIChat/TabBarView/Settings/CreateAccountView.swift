//
//  CreateAccountView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    
    var title: String = "Create Account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account."
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10
            )
            .frame(height: 55)
            .anyButton(option: .press) {
                onSignInApplePressed()
            }
            
            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }
    
    func onSignInApplePressed() {
        Task {
            do {
                let result = try await authService.signInApple()
                
                print("Did sign in with apple!")
                dismiss()
            } catch {
                print("Error signing in with Apple")
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
