//
//  OnboardingView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AppState.self) private var root
    
    @State var imageName: String = Constants.randomImage
    @State var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea(.all, edges: .top)
                
                titleSection
                    .padding(.top, 24)
                
                ctaButtons
                    .padding(.top, 16)
                
                policyLinks
            }
        }
        .sheet(
            isPresented: $showSignInView,
            content: {
                CreateAccountView(
                    title: "Sign in",
                    subtitle: "Connect to an existing account.",
                    onDidSignIn: { isNewUser in
                        handleDidSignIn(isNewUser: isNewUser)
                    }
                )
                .presentationDetents([.medium])
        })
    }
    
    private var titleSection: some View {
        VStack {
            Text("AI Chat 🤙")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Youtube @ SwiftfulThinking")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            
            Text("Already have an account? Sign in!")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    onSignInPressed()
                }
        }
        .padding(16)
    }
    
    private func handleDidSignIn(isNewUser: Bool) {
        if isNewUser {
            // Do nothing, user goes through onboarding
        } else {
            // Push into tabbar view
            root.updateViewState(showTabBarView: true)
        }
    }
    
    private func onSignInPressed() {
        showSignInView = true
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: .init(string: Constants.termsOfServiceUrl)!) {
                Text("Terms of Service")
            }
            
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            
            Link(destination: .init(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Policy")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
