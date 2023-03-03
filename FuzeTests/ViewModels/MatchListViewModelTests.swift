//
//  MatchListViewModelTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class MatchListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelData() {
        let viewModel = MatchListViewModel(service: MockService())
        
        XCTAssertEqual(viewModel.matches.count, 0)
        
        viewModel.fetchMatches { _ in
            
        }
        
        let match = viewModel.matches.first!
        XCTAssertEqual(match.beginAt, "today")
        XCTAssertEqual(match.opponents?.first?.opponent?.acronym, "tYu")
        XCTAssertEqual(match.opponents?.first?.opponent?.imageUrl, "google.com/image.png")
        XCTAssertEqual(match.league?.imageUrl, "google.com/image.png")
        XCTAssertEqual(match.serie?.fullName, "Dev series")
    }
    
    func testViewModelNoData() {
        let viewModel = MatchListViewModel(service: MockServiceNoData())
        
        viewModel.fetchMatches { _ in
            
        }
        
        XCTAssertEqual(viewModel.matches.count, 0)
    }

}

class MockService: NetworkProtocol {
    func performRequest<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T>) -> Void) {
        let matches = [Match(beginAt: "today",
                             opponents: [OpponentMain(opponent: Opponent(acronym: "tYu",
                                                                         name: "Leo",
                                                                         imageUrl: "google.com/image.png",
                                                                         id: 2))], league: League(name: "mine",
                                                                                                  imageUrl: "google.com/image.png"), serie: Serie(fullName: "Dev series"))]
        completion(Result.success(matches as! T))
    }
}

class MockServiceNoData: NetworkProtocol {
    func performRequest<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T>) -> Void) {
        completion(Result.failure(.unknown(nil)))
    }
}
