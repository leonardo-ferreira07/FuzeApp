//
//  TeamNetworkRequest.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

struct TeamNetworkRequest: RequestProtocol {
    
    private let teamId: String
    
    init(teamId: String) {
        self.teamId = teamId
    }
    
    var urlString: String {
        URLConstants.teamsURL
    }
    
    var method: URLMethod {
        return .GET
    }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "filter[id]", value: teamId),
         URLQueryItem(name: "page", value: "1"),
         URLQueryItem(name: "per_page", value: "50")]
    }
    var headers: [String : String]? {
        ["Authorization": Constants.authorizationCode]
    }
}
