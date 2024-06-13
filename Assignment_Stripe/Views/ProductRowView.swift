//
//  ProductRowView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    var body: some View {
        HStack(spacing: 20) {
            if product.image.isEmpty {
                Image("demoimg")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(10.0)
            } else {
                AsyncImageView(prodImg: product.image)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10.0)
            }
            
            VStack(alignment: .leading) {
                Text(product.product_name.capitalized)
                    .font(.headline)
                Text("Type: " + product.product_type.capitalized)
                    .font(.subheadline)
                HStack {
                    Text("Price: $\(product.price)")
                    Text("Tax: \(product.tax)%")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

#Preview {
    ProductRowView(product: Product.sample)
}
