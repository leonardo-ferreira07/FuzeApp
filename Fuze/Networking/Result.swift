//
//  Result.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}
