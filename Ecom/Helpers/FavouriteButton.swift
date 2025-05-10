//
//  FavouriteButton.swift
//  Ecom
//
//  Created by Martyna Lopianiak on 10/05/2025.
//

import SwiftUI

struct FavoriteButton: View {
    let isSet: Bool
    let toggleAction: () -> Void

    var body: some View {
        Button(action: toggleAction) {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundStyle(Color.darkpurple)
        }
    }
}
