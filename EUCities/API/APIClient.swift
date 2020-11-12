//
//  APIClient.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

enum APIError: Error {
    case noDataError
    case networkError
    case decodingError
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

/// API Client class. Requests should be made through this class only.
class APIClient:APIClientProtocol {
    
    /// Designated request-making method.
    func request<T:Decodable>(
        target: APIService,
        type: T.Type,
        completion: @escaping (Result<T>) -> Void) {
    
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(
            with: URL(target: target)
        ) { data, response, error in
            var result: Result<T>
            
            switch target {
            case .getCities,
                 .getDetails,
                 .getMoreInfo:
                result = self.serializedJSON(with: data, error: error)

            case .getImage:
                result = self.serializedImage(with: data, error: error)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        dataTask.resume()
    }
}

// MARK: - Private serialization methods

extension APIClient {
    /// Used to deserialize `JSON` from `Data` object passed in parameters
    func serializedJSON<T:Decodable>(with data: Data?, error: Error?) -> Result<T> {
        if error != nil { return .failure(.networkError) }
        guard let data = data else { return .failure(.noDataError) }
        do {
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        } catch {
            return .failure(.decodingError)
        }
    }

    /// Used to convert `Data` to `Image` object
    func serializedImage<T:Decodable>(with data: Data?, error: Error?) -> Result<T> {
        if error != nil { return .failure(.networkError) }
        guard let data = data else { return .failure(.noDataError) }
        guard let image = Image(imageData: data) as? T else { return .failure(.noDataError) }
        return .success(image)
    }
}
