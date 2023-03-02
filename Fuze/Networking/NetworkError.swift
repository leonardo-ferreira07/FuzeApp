//
//  NetworkingError.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrl
    case timeOut(String?)
    case unknown(String?)
    case cancelled(String?)
    case generic(String?)
    case noConnection(String?)
    case unauthorized
    case invalidData
    case uploadFailed(String?)
    case cacheRule(String?)
    case parse(String?)
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl): return true
        case (.timeOut, .timeOut): return true
        case (.unknown, .unknown): return true
        case (.cancelled, .cancelled): return true
        case (.generic, .generic): return true
        case (.noConnection, .noConnection): return true
        case (.unauthorized, .unauthorized): return true
        case (.invalidData, .invalidData): return true
        case (.uploadFailed, .uploadFailed): return true
        case (.cacheRule, .cacheRule): return true
        case (.parse, .parse): return true
        default: return false
        }
    }
}

extension NetworkError {
    func textError() -> String {
        var errorText = ""
        
        switch self {
        case .invalidUrl:
            errorText = "This URL is invalid"
        case .timeOut(let string):
            errorText = string ?? ""
        case .unknown(let string):
            errorText = string ?? ""
        case .cancelled(let string):
            errorText = string ?? ""
        case .generic(let string):
            errorText = string ?? ""
        case .noConnection(let string):
            errorText = string ?? ""
        case .unauthorized:
            errorText = "This resource is not available for you"
        case .invalidData:
            errorText = "This data is invalid"
        case .uploadFailed(let string):
            errorText = string ?? ""
        case .cacheRule(let string):
            errorText = string ?? ""
        case .parse(let string):
            errorText = string ?? ""
        }
        
        return errorText
    }
}
