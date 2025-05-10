//
//  ProductView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var basket: [String: Int] = [:] // productId → count

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
        guard let currentCount = basket[product.productId] else {
            basket[product.productId] = 1
            return
        }
        if currentCount < product.inStock {
            basket[product.productId] = currentCount + 1
        }
    }

    func removeFromBasket(product: Product) {
        guard let currentCount = basket[product.productId], currentCount > 0 else { return }
        if currentCount == 1 {
            basket.removeValue(forKey: product.productId)
        } else {
            basket[product.productId] = currentCount - 1
        }
    }

    func productCount(_ product: Product) -> Int {
        basket[product.productId] ?? 0
    }

    func selectedProducts() -> [Product] {
        products.filter { productCount($0) > 0 }
    }

    func checkoutMessage() -> String {
        selectedProducts().map { $0.productId }.joined(separator: ", ")
    }

    var totalItemsInBasket: Int {
        basket.values.reduce(0, +)
    }
    var totalFormattedPrice: String {
        let total = selectedProducts().reduce(0.0) { sum, product in
            let priceString = product.price.replacingOccurrences(of: " £", with: "")
            let price = Double(priceString) ?? 0.0
            let count = productCount(product)
            return sum + (price * Double(count))
        }
        return String(format: "%.2f £", total)
    }

}
