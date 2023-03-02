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
    
    // MARK: - Init
    init<S: NetworkProtocol>(service: S, firstTeamId: Int, secondTeamId: Int) {
        self.service = service
        self.team1Request = TeamNetworkRequest(teamId: "\(firstTeamId)")
        self.team2Request = TeamNetworkRequest(teamId: "\(secondTeamId)")
    }
    
    // MARK: - Fetch data
    func fetchTeams(completion: @escaping (Result<Bool>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        service.performRequest(team1Request) { [weak self] (result: Result<Team>) in
            switch result {
            case .success(let team):
                print(team)
                self?.team2 = team
            case .failure(let error):
                print(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        service.performRequest(team2Request) { [weak self] (result: Result<Team>) in
            switch result {
            case .success(let team):
                print(team)
                self?.team1 = team
            case .failure(let error):
                print(error)
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .global(qos: .background)) {
            completion(Result.success(true))
        }
        
    }
}
