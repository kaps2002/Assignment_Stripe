//
//  ModalView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import Foundation

@Observable
class ProductViewModal {
    
    var products: [Product] = []
    private let manager = APIManager()

    func fetchProducts() async {
        
        do {
            products = try await manager.request(url: "https://app.getswipe.in/api/public/get")
            print(products)
        } catch {
            print(error)
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

final class APIManager {
    
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
