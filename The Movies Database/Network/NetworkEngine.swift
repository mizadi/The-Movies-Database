//
//  NetworkEngine.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
class NetworkEngine {
    
    private var session: NetworkSession
    
    init(session: NetworkSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func request < T: Codable > (endpoint: Endpoint, completion: @escaping(Result < T, Error > ) -> ()) {
        session.request(endpoint: endpoint, completion: completion)
    }
}
protocol NetworkSession {
    func request < T: Codable > (endpoint: Endpoint, completion: @escaping(Result < T, Error > ) -> ())
}

extension URLSession: NetworkSession {
    
    func buildURLRequest(_ endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        if endpoint.scheme != "http" && endpoint.scheme != "https" {
            return nil
        }
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path ?? ""
        components.queryItems = endpoint.parameters
        guard
            let url = components.url
        else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }
    
    func request<T>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        guard let urlRequest = buildURLRequest(endpoint) else {
            return
        }
        let dataTask = self.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(NSError(domain: "Error", code: 404, userInfo: nil)))
                return
            }
            DispatchQueue.main.async {
                if let responseObject =
                    try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    
}
