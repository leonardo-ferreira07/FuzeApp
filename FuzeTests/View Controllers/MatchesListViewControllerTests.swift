//
//  MatchesListViewControllerTests.swift
//  FuzeTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/03/23.
//

import XCTest
@testable import Fuze

class MatchesListViewControllerTests: XCTestCase {
    
    private var window: UIWindow!
    private var sut: MatchesListViewController!

    override func setUp() {
        super.setUp()
        
        sut = MatchesListViewController(viewModel: MatchListViewModel(service: MockService()))
    }

    func testIfSubviewsAreAddedToView() {
        // Given
        load(viewController: sut)
        
        // When
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        
        // Then
        XCTAssertNotNil(sut.tableView.superview)
        XCTAssertNotNil(sut.activityIndicator.superview)
        XCTAssertNotNil(sut.refreshControl.superview)
    }

}

// MARK: - Helper loader method

extension MatchesListViewControllerTests {
    
    private func load(viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()

        window = UIWindow()
        window.addSubview(viewController.view)
    }
    
}
