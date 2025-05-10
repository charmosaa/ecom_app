//
//  CheckoutView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var viewModel: ProductViewModel

    var body: some View {
        List(viewModel.selectedProducts()) { product in
            SingleProductView(product: product)
                .environmentObject(viewModel)
        }
//        List {
//            ForEach() {  product in
//                SingleProductView(product: product)
//                    .environmentObject(viewModel)
//            }
//            
//
//            if !viewModel.selectedProducts().isEmpty {
//                Button("Checkout") {
//                    // Show alert or trigger action
//                }
//                .frame(maxWidth: .infinity)
//                .foregroundColor(.white)
//                .padding()
//                .background(Color.blue)
//                .cornerRadius(10)
//                .padding(.vertical)
//            }
//        }
        .navigationTitle("Checkout")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text(viewModel.totalFormattedPrice)
                    .font(.headline)
            }
        }
    }
}



