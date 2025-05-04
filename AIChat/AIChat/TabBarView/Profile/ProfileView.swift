//
//  ProfileView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct ProfileView: View {

    @State private var showSettingsView: Bool = false

    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
    }

    private var settingsButton: some View {
        Button {
            onSettingsButtonPressed()
        } label: {
            Image(systemName: "gear")
                .font(.headline)
        }
    }

    private func onSettingsButtonPressed() {
        showSettingsView.toggle()
    }
}

#Preview {
    ProfileView()
}
