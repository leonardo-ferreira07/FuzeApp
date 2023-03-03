//
//  ConstantsTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class ConstantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConstants() {
        XCTAssertEqual(Constants.authorizationCode, "Bearer Rb-Bxrg5N4jbbfVvUGGtPFMoyEMgBpVZSDYcFE1fYRbuy-ghIzQ")
    }

}
