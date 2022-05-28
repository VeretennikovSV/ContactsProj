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
    
    func fetchRequestWith(url: String, completion: @escaping(Result<(ContactInfo, Data?), FetchError>) -> Void) {
        
        guard let url = URL(string: url) else { completion(.failure(.noUrl)); return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormater)
                let type = try decoder.decode(ContactInfo.self, from: data)
                DispatchQueue.main.async { [self] in
                    let data = downloadImage(from: type.results.first?.picture.large)
                    completion(.success((type, data)))
                }
            } catch {
                completion(.failure(.cantDecode))
            }
            
        }.resume()
    }
    
    func downloadImage(from url: String?) -> Data? {
        
        var outData: Data?
        
        guard let url = URL(string: url ?? "") else { return nil }
        
        do {
            let data = try? Data(contentsOf: url)
            outData = data
        } catch {
            print("suck")
        }
        
        return outData
    }
}
