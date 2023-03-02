//
//  RequestProtocol.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

public protocol RequestProtocol {
    
    var urlString: String { get }
    var body: Data? { get }
    var timeout: TimeInterval { get }
    var method: URLMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var urlRequest: URLRequest? { get }
    
}

extension RequestProtocol {
    
    public var body: Data? {
        return nil
    }
    
    public var timeout: TimeInterval {
        return 10
    }
    
    public var method: URLMethod {
        return .GET
    }
    
    public var urlRequest: URLRequest? {
        guard let url = urlString.url(withQueryItems: queryItems) else {
            return nil
        }
        
        return URLRequest.request(with: url,
                                  method: method,
                                  bodyData: body,
                                  headers: headers,
                                  timeoutAfter: timeout)
    }
    
}
