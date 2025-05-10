//
//  SingleProductView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import SwiftUI

struct SingleProductView: View {
    let product: Product
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var showAlert = false

    var body: some View {
        HStack() {
            // favourite button top-left corner
            VStack(alignment: .leading){
                FavoriteButton(
                    isSet: product.isFavorite,
                    toggleAction: {
                        viewModel.toggleFavorite(for: product)
                    }
                )
                Spacer()
            }
            
            // image in the left - center
            Image(product.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            // on the right product info
            VStack(alignment: .leading){
                Text(product.description)
                    .lineLimit(2)
                    .font(.footnote)
                    
                Spacer()
                
                // price
                Text(product.price)
                    .font(.headline)
                    .foregroundColor(Color.redPurple)
                
                // remove / add buttons and quantity
                HStack(spacing: 12) {
                    Button(action: {
                        viewModel.removeFromBasket(product: product)
                    }) {
                        Text("-")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 30)
                            .background(Color.lightYellow)
                            .foregroundColor(.black)
                            .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Text("\(viewModel.productCount(product))")
                        .frame(maxWidth: .infinity)
                        .font(.body)

                    Button(action: {
                        viewModel.addToBasket(product: product)
                        if viewModel.alertStockMsg != nil {
                                showAlert = true
                        }
                    }) {
                        Text("+")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .background(Color.standardYellow)
                            .foregroundColor(.black)
                            .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle())
                    // alert message when not enough stock when trying to add item to the cart
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Not Enough Stock"), message: Text(viewModel.alertStockMsg ?? ""), dismissButton: .default(Text("OK")) {
                            viewModel.alertStockMsg = nil
                        })
                    }
                }

            }.padding(.leading)
        }
        .padding(.vertical)
    }
}
