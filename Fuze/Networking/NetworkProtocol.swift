//
//  NetworkProtocol.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

protocol NetworkProtocol {
    func performRequest<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T>) -> Void)
}
