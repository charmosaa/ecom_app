//
//  MainView.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                BrowseView()
            }
            .tabItem {
                Label("Browse", systemImage: "list.bullet")
            }

            NavigationStack {
                CheckoutView()
            }
            .tabItem {
                Label("Checkout", systemImage: "clock")
            }
        }
        .environmentObject(viewModel) // shared viewModel
        .accentColor(Color.darkpurple)
        
    }
}

#Preview {
    MainView()
}
