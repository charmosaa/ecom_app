//
//  CheckoutView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var showAlert = false
    @State private var checkoutMessage = ""

    var body: some View {
        
        VStack{
            // all selected items
            List(viewModel.selectedProducts()) { product in
                SingleProductView(product: product)
                    .environmentObject(viewModel)
            }
            
           // checkout button (only when there are items)
            if !viewModel.selectedProducts().isEmpty {
                Button(action: {
                    checkoutMessage = viewModel.checkoutMessage()
                    showAlert = true
                }) {
                    Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.standardYellow)
                        .foregroundColor(.black)
                        .cornerRadius(6)
                }
                .padding()
                .buttonStyle(PlainButtonStyle()) 
            }
            // if empty show message
            else {
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    Text("Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }

        }
        // alert with a message containing comma-separated basket product IDs
        .alert("Product IDs", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(checkoutMessage)
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



