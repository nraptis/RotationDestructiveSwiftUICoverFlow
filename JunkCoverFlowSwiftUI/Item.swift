//
//  Item.swift
//  SexyZoomGallery
//
//  Created by Nicky Taylor on 9/22/24.
//

import Foundation

struct Item {
    let emoji: String
}

extension Item: Identifiable {
    var id: String {
        return emoji
    }
}

func createItems() -> [Item] {
    [
        Item(emoji: "🍒"),
        Item(emoji: "🍉"),
        Item(emoji: "🍐"),
        Item(emoji: "🍓"),
        Item(emoji: "🍌"),
        Item(emoji: "🥥"),
        Item(emoji: "🍊"),
        Item(emoji: "🍇"),
        Item(emoji: "🍎"),
        Item(emoji: "🍏"),
        Item(emoji: "🍑"),
        Item(emoji: "🍅"),
        Item(emoji: "🥭"),
        Item(emoji: "🥕"),
        Item(emoji: "🥦"),
        Item(emoji: "🫛"),
        Item(emoji: "🍄‍🟫"),
        Item(emoji: "🍞"),
        Item(emoji: "🥐"),
        Item(emoji: "🥖"),
        Item(emoji: "🍋"),
        Item(emoji: "🫒"),
        Item(emoji: "🍋‍🟩"),
        Item(emoji: "🥑"),
        Item(emoji: "🌶️"),
        Item(emoji: "🌽"),
        Item(emoji: "🍈"),
        Item(emoji: "🍍"),
        Item(emoji: "🫐"),
        Item(emoji: "🥝"),
        Item(emoji: "🍆"),
        Item(emoji: "🥔"),
        Item(emoji: "🫑"),
        Item(emoji: "🥒"),
        Item(emoji: "🥬"),
        Item(emoji: "🧄"),
        Item(emoji: "🧅"),
        Item(emoji: "🥜"),
        Item(emoji: "🫘"),
        Item(emoji: "🌰"),
        Item(emoji: "🫚"),
        Item(emoji: "🫓"),
        Item(emoji: "🍦"),
        Item(emoji: "🍧"),
        Item(emoji: "🍨"),
        Item(emoji: "🍪"),
        Item(emoji: "🍩"),
    ]
}
