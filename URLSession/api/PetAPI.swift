//
//  PetAPI.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import Foundation

protocol PetAPIProtocol {
    
    func getPets(by status: Pet.Status, completion: @escaping (Result<[Pet], APIError>) -> Void)
    
}

class PetAPI: API, PetAPIProtocol {
    
    func getPets(by status: Pet.Status, completion: @escaping (Result<[Pet], APIError>) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        let path = "\(API.basePath)/pet/findByStatus"
        var components = URLComponents(string: path)!
        components.queryItems = [URLQueryItem(name: "status", value: status.rawValue)]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("text/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                let apiError = APIError(code: error.code, message: error.localizedDescription, detail: error.debugDescription)
                completion(.failure(apiError))
                return
            }
            
            if let data = data {
                do {
                    let pets = try JSONDecoder().decode([Pet].self, from: data)
                    completion(.success(pets))
                } catch let error {
                    let apiError = APIError(code: 999, message: "Decoding error", detail: error.localizedDescription)
                    completion(.failure(apiError))
                }
                return
            }
        }
        task.resume()
        
    }

}
