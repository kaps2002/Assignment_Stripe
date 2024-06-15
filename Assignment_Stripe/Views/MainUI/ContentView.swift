//
//  ContentView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ProductViewModal.self) var viewModel
    @State private var isAddProdViewActive = false
    @State private var searchTerm = ""
    
    var filteredTeams: [Product] {
        guard  !searchTerm.isEmpty else { return viewModel.products }
        return viewModel.filterTeams(searchTerm: searchTerm, product: viewModel.products)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(filteredTeams, id: \.self) { product in
                        ProductRowView(product: product)
                            .listRowSeparator(.hidden)
                    }
                }
                .scrollIndicators(.never)
                .listStyle(.plain)
                
                VStack {
                    Spacer()
                    Button(action: {
                        isAddProdViewActive = true
                    }, label: {
                        Text("Add new Product")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding([.top, .bottom], 15)
                            .padding(.horizontal, 40)
                            .background(.blue)
                            .clipShape(Capsule())
                    })
                }
            }
            .navigationTitle("Products ✨")
            .searchable(text: $searchTerm, prompt: "Search Products")
        }
        .sheet(isPresented: $isAddProdViewActive, content: {
            AddProdView(isAddProdViewActive: $isAddProdViewActive)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
        })
        .padding(.top, -80)
        .task {
            viewModel.fetchProducts()
        }
        .onChange(of: isAddProdViewActive) { isActive in
            if !isActive {
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ProductViewModal())
}
