//
//  ButtonViewModifiers.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 19.05.2025.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
            .cornerRadius(6)
    }
}

struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
            .cornerRadius(6)
    }
}

enum ButtonStyleOption {
    case press, highlight, plain
}

extension View {
    
    @ViewBuilder
    func anyButton(option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .press:
            pressableButton(action: action)
        case .highlight:
            highlightButton(action: action)
        case .plain:
            plainButtonStyle(action: action)
        }
    }
    
    private func plainButtonStyle(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(.plain)
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    VStack {
        Text("Plain")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(option: .plain) {
                print("plainned")
            }
        
        Text("Highlight")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(option: .highlight, action: {
                print("highlightButton")
            })
        
        Text("Press")
            .padding()
            .frame(maxWidth: .infinity)
            .callToActionButton()
            .anyButton(option: .press, action: {
                print("pressableButton")
            })
    }
    .padding()
}
