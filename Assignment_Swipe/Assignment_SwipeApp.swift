//
//  Assignment_StripeApp.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI

@main
struct Assignment_SwipeApp: App {
    @State private var viewModel = ProductViewModal()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ProductViewModal())
        }
    }
}
