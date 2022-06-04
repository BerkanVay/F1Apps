//
//  KukaRESTClient.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

class KukaRESTClient {
    enum NetworkingError: Error {
        case invalidURL
        case noData
        case generic(error: Error)
        case decoding(error: Error)
    }
    
    private static let jsonDecoder = JSONDecoder()
    
    static func getAllPilots(completionHandler: @escaping (Result<PilotsResponse, NetworkingError>) -> Void) {
        doRequest(withURLString: "https://my-json-server.typicode.com/oguzayan/kuka/drivers", completionHandler: completionHandler)
    }
    
    static func getPilotDetail(forId id: Int, completionHandler: @escaping (Result<PilotDetail, NetworkingError>) -> Void) {
        doRequest(withURLString: "https://my-json-server.typicode.com/oguzayan/kuka/driverDetail/\(id)", completionHandler: completionHandler)
    }
    
    private static func doRequest<T: Decodable>(
        withURLString urlString: String,
        completionHandler: @escaping (Result<T, NetworkingError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidURL))
            
            return
        }
        
        let task = URLSession.shared.dataTask(
            with: url
        ) { data, response, error in
            if let error = error {
                completionHandler(.failure(.generic(error: error)))
                
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                
                return
            }
            
            do {
                let response = try jsonDecoder.decode(T.self, from: data)
                
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(.decoding(error: error)))
            }
        }
        
        task.resume()
    }
    
}
