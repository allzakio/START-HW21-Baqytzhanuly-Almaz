//
//  Card.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/11/23.
//

import Foundation

class Cards: Codable {
    var cards: [Card] = []
}

class Card: Codable {
    let name: String
    let imageUrl: String?
    let text: String?
}
