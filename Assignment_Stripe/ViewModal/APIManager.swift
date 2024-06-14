//
//  ApiManager.swift
//  Assignment_Stripe
//
//  Created by Roro on 14/06/24.
//

import Foundation
import Alamofire
import PhotosUI

final class APIManager {
    
    func request(url: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do{
                    let responsedata = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(responsedata))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func addProduct(from url: String, parameters: [String: String], image: UIImage?, completion: @escaping (Bool, AddProduct?) -> Void) {
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "files[]", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
        }, to: url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let apiData = try JSONDecoder().decode(AddProduct.self, from: data)
                    completion(true, apiData)
                } catch {
                    print("Error decoding response:", error)
                    completion(false, nil)
                }
            case .failure(let error):
                print("Request failed with error:", error)
                completion(false, nil)
            }
        }
    }
}
