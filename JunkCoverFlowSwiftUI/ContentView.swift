//
//  ContentView.swift
//  SneakyGallery
//
//  Created by Nicky Taylor on 9/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(Controller.self) var controller
    
    @State var galleryPage = 0
    var body: some View {
        GeometryReader { geometry in
            
            let galleryWidth: CGFloat
            let galleryHeight: CGFloat
            var cardWidth: CGFloat
            let cardHeight: CGFloat
            
            if geometry.size.width > geometry.size.height {
                galleryWidth = geometry.size.width
                galleryHeight = (UIDevice.current.userInterfaceIdiom == .pad) ? 316.0 : 196.0
                cardWidth = round(galleryWidth * 0.6)
                cardHeight = round(galleryHeight * 0.96)
            } else {
                galleryWidth = geometry.size.width
                galleryHeight = (UIDevice.current.userInterfaceIdiom == .pad) ? 358.0 : 236.0
                cardWidth = round(galleryWidth * 0.76)
                cardHeight = round(galleryHeight * 0.9)
            }
            let maxWidth = round(cardHeight * 1.3333333333)
            if cardWidth > maxWidth {
                cardWidth = maxWidth
            }
            
            return SexyGalleryView(width: galleryWidth,
                                   height: galleryHeight,
                                   cardWidth: cardWidth,
                                   cardHeight: cardHeight,
                                   items: controller.items,
                                   galleryPage: $galleryPage) { item in
                GeometryReader { cardGeometry in
                    ZStack {
                        Text(item.emoji)
                            .font(.system(size: (UIDevice.current.userInterfaceIdiom == .pad) ? 156.0 : 116.0))
                    }
                    .frame(width: cardGeometry.size.width,
                           height: cardGeometry.size.height)
                    .background(RoundedRectangle(cornerRadius: 24.0).foregroundStyle(Color.red))
                    .opacity(0.5)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(Controller())
}
