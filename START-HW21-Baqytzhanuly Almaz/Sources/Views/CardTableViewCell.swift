//
//  CardTableViewCell.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/11/23.
//

import UIKit

class CardTableViewCell: UITableViewCell {

// MARK: - Properties
    
    static let identifier = "CardTableViewCell"
    let networkManager = NetworkManager()
    private var imagePath: String?
    
// MARK: - Configurations
    
    func configure(with model: Card) {
        self.nameLabel.text = "Card name: \(model.name)"
        self.imagePath = model.imageUrl
        guard let imageURL = model.imageUrl else {
            self.cardImageView.image = UIImage(systemName: "photo")
            return }
        if imageURL == self.imagePath {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.networkManager.getImage(from: imageURL) { [weak self] cardImage in
                    DispatchQueue.main.async {
                        self?.cardImageView.image = cardImage
                    }
                }
            }
        }
    }
    
// MARK: - UI
    
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
// MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Setups
    
    private func setupViews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

// MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cardImageView.image = nil
        self.nameLabel.text = nil
    }
}
