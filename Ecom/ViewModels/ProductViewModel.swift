//
//  ProductView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []     // all the products
    @Published var basket: [String: Int] = [:]  // stores productId and their count
    @Published var alertStockMsg: String? = nil // alert message when not enough stock
    
    init() {
        loadProducts()
    }

    func loadProducts() {
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(ProductList.self, from: data) else {
            print("Failed to load items.json")
            return
        }
        self.products = decoded.items
    }

    func toggleFavorite(for product: Product) {
        if let index = products.firstIndex(where: { $0.productId == product.productId }) {
            products[index].isFavorite.toggle()
        }
    }

    func addToBasket(product: Product) {
        let currentCount = productCount(product)
        
        if currentCount < product.inStock {     // checking if we have enough item in stock
            basket[product.productId] = currentCount + 1
        } else{                                 // message when not enough
            alertStockMsg =  "Only \(product.inStock) in stock for \(product.description)"
        }
    }


    func removeFromBasket(product: Product) {
        let currentCount = productCount(product)
        if currentCount > 0 {
            basket[product.productId] = currentCount - 1
        }
    }

    func productCount(_ product: Product) -> Int {
        basket[product.productId] ?? 0
    }

    func selectedProducts() -> [Product] {
        products.filter { productCount($0) > 0 }
    }

    // checkout message containing comma-separated basket product IDs
    func checkoutMessage() -> String {
        selectedProducts().map { $0.productId }.joined(separator: ", ")
    }
    
    // total basket value - to show in right corner of the navigation bar
    var totalFormattedPrice: String {
        let total = selectedProducts().reduce(0.0) { sum, product in
            let priceString = product.price.replacingOccurrences(of: " £", with: "") // assuming all the prices are in GBP
            let price = Double(priceString) ?? 0.0
            let count = productCount(product)
            return sum + (price * Double(count))
        }
        return String(format: "%.2f £", total)
    }

}
