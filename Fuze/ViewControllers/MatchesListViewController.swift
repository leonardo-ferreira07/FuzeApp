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
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#161621")
    }

}
