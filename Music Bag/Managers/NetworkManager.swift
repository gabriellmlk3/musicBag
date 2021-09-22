//
//  NetworkManager.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation

class NetworkManager: Service {
    
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    var apiKey: String {
        return self.fetchPlistResource(in: "Info", key: "API_KEY") ?? ""
    }
    
    var baseUrl: String {
        return self.fetchPlistResource(in: "Info", key: "BASE_URL") ?? ""
    }
    
    func fetchURL(endpoint: Endpoint) -> URL? {
        let endpointURL = CreateURL.urlToResults(endpoint: endpoint)
        guard let url = endpointURL.url else { return nil }
        debugPrint("URL ----- \(url) ---- \\\\")
        return url
    }
    
    func getRequest<T>(_: T.Type, url: URL, completion: @escaping Completion<T>) where T: Decodable {
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    let error = NSError(domain: "Error", code: 001, userInfo: nil)
                    completion(.failure(error))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoderNews = try decoder.decode(T.self, from: data)
                completion(.success(decoderNews))
            } catch {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}

extension NetworkManager {
    
    func fetchPlistResource(in plistName: String, key: String) -> String? {
        if let filePath = Bundle.main.path(forResource: plistName, ofType: "plist"),
           let value = NSDictionary(contentsOfFile: filePath)?.object(forKey: key) as? String {
            return value
        } else {
            return String()
        }
    }
}


