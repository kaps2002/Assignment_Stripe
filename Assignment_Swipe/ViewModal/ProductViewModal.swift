//
//  ModalView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import Foundation
import PhotosUI

@Observable
class ProductViewModal {
    
    var products: [Product] = []
    private let APImanager = APIManager()
    
    func fetchProducts() {
        APImanager.request(url: "https://app.getswipe.in/api/public/get") { [self] response in
            switch response {
            case .success(let data):
                products = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterTeams(searchTerm: String, product: [Product]) -> [Product] {
        product.filter {
            $0.product_name.localizedStandardContains(filterSearchTerm(searchTerm))
        }
    }
    
    func filterSearchTerm(_ searchTerm: String) -> String {
        let searchArray = searchTerm.split(separator: " ")
        var newSearchTerm = ""
        for index in 0..<searchArray.count {
            if (index != searchArray.count - 1) { newSearchTerm += searchArray[index] + " " }
            else {
                newSearchTerm += searchArray[index]
            }
        }
        return newSearchTerm
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
