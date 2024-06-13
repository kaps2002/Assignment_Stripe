//
//  Modal.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import Foundation

struct Product: Codable, Hashable {
    let image: String
    let price: Int
    let product_name: String
    let product_type: String
    let tax: Int
    
    static var sample: Product {
        return Product(image: "", price: 20, product_name: "hello", product_type: "macbook", tax: 20)
    }
}
