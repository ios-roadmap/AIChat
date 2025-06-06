//
//  OnboardingColorView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 10.05.2025.
//

import SwiftUI

struct OnboardingColorView: View {
    
    @State private var selectedColor: Color?
    
    let profileColors: [Color] = [
        .red, .green, .orange, .blue, .mint, .purple, .cyan, .teal, .indigo
    ]
    
    var body: some View {
        ScrollView {
            colorGrid
                .padding(.horizontal, 24)
        }
        .safeAreaInset(edge: .bottom, content: {
            ZStack {
                if let selectedColor {
                    ctaButton(selectedColor: selectedColor)
                        .transition(AnyTransition.move(edge: .bottom))
                }
            }
            .padding(24)
            .background(Color(uiColor: .systemBackground))
        })
        .animation(.bouncy, value: selectedColor)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var colorGrid: some View {
        LazyVGrid(
            columns: .init(repeating: .init(.flexible(), spacing: 16), count: 3),
            alignment: .center,
            spacing: 16,
            pinnedViews: [.sectionHeaders],
            content: {
                Section {
                    ForEach(profileColors, id: \.self) { color in
                        Circle()
                            .fill(.accent)
                            .overlay {
                                color
                                    .clipShape(.circle)
                                    .padding(selectedColor == color ? 8 : 0)
                            }
                        
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                } header: {
                    Text("Select a profile color")
                        .font(.headline)
                }
            }
        )
    }
    
    private func ctaButton(selectedColor: Color) -> some View {
        NavigationLink {
            OnboardingComletedView(selectedColor: selectedColor)
        } label: {
            Text("Continue")
                .callToActionButton()
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingColorView()
    }
    .environment(AppState())
}
