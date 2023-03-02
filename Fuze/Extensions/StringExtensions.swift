//
//  StringExtensions.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

extension String {
    
    func url(withQueryItems queryItems: [URLQueryItem]? = nil) -> URL? {
        var urlComponents = URLComponents(string: self)
        
        if queryItems?.count ?? 0 > 0 {
            urlComponents?.queryItems = queryItems
        }
        
        return urlComponents?.url
    }
    
}
