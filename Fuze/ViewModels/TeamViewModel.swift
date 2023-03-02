//
//  TeamViewModel.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import Foundation

class TeamViewModel {
    
    // MARK: - Properties
    private let team1Request: RequestProtocol
    private let team2Request: RequestProtocol
    private let service: NetworkProtocol
    
    private(set) var team1: Team?
    private(set) var team2: Team?
    private(set) var match: Match?
    private(set) var numberOfItems: Int = 0
    
    // MARK: - Init
    init<S: NetworkProtocol>(service: S, match: Match) {
        self.service = service
        self.match = match
        self.team1Request = TeamNetworkRequest(teamId: "\(match.opponents?.first?.opponent?.id ?? 0)")
        self.team2Request = TeamNetworkRequest(teamId: "\(match.opponents?.last?.opponent?.id ?? 0)")
    }
    
    // MARK: - Fetch data
    func fetchTeams(completion: @escaping (Result<Bool>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        service.performRequest(team1Request) { [weak self] (result: Result<[Team]>) in
            switch result {
            case .success(let team):
                self?.team2 = team.first
            case .failure(let error):
                print(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        service.performRequest(team2Request) { [weak self] (result: Result<[Team]>) in
            switch result {
            case .success(let team):
                self?.team1 = team.first
            case .failure(let error):
                print(error)
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .global(qos: .background)) { [weak self] in
            guard let self else { return }
            self.numberOfItems = max(self.team1?.players?.count ?? 0, self.team2?.players?.count ?? 0)
            completion(Result.success(true))
        }
        
    }
}
