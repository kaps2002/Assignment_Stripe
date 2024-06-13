//
//  AsyncImageView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI

struct AsyncImageView: View {
    let prodImg: String
    var body: some View {
        if let url = URL(string: prodImg) {
            productImg(url)
        }
    }
    func productImg(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    AsyncImageView(prodImg: "https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1718045202_0_1718045202279_product_image.jpg")
}
