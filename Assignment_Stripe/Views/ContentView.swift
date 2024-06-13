//
//  ContentView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ProductViewModal()
    @State private var searchTerm = ""
    
    var filteredTeams: [Product] {
        guard  !searchTerm.isEmpty else { return viewModel.products }
        return viewModel.filterTeams(searchTerm: searchTerm, product: viewModel.products)
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredTeams, id: \.self) { product in
                    ProductRowView(product: product)
                        .listRowSeparator(.hidden)
                }
            }
            .scrollIndicators(.never)
            .listStyle(.plain)
            .navigationTitle("Products ✨")
            .searchable(text: $searchTerm, prompt: "Search Products")
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ContentView()
}
