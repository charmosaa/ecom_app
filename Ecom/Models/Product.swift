//
//  Product.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import Foundation

struct ProductList:  Codable {
    let items: [Product]
}

struct Product: Identifiable, Codable {
    var id: String { productId }

    let productId: String
    let description: String
    let price: String // e.g. "15.99 £"
    let promotions: [Promotion]
    var isFavorite: Bool
    let inStock: Int
    let image: String
    var imageName: String {
        image.replacingOccurrences(of: ".png", with: "")
    }
}

struct Promotion: Codable {
    let type: String // e.g. "discount" or "percentage"
    let value: String // e.g. "5.00 £" or "10%"
}

