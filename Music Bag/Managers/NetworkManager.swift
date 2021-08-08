//
//  NetworkManager.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    func getApiKey() -> String? {
        if let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let value = NSDictionary(contentsOfFile: filePath)?.object(forKey: "API_KEY") as? String {
            return value
        } else {
            return nil
        }
    }
    
    func fetch<T>(_:T.Type, endpoint: Endpoint, completion: @escaping(Result<T, Error>) -> Void) where T: Decodable {
        
        guard let apiKey = getApiKey() else {
            let error = NSError(domain: "Error", code: 001, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        let endpointURL = CreateURL.urlQueryToList(endpoint: endpoint, apiKey: apiKey)
        
//        guard let url = endpointURL.url else {
//            let error = NSError(domain: "Error", code: 001, userInfo: nil)
//            completion(.failure(error))
//            return
//        }
        
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&key=\(apiKey)") else { return }
        
        print(url)
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
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
