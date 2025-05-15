//
//  CarouselView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 15.05.2025.
//

import SwiftUI

///How to use generics:  https://www.youtube.com/watch?v=rx3uRICZr5I&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=9
///How to use scroll view APIs:  https://www.youtube.com/watch?v=hCpM95KHb_Q&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=35

struct CarouselView<Content: View, T: Hashable>: View {
    
    var items: [T]
    @State private var selection: T? = nil
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .scrollTransition(
                                .interactive.threshold(.visible(0.95)),
                                axis: .horizontal,
                                transition: { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                }
                            )
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                            .onChange(of: items.count, { oldValue, newValue in
                                updateSelectionIfNeeded()
                            })
                            .onAppear {
                                updateSelectionIfNeeded()
                            }
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selection ? .accent : .gray)
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

#Preview {
    CarouselView(items: AvatarModel.mocks, content: { item in
        HeroCellView(
            title: item.name,
            subtitle: item.characterDescription,
            imageName: item.profileImageName
        )
    })
    .padding()
}
