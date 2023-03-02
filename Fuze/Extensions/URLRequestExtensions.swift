//
//  URLRequestExtensions.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

extension URLRequest {
    
    public static func request(with url: URL,
                               method: URLMethod? = .GET,
                               bodyData: Data? = nil,
                               headers: [String: String]? = nil,
                               timeoutAfter timeout: TimeInterval = 10) -> URLRequest {
        let urlRequest = NSMutableURLRequest(url: url)
        
        if let method = method {
            urlRequest.httpMethod = method.rawValue
        }
        
        if let bodyData = bodyData {
            urlRequest.httpBody = bodyData
        }
        
        if let headers = headers {
            for key in headers.keys {
                if let value = headers[key] {
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        if timeout > 0 {
            urlRequest.timeoutInterval = timeout
        }
        
        return urlRequest as URLRequest
    }
}
