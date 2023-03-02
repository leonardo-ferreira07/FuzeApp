//
//  MatchListViewModel.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

class MatchListViewModel {
    
    // MARK: - Properties
    private let matchesRequest: RequestProtocol
    private let service: NetworkProtocol
    
    // MARK: - Init
    init<S: NetworkProtocol>(service: S) {
        self.service = service
        self.matchesRequest = MatchListNetworkRequest()
    }
    
    // MARK: - Fetch data
    func fetchMatches(completion: @escaping (Result<Bool>) -> Void) {
        service.performRequest(matchesRequest) { [weak self] (result: Result<[Match]>) in
            switch result {
            case .success(let matchesArray):
                print(matchesArray)
                completion(Result.success(true))
            case .failure(let error):
                print(error)
                completion(Result.failure(error))
            }
        }
        
    }
}

