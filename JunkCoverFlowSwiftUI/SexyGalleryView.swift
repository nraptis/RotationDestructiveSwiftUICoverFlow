//
//  SexyGalleryView.swift
//  SneakyGallery
//
//  Created by Nicky Taylor on 9/27/24.
//

import SwiftUI

struct SexyGalleryView<GalleryType: Identifiable, GalleryViewType: View>: View {
    
    var animatableData: CGFloat {
        dragGestureState.x
    }
    
    enum DragState {
        case idle
        case dragging(x: CGFloat)
        var x: CGFloat {
            switch self {
            case .idle:
                return 0.0
            case .dragging(let x):
                return x
            }
        }
    }
    
    let width: CGFloat
    let height: CGFloat
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    @Binding var galleryPage: Int
    let items: [GalleryType]
    let content: (GalleryType) -> GalleryViewType
    init(width: CGFloat,
         height: CGFloat,
         cardWidth: CGFloat,
         cardHeight: CGFloat,
         items: [GalleryType],
         galleryPage: Binding<Int>,
         content: @escaping (GalleryType) -> GalleryViewType) {
        self.width = width
        self.height = height
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self.items = items
        self.content = content
        _galleryPage = galleryPage
        self.isDragging = isDragging
    }
    
    @State var isDragging = false
    @State private var currentGalleryTypeIndex = 0
    @GestureState private var dragGestureState = DragState.idle
    
    var body: some View {
        
        let charmanders = SexyGalleryController.charmander(items: items,
                                                           index: galleryPage,
                                                           cardWidth: cardWidth,
                                                           cardHeight: cardHeight,
                                                           galleryWidth: width,
                                                           galleryHeight: height,
                                                           dragOffset: dragGestureState.x)
        
        return GeometryReader { _ in
            ForEach(charmanders) { charmander in
                content(charmander.item)
                    .frame(width: cardWidth * charmander.scale,
                           height: cardHeight * charmander.scale)
                    .rotation3DEffect(charmander.rotation, axis: (x: 0.0, y: 1.0, z: 0.0))
                    //.scaleEffect(charmander.scale, anchor: UnitPoint.center)
                    
                    .offset(x: charmander.x,
                            y: charmander.y)
                    .zIndex(charmander.zIndex)
                
            }
        }
                .frame(width: width, height: height)
        .gesture(
            DragGesture(minimumDistance: 2.0, coordinateSpace: .local)
                .updating($dragGestureState, body: dragUpdating)
                .onChanged(dragChanged(dragValue:))
                .onEnded(dragEnded(dragValue:)))
        .animation(.interpolatingSpring(
            stiffness: Double(width),
            damping: Double(width / 6.0)),
                   value: dragGestureState.x)
    }
    
    private func dragUpdating(dragValue: DragGesture.Value, dragGestureState: inout DragState, transaction: inout Transaction) {
        var translation = dragValue.translation.width
        dragGestureState = .dragging(x: translation)
    }
    
    private func dragChanged(dragValue: DragGesture.Value) {
        
        if isDragging == false {
            isDragging = true
            
        }
        
        
    }
    
    private func dragEnded(dragValue: DragGesture.Value) {
        
        let halfWidth = (width / 2.0)
        var newGalleryPage = galleryPage
        if dragValue.predictedEndTranslation.width > halfWidth || dragValue.translation.width > halfWidth {
            newGalleryPage -= 1
            if newGalleryPage < 0 {
                newGalleryPage = items.count - 1
            }
        } else if dragValue.predictedEndTranslation.width < -halfWidth || dragValue.translation.width < -halfWidth {
            newGalleryPage += 1
            if newGalleryPage >= items.count {
                newGalleryPage = 0
            }
        }
        
        galleryPage = newGalleryPage
        isDragging = false
        
    }
    
}

/*
#Preview {
    GeometryReader { geometry in
        let width = geometry.size.width
        let height = min(geometry.size.height * 0.5, 200.0)
        return SexyGalleryView(geometry: geometry, images: images, width: width, height: height) {
            ZStack {
                
            }
        }
        
    }
}
*/
