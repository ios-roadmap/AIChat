//
//  ImageLoaderView.swift
//  AIChat
//
//  Created by Ömer Faruk Öztürk on 7.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    let urlString: String
    var forceTransitionAnimation: Bool = false
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: .init(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            }
            .clipped()
            .ifStatisfiedCondition(forceTransitionAnimation, transform: { content in
                content
                    .drawingGroup() // View hiyerarşisini tek bir bitmap olarak işler.
                /// Bu modifier, karmaşık görsel yapıların GPU üzerinden daha performanslı çizilmesini sağlar.
                /// Özellikle opacity, blur, mask gibi efektler yoğun kullanıldığında çizim yükünü azaltmak için tercih edilir.
                /// Ancak her durumda kullanılmamalıdır — bitmap render belleği artırır ve dokunma (hit-testing) problemleri yaratabilir.
                /// Animasyonlu yapılarda gereksiz yere invalidate olabileceği için dikkatli kullanılmalıdır.
            })
    }
}

#Preview {
    ImageLoaderView(urlString: Constants.randomImage)
        .frame(width: 100, height: 200)
        .anyButton(option: .highlight) {
            
        }
}
