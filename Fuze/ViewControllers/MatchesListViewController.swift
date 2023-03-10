//
//  MatchesListViewController.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

class MatchesListViewController: UIViewController {
    
    // MARK: - UI Components
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(cellType: MatchTableViewCell.self)
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    internal lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        return activityIndicator
    }()
    
    internal lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestMathesData), for: .valueChanged)
        
        return refreshControl
    }()
    
    // MARK: - Properties
    
    let viewModel: MatchListViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Initializers
    
    init(viewModel: MatchListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestMathesData()
    }
    
    // MARK: - Methods
    
    private func setupLoading(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    @objc private func requestMathesData() {
        setupLoading(true)
        viewModel.fetchMatches { [weak self] result in
            DispatchQueue.main.async {
                self?.setupLoading(false)
                self?.refreshControl.endRefreshing()
                
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let networkError):
                    self?.displayAlert(networkError)
                }
            }
        }
    }

}

// MARK: - View Code

extension MatchesListViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(activityIndicator)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        let mainColor = UIColor(hexString: "#161621")
        
        title = "Partidas"
        view.backgroundColor = mainColor
        
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = mainColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
}

// MARK: - UITableView DataSource & Delegate

extension MatchesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MatchTableViewCell
        cell.setupCell(viewModel.matches[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamViewModel = MatchDetailViewModel(service: NetworkRequester(), match: viewModel.matches[indexPath.row])
        let viewController = MatchViewController(viewModel: teamViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        199
    }
}
