//
//  BrowseView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//


import SwiftUI

struct BrowseView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var showFavoritesOnly = false

    // fliter favourite only
    var filteredProducts: [Product] {
        showFavoritesOnly
            ? viewModel.products.filter { $0.isFavorite }
            : viewModel.products
    }

    var body: some View {
        List {
            // toggle for favourites products
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favourites only")
            } .tint(Color.darkpurple)
            
            // product list
            ForEach(filteredProducts){
                product in
                SingleProductView(product: product)
                    .environmentObject(viewModel)
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text(viewModel.totalFormattedPrice)
                    .font(.headline)
            }
        }
    }
}
