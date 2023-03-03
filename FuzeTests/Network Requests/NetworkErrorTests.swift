//
//  NetworkErrorTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

final class NetworkErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrors() {
        XCTAssertEqual(NetworkError.unknown("string").textError(), "string")
        XCTAssertEqual(NetworkError.invalidUrl.textError(), "This URL is invalid")
        XCTAssertEqual(NetworkError.invalidData.textError(), "This data is invalid")
        XCTAssertEqual(NetworkError.unauthorized.textError(), "This resource is not available for you")
        XCTAssertEqual(NetworkError.timeOut("string").textError(), "string")
        XCTAssertEqual(NetworkError.cancelled("string").textError(), "string")
        XCTAssertEqual(NetworkError.generic("string").textError(), "string")
        XCTAssertEqual(NetworkError.noConnection("string").textError(), "string")
        XCTAssertEqual(NetworkError.uploadFailed("string").textError(), "string")
        XCTAssertEqual(NetworkError.cacheRule("string").textError(), "string")
        XCTAssertEqual(NetworkError.parse("string").textError(), "string")
    }

}
