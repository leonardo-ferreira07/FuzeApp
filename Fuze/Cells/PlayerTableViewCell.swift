//
//  PlayerTableViewCell.swift
//  Fuze
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/03/23.
//

import UIKit

class PlayerTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - UI Components
    
    private lazy var cardView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272639")
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private lazy var nickNameLabel1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var nameLabel1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hexString: "#6C6B7E")
        
        return label
    }()
    
    private lazy var playerImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    private lazy var textStackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickNameLabel1, nameLabel1])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    private lazy var cardView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272639")
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    private lazy var nickNameLabel2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var nameLabel2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hexString: "#6C6B7E")
        
        return label
    }()
    
    private lazy var playerImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    private lazy var textStackView2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickNameLabel2, nameLabel2])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        return stackView
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
    
    func setupCell(_ player: Player?, player2: Player?) {
        cardView1.isHidden = player == nil
        cardView2.isHidden = player2 == nil
        
        nickNameLabel1.text = player?.name
        nickNameLabel2.text = player2?.name
        nameLabel1.text = "\(player?.firstName ?? "") \(player?.lastName ?? "")"
        nameLabel2.text = "\(player2?.firstName ?? "") \(player2?.lastName ?? "")"
        if let image = player?.imageUrl {
            playerImageView1.loadImage(image)
        }
        if let image = player2?.imageUrl {
            playerImageView2.loadImage(image)
        }
    }

}

// MARK: - ViewCode

extension PlayerTableViewCell: ViewCode {
    
    func buildViewHierarchy() {
        cardView1.addSubview(textStackView1)
        cardView1.addSubview(playerImageView1)
        
        cardView2.addSubview(textStackView2)
        cardView2.addSubview(playerImageView2)
        
        contentView.addSubview(cardView1)
        contentView.addSubview(cardView2)
    }
    
    func setupConstraints() {
        let cardWidth = (UIScreen.main.bounds.width-13)/2
        
        [playerImageView1, playerImageView2].forEach { image in
            image.layer.cornerRadius = 8
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            image.heightAnchor.constraint(equalToConstant: 48.5).isActive = true
            image.widthAnchor.constraint(equalToConstant: 48.5).isActive = true
        }
        
        textStackView1.translatesAutoresizingMaskIntoConstraints = false
        textStackView1.topAnchor.constraint(equalTo: cardView1.topAnchor, constant: 15).isActive = true
        textStackView1.leadingAnchor.constraint(equalTo: cardView1.leadingAnchor, constant: 8).isActive = true
        textStackView1.trailingAnchor.constraint(equalTo: playerImageView1.leadingAnchor, constant: -8).isActive = true
        textStackView1.bottomAnchor.constraint(equalTo: cardView1.bottomAnchor, constant: -8).isActive = true
        
        playerImageView1.bottomAnchor.constraint(equalTo: cardView1.bottomAnchor, constant: -12).isActive = true
        playerImageView1.trailingAnchor.constraint(equalTo: cardView1.trailingAnchor, constant: -12).isActive = true
        
        cardView1.translatesAutoresizingMaskIntoConstraints = false
        cardView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5).isActive = true
        cardView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cardView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13.5).isActive = true
        cardView1.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true
        
        textStackView2.translatesAutoresizingMaskIntoConstraints = false
        textStackView2.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 15).isActive = true
        textStackView2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -8).isActive = true
        textStackView2.leadingAnchor.constraint(equalTo: playerImageView2.trailingAnchor, constant: 8).isActive = true
        textStackView2.bottomAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: -8).isActive = true
        
        playerImageView2.bottomAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: -12).isActive = true
        playerImageView2.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 12).isActive = true
        
        cardView2.translatesAutoresizingMaskIntoConstraints = false
        cardView2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5).isActive = true
        cardView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        cardView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13.5).isActive = true
        cardView2.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
