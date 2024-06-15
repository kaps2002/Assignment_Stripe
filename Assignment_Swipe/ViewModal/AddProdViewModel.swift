//
//  AddProdViewModel.swift
//  Assignment_Stripe
//
//  Created by Roro on 14/06/24.
//

import Foundation
import PhotosUI

@Observable
class AddProdViewModel {
    
    private let APImanager = APIManager()
    var addProduct: AddProduct?
    var product_type: ProductType = .electronics
    var product_name: String = ""
    var price: String = ""
    var tax: String = ""
    var showImagePicker: Bool = false
    var isProductNameValid: Bool = true
    var isSellingPriceValid: Bool = true
    var isTaxRateValid: Bool = true
    
    func validation(name: String, price: String, tax: String) -> Int {
        if validateProductName(name: name) == false {
            return 1
        } else if validateSellingPrice(price: price) == false {
            return 2
        } else if validateTaxRate(tax: tax) == false {
            return 3
        }
        return 4
    }
    
    func validateProductName(name: String) -> Bool {
        if name.isEmpty {
            return false
        }
        return true
    }
    
    func validateSellingPrice(price: String) -> Bool {
        if price.isEmpty {
            return false
        }
        return true
    }
    
    func validateTaxRate(tax: String) -> Bool {
        if tax.isEmpty {
            return false
        }
        return true
    }
    
    func submitProduct(type: String, name: String, price: String, tax: String, image: UIImage?, completion: @escaping (Bool) -> Void) {
        let parameters: [String: String] = [
            "product_type": type,
            "product_name": name,
            "price": price,
            "tax": tax
        ]
        
        APImanager.addProduct(from: "https://app.getswipe.in/api/public/add", parameters: parameters, image: image) { [self] (success: Bool, response: AddProduct?) in
            if success {
                if let response = response {
                    addProduct = response
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}

enum ProductType: String, CaseIterable {
    case electronics = "Electronics"
    case clothing = "Clothing"
    case furniture = "Furniture"
    case books = "Books"
    case cosmetics = "Cosmetics"
    case medicines = "Medicines"
}
