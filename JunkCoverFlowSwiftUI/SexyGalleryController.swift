//
//  SexyGalleryController.swift
//  SneakyGallery
//
//  Created by Nicky Taylor on 9/30/24.
//

import SwiftUI

class SexyGalleryController<GalleryType: Identifiable> {
    
    struct SexyGalleryItem: Identifiable {
        let item: GalleryType
        let x: CGFloat
        let y: CGFloat
        
        let scale: CGFloat
        let rotation: Angle
        
        let zIndex: Double
        
        var id: GalleryType.ID {
            item.id
        }
    }
    
    static func charmander(items: [GalleryType],
                           index: Int,
                           cardWidth: CGFloat,
                           cardHeight: CGFloat,
                           galleryWidth: CGFloat,
                           galleryHeight: CGFloat,
                           dragOffset: CGFloat) -> [SexyGalleryItem] {
        var result = [SexyGalleryItem]()
        
        if items.count <= 0 { return result }
        if cardWidth <= 10.0 { return result }
        if galleryWidth <= 10.0 { return result }
        
        var dragPercent = CGFloat(dragOffset)
        if galleryWidth > 10.0 {
            dragPercent /= galleryWidth
        }
        if dragPercent < -1.0 { dragPercent = -1.0 }
        if dragPercent > 1.0 { dragPercent = 1.0 }
        
        var centerX = galleryWidth / 2.0
        var centerY = galleryHeight / 2.0
        var centerZ = Double(1024.0)
        
        
        let hopAmountCenterToSide = round(cardWidth * 0.66)
        let hopAmountEdges = round(cardWidth * 0.15)
        
        let overshootAmount = round(cardWidth * 0.5)
        
        var numberOfCardsOnEachSide = 1
        var testX = centerX - cardWidth / 2.0 - hopAmountCenterToSide
        while testX >= (-overshootAmount) {
            numberOfCardsOnEachSide += 1
            testX -= hopAmountEdges
        }
        if numberOfCardsOnEachSide < 3 {
            numberOfCardsOnEachSide = 3
        }
        
        let cardCount = numberOfCardsOnEachSide + numberOfCardsOnEachSide + 1
        var arrayX = [CGFloat](repeating: 0.0, count: cardCount)
        var arrayZ = [Double](repeating: 0.0, count: cardCount)
        var arrayScale = [CGFloat](repeating: 0.0, count: cardCount)
        var arrayRotationDegrees = [CGFloat](repeating: 0.0, count: cardCount)
        
        arrayScale[numberOfCardsOnEachSide] = 1.0
        arrayScale[numberOfCardsOnEachSide - 1] = 0.85
        arrayScale[numberOfCardsOnEachSide + 1] = 0.85
        var arrayIndex = numberOfCardsOnEachSide - 2
        while arrayIndex >= 0 {
            arrayScale[arrayIndex] = 0.60
            arrayIndex -= 1
        }
        arrayIndex = numberOfCardsOnEachSide + 2
        while arrayIndex < cardCount {
            arrayScale[arrayIndex] = 0.60
            arrayIndex += 1
        }
        
        
        arrayRotationDegrees[numberOfCardsOnEachSide] = 0.0
        arrayRotationDegrees[numberOfCardsOnEachSide - 1] = 45
        arrayRotationDegrees[numberOfCardsOnEachSide + 1] = -45
        arrayIndex = numberOfCardsOnEachSide - 2
        while arrayIndex >= 0 {
            arrayRotationDegrees[arrayIndex] = 60
            arrayIndex -= 1
        }
        arrayIndex = numberOfCardsOnEachSide + 2
        while arrayIndex < cardCount {
            arrayRotationDegrees[arrayIndex] = -60
            arrayIndex += 1
        }
        
        
        
        arrayX[numberOfCardsOnEachSide] = centerX
        
        var x = centerX - hopAmountCenterToSide
        arrayIndex = numberOfCardsOnEachSide - 1
        while arrayIndex >= 0 {
            arrayX[arrayIndex] = x
            x -= hopAmountEdges
            arrayIndex -= 1
        }
        
        x = centerX + hopAmountCenterToSide
        arrayIndex = numberOfCardsOnEachSide + 1
        while arrayIndex < cardCount {
            arrayX[arrayIndex] = x
            x += hopAmountEdges
            arrayIndex += 1
        }
        
        print("numberOfCardsOnEachSide = \(numberOfCardsOnEachSide)")
        
        
        
        /*
         result.append(SexyGalleryItem(item: items[index],
         x: galleryWidth / 2.0 - cardWidth / 2 + dragOffset,
         y: galleryHeight / 2.0 - cardHeight / 2.0,
         rotationX: Angle(degrees: dragPercent * 180.0)))
         */
        
        var galleryIndex = index - cardCount
        galleryIndex = galleryIndex % items.count
        if galleryIndex < 0 {
            galleryIndex += items.count
        }
        
        
        for cardIndex in 0..<cardCount {
            let item = items[galleryIndex]
            let currentCardX = arrayX[cardIndex]
            let currentCardScale = arrayScale[cardIndex]
            let currentCardRotationDegrees = arrayRotationDegrees[cardIndex]
            let currentCardWidth = cardWidth * currentCardScale
            
            let _cardX: CGFloat
            let _cardY: CGFloat
            let _cardScale: CGFloat
            let _cardRotationDegrees: CGFloat
            let _cardWidth: CGFloat
            if (dragPercent < 0.0) && cardIndex > 0 {
                let percent = -dragPercent
                
                let previousCardX = arrayX[cardIndex - 1]
                let previousCardScale = arrayScale[cardIndex - 1]
                let previousCardRotationDegrees = arrayRotationDegrees[cardIndex - 1]
                let previousCardWidth = cardWidth * previousCardScale
                
                _cardX = currentCardX + (previousCardX - currentCardX) * percent
                _cardScale = currentCardScale + (previousCardScale - currentCardScale) * percent
                _cardRotationDegrees = currentCardRotationDegrees + (previousCardRotationDegrees - currentCardRotationDegrees) * percent
                _cardWidth = currentCardWidth + (previousCardWidth - currentCardScale) * percent
                
            } else if (dragPercent > 0.0) && cardIndex < (cardCount - 1) {
                
                let percent = dragPercent
                
                let nextCardX = arrayX[cardIndex + 1]
                let nextCardScale = arrayScale[cardIndex + 1]
                let nextCardRotationDegrees = arrayRotationDegrees[cardIndex + 1]
                let nextCardWidth = cardWidth * nextCardScale
                
                _cardX = currentCardX + (nextCardX - currentCardX) * percent
                _cardScale = currentCardScale + (nextCardScale - currentCardScale) * percent
                _cardRotationDegrees = currentCardRotationDegrees + (nextCardRotationDegrees - currentCardRotationDegrees) * percent
                _cardWidth = currentCardWidth + (nextCardWidth - currentCardScale) * percent
                
            } else {
                _cardX = currentCardX
                _cardScale = currentCardScale
                _cardRotationDegrees = currentCardRotationDegrees
                _cardWidth = currentCardWidth
            }
            
            result.append(SexyGalleryItem(item: item,
                                          x: _cardX - _cardWidth * 0.5,
                                          y: centerY - cardHeight * 0.5,
                                          scale: _cardScale,
                                          rotation: Angle(degrees: _cardRotationDegrees),
                                          zIndex: 1000.0))
            
            
            galleryIndex += 1
            if galleryIndex >= items.count {
                galleryIndex = 0
            }
            
        }
        
        return result
    }
    
}

