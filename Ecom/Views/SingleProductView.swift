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

    var body: some View {
        HStack() {
            // favourite button top-left corrner
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
                
                // add / remove buttons and quantity
                HStack {
                    Button(action: {
                        viewModel.removeFromBasket(product: product)
                    }) {
                        Text("-")
                            .font(.headline)
                            .frame(width: 50, height: 30)
                            .background(Color.lightYellow)
                            .foregroundColor(.black)
                            .cornerRadius(6)
                    }
                    
                    Text("\(viewModel.productCount(product))")
                        .frame(width: 30)
                        .font(.body)
                    
                    Button(action: {
                        viewModel.addToBasket(product: product)
                    }) {
                        Text("+")
                            .font(.headline)
                            .frame(width: 50, height: 30)
                            .background(Color.standardYellow)
                            .foregroundColor(.black)
                            .cornerRadius(6)
                    }
                }
            }.padding(.leading)
        }
        .padding(.vertical)
    }
}
