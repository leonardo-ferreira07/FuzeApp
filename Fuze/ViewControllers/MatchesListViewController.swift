//
//  MatchesListViewController.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

class MatchesListViewController: UIViewController {
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    let viewModel: MatchListViewModel
    
    // MARK: - Initializers
    
    init(viewModel: MatchListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#161621")
        
        viewModel.fetchMatches { result in
            
        }
    }

}
