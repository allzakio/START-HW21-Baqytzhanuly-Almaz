//
//  DetailViewController.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/12/23.
//

import UIKit

class ModalViewController: UIViewController {

// MARK: - Properties

    let networkManager = NetworkManager()
    var card: Card?

// MARK: - Configurations
    
    private func configureView() {
        guard let cardName = card?.name, let cardText = card?.text else { return }
        self.nameLabel.text = "Card name: \(cardName)"
        self.descriptionLabel.text = "Description: \(cardText)"
        guard let imageURL = card?.imageUrl else {
            self.cardImageView.image = UIImage(systemName: "photo")
            return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.networkManager.getImage(from: imageURL) { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.cardImageView.image = image
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
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 10
        label.textAlignment = .center
        return label
    }()
    
// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
    }

// MARK: - Setups
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(220)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
}
