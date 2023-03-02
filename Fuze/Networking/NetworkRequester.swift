//
//  NetworkingRequester.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

typealias DataResponse = (Data?, NetworkError?) -> Void

class NetworkRequester: NetworkProtocol {
    
    /// Request Generic data from server
    ///
    /// - Parameters:
    ///   - request: Request Protocol
    ///   - completion: Generic or Error
    func performRequest<T: Decodable>(_ request: RequestProtocol,
                                             completion: @escaping (Result<T>) -> Void) {
        performRequest(request) { (data, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(NetworkError.unknown("No error from server and data is nil.")))
                return
            }
            
            do {
                let generic = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(generic))
            } catch {
                completion(Result.failure(NetworkError.parse(error.localizedDescription)))
            }
        }
    }
    
    /// Fetch data from URL with NSUrlSession
    ///
    /// - Parameters:
    ///   - request: Parameters for request
    ///   - completion: Returns fetched NSData in a block
    /// - Returns: URLSessionDataTask
    func performRequest(_ request: RequestProtocol,
                        completion: @escaping DataResponse) {
        guard let urlRequest = request.urlRequest else {
            return
        }
        
        performRequest(urlRequest, completion: completion)
        
    }
    
    /// Fetch data from URL with NSUrlSession
    ///
    /// - Parameters:
    ///   - urlRequest: Url Request to fetch data form
    ///   - completion: Returns fetched NSData in a block
    /// - Returns: URLSessionDataTask
    private func performRequest(_ urlRequest: URLRequest,
                        completion: @escaping DataResponse) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("There was an error \(error.localizedDescription)")
                
                let urlError = error as NSError
                switch urlError.code {
                case NSURLErrorTimedOut:
                    completion(nil, NetworkError.timeOut(error.localizedDescription))
                case NSURLErrorNotConnectedToInternet:
                    completion(nil, NetworkError.noConnection(error.localizedDescription))
                case URLError.cancelled.rawValue:
                    completion(nil, NetworkError.cancelled(error.localizedDescription))
                default:
                    completion(nil, NetworkError.unknown(error.localizedDescription))
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401  {
                    completion(nil, NetworkError.unauthorized)
                } else {
                    completion(data, nil)
                }
            }
        }
        dataTask.resume()
    }
}
