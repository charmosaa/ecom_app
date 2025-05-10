//
//  Product.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

/*
 JSON PRODUCT STRUCTURE
 {
     "productId": "f0e9d8c7-b6a5-4321-fedc-ba9876543210",
     "description": "Stainless Steel Water Bottle",
     "price": "22.50 £",
     "promotions": [
         {
             "type": "discount",
             "value": "5.00 £"
         }
     ],
     "isFavorite": false,
     "inStock": 120,
     "image": "bottle.png"
 }
*/
 

import Foundation

struct ProductList:  Codable {
    let items: [Product]
}

struct Product: Identifiable, Codable {
    var id: String { productId }

    let productId: String
    let description: String
    let price: String
    let promotions: [Promotion]
    var isFavorite: Bool
    let inStock: Int
    let image: String
    var imageName: String {
        image.replacingOccurrences(of: ".png", with: "")
    }
}

struct Promotion: Codable {
    let type: String
    let value: String
}

