//
//  MatchListNetworkRequest.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

struct MatchListNetworkRequest: RequestProtocol {
    
    init() {}
    
    var urlString: String {
        URLConstants.matchesURL
    }
    
    var method: URLMethod {
        return .GET
    }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "page", value: "1"),
        URLQueryItem(name: "per_page", value: "50")]
    }
    var headers: [String : String]? {
        ["Authorization": Constants.authorizationCode]
    }
}
