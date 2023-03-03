//
//  MatchViewControllerTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

class MatchViewControllerTests: XCTestCase {
    
    private var window: UIWindow!
    private var sut: MatchViewController!
    
    private let match: Match = Match(beginAt: "today",
                                     opponents: [OpponentMain(opponent: Opponent(acronym: "tYu",
                                                                                 name: "Leo",
                                                                                 imageUrl: "google.com/image.png",
                                                                                 id: 2))], league: League(name: "mine",
                                                                                                          imageUrl: "google.com/image.png"), serie: Serie(fullName: "Dev series"))

    override func setUp() {
        super.setUp()
        
        sut = MatchViewController(viewModel: MatchDetailViewModel(service: MockServiceDetail(), match: match))
    }

    func testIfSubviewsAreAddedToView() {
        // Given
        load(viewController: sut)
        
        // When
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        
        // Then
        XCTAssertNotNil(sut.tableView.superview)
        XCTAssertNotNil(sut.activityIndicator.superview)
        XCTAssertNotNil(sut.headerStackView.superview)
    }

}

// MARK: - Helper loader method

extension MatchViewControllerTests {
    
    private func load(viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()

        window = UIWindow()
        window.addSubview(viewController.view)
    }
    
}
