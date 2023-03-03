//
//  MatchDetailViewModelTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class MatchDetailViewModelTests: XCTestCase {

    private let match: Match = Match(beginAt: "today",
                                     opponents: [OpponentMain(opponent: Opponent(acronym: "tYu",
                                                                                 name: "Leo",
                                                                                 imageUrl: "google.com/image.png",
                                                                                 id: 2))], league: League(name: "mine",
                                                                                                          imageUrl: "google.com/image.png"), serie: Serie(fullName: "Dev series"))
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelData() {
        let viewModel = MatchDetailViewModel(service: MockServiceDetail(), match: match)
        
        XCTAssertEqual(viewModel.team1?.players?.count, nil)
        XCTAssertEqual(viewModel.team2?.players?.count, nil)
        
        viewModel.fetchTeams { _ in
            
        }
        
        let player = viewModel.team1?.players?.first!
        XCTAssertEqual(player?.firstName, "Leo")
        XCTAssertEqual(player?.lastName, "Kami")
        XCTAssertEqual(player?.name, "stonbr")
        XCTAssertEqual(player?.imageUrl, "google.com/image.png")
    }
    
    func testViewModelNoData() {
        let viewModel = MatchDetailViewModel(service: MockServiceDetailNoData(), match: match)
        
        viewModel.fetchTeams { _ in
            
        }
        
        XCTAssertEqual(viewModel.team1?.players?.count, nil)
        XCTAssertEqual(viewModel.team2?.players?.count, nil)
    }

}

class MockServiceDetail: NetworkProtocol {
    func performRequest<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T>) -> Void) {
        let team = [Team(players: [Player(firstName: "Leo",
                                          lastName: "Kami",
                                          name: "stonbr",
                                          imageUrl: "google.com/image.png")])]
        completion(Result.success(team as! T))
    }
}

class MockServiceDetailNoData: NetworkProtocol {
    func performRequest<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T>) -> Void) {
        completion(Result.failure(.unknown(nil)))
    }
}
