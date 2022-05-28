//
//  Networking.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 28/05/2022.
//

import Foundation

enum FetchError: Error {
    case noUrl
    case noData
    case cantDecode
}

class NetworkManager {
    
    static var shared = NetworkManager()
    private init(){}
    
    func fetchRequestWith(url: String, completion: @escaping(Result<ContactInfo, FetchError>) -> Void) {
        
        guard let url = URL(string: url) else { completion(.failure(.noUrl)); return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormater)
                let type = try decoder.decode(ContactInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.cantDecode))
            }
            
        }.resume()
    }
}
