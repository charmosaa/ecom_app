//
//  BrowseView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//


import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var showFavoritesOnly = false

    // fliter favourite only
    var filteredProducts: [Product] {
        showFavoritesOnly
            ? viewModel.products.filter { $0.isFavorite }
            : viewModel.products
    }

    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Favorites Only", isOn: $showFavoritesOnly)
                .padding(.horizontal)
                .tint(Color.darkpurple)

            List(filteredProducts) { product in
                SingleProductView(product: product)
                    .environmentObject(viewModel)
            }
        }
        .navigationTitle("Browse")
    }
}


#Preview {
    BrowseView()
}
