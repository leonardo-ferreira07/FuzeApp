//
//  URLConstantsTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class URLConstantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLConstants() {
        XCTAssertEqual(URLConstants.matchesURL, "https://api.pandascore.co/csgo/matches/upcoming")
        XCTAssertEqual(URLConstants.teamsURL, "https://api.pandascore.co/csgo/teams")
    }

}
