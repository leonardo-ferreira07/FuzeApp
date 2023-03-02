//
//  MatchTableViewCell.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

class MatchTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - UI Components
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272639")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
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
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        
        return view
    }()
    
    private lazy var leagueImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var leagueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.text = "League + serie"
        
        return label
    }()
    
    private lazy var leagueStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leagueImageView, leagueLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .bold)
        label.text = "Hoje, 21:00"
        
        return label
    }()
    
    private lazy var timeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FAFAFA").withAlphaComponent(0.2)
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.addSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    func setupCell(_ match: Match) {
        let opponent1 = match.opponents?.first?.opponent
        let opponent2 = match.opponents?.last?.opponent
        
        if let image = opponent1?.imageUrl {
            opponent1Image.loadImage(image)
        }
        if let image = opponent2?.imageUrl {
            opponent2Image.loadImage(image)
        }
        if let image = match.league?.imageUrl {
            leagueImageView.loadImage(image)
        }
        opponent1Label.text = opponent1?.name
        opponent2Label.text = opponent2?.name
        leagueLabel.text = (match.league?.name ?? "") + " " + (match.serie?.fullName ?? "")
        timeLabel.text = Date.convertToFuzeDate(match.beginAt ?? "")
    }

}

// MARK: - ViewCode

extension MatchTableViewCell: ViewCode {
    
    func buildViewHierarchy() {
        cardView.addSubview(opponentsStackView)
        cardView.addSubview(separatorView)
        cardView.addSubview(leagueStackView)
        cardView.addSubview(timeView)
        
        contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        leagueImageView.translatesAutoresizingMaskIntoConstraints = false
        leagueImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        leagueImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        [opponent1Image, opponent2Image].forEach { image in
            image.translatesAutoresizingMaskIntoConstraints = false
            image.heightAnchor.constraint(equalToConstant: 60).isActive = true
            image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        opponentsStackView.translatesAutoresizingMaskIntoConstraints = false
        opponentsStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 43.5).isActive = true
        opponentsStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor, constant: 0).isActive = true
        
        leagueStackView.translatesAutoresizingMaskIntoConstraints = false
        leagueStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15).isActive = true
        leagueStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32).isActive = true
        
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 0).isActive = true
        timeView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0).isActive = true
        timeView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
