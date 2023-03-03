//
//  MatchListNetworkRequestTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class MatchListNetworkRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMatchListRequest() {
        let request = MatchListNetworkRequest()
        
        XCTAssertEqual(request.urlString, "https://api.pandascore.co/csgo/matches/upcoming")
        XCTAssertEqual(request.method, .GET)
        XCTAssertEqual(request.queryItems![0].name, "page")
        XCTAssertEqual(request.queryItems![0].value, "1")
        XCTAssertEqual(request.queryItems![1].name, "per_page")
        XCTAssertEqual(request.queryItems![1].value, "50")
    }

}
