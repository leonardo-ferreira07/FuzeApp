//
//  MatchViewController.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

class MatchViewController: UIViewController {
    
    // MARK: - UI Components
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(cellType: PlayerTableViewCell.self)
        
        return tableView
    }()
    
    internal lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        return activityIndicator
    }()
    
    private lazy var opponent1Image: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var opponent2Image: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var opponent1Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .regular)
        
        return label
    }()
    
    private lazy var opponent2Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .regular)
        
        return label
    }()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "VS"
        
        return label
    }()
    
    private lazy var opponent1StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [opponent1Image, opponent1Label])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var opponent2StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [opponent2Image, opponent2Label])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var opponentsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [opponent1StackView, versusLabel, opponent2StackView])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "Hoje, 21:00"
        
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [opponentsStackView, timeLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        return stackView
    }()
    
    
    // MARK: - Properties
    
    let viewModel: MatchDetailViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Initializers
    
    init(viewModel: MatchDetailViewModel) {
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
        
        setupLoading(true)
        viewModel.fetchTeams { [weak self] result in
            DispatchQueue.main.async {
                self?.setupLoading(false)
                self?.configureHeaderUI()
                
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let networkError):
                    self?.displayAlert(networkError)
                }
            }
        }
    }
    
    // MARK: - Methods
    
    private func setupLoading(_ show: Bool) {
        headerStackView.isHidden = show
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func configureHeaderUI() {
        let opponent1 = viewModel.match?.opponents?.first?.opponent
        let opponent2 = viewModel.match?.opponents?.last?.opponent
        
        if let image = opponent1?.imageUrl {
            opponent1Image.loadImage(image)
        }
        if let image = opponent2?.imageUrl {
            opponent2Image.loadImage(image)
        }
        opponent1Label.text = opponent1?.name
        opponent2Label.text = opponent2?.name
        timeLabel.text = Date.convertToFuzeDate(viewModel.match?.beginAt ?? "")
    }

}

// MARK: - View Code

extension MatchViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(activityIndicator)
        view.addSubview(headerStackView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        [opponent1Image, opponent2Image].forEach { image in
            image.translatesAutoresizingMaskIntoConstraints = false
            image.heightAnchor.constraint(equalToConstant: 60).isActive = true
            image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 22).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        let mainColor = UIColor(hexString: "#161621")
        
        title = (viewModel.match?.league?.name ?? "") + " " + (viewModel.match?.serie?.fullName ?? "")
        view.backgroundColor = mainColor
        navigationItem.largeTitleDisplayMode = .never
        let backButton = UIBarButtonItem(image: UIImage(named: "icArrow"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = mainColor
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
}

// MARK: - UITableView DataSource & Delegate

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PlayerTableViewCell
        let players1 = viewModel.team1?.players
        let players2 = viewModel.team2?.players
        
        
        cell.setupCell(players1?.count ?? 0 > indexPath.row ? players1?[indexPath.row] : nil, player2: players2?.count ?? 0 > indexPath.row ? players2?[indexPath.row] : nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        74
    }
}
