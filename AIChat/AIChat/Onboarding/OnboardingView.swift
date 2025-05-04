//
//  OnboardingView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .frame(maxHeight: .infinity)
                NavigationLink {
                    OnboardingComletedView()
                } label: {
                    Text("Get Started")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    OnboardingView()
}
