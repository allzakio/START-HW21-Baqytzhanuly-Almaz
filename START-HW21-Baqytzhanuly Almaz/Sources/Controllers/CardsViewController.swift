//
//  CardsViewController.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/11/23.
//

import UIKit

class CardsViewController: UIViewController {
    
// MARK: - Properties
    
    var model = Cards() 
    let networkManager = NetworkManager()
    let cardsURL: String? = "https://api.magicthegathering.io/v1/cards"

// MARK: - Configurations
    
    private func configureView() {
        guard let cardsURL = cardsURL else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.networkManager.getCards(from: cardsURL) { [weak self] cards in
                DispatchQueue.main.async {
                    self?.model.cards = cards
                    self?.cardTableView.reloadData()
                }
            }
        }
    }
    
// MARK: - UI

    private lazy var cardTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        title = "Cards"
        view.backgroundColor = .systemBackground
        view.addSubview(cardTableView)
    }
    
    private func setupConstraints() {
        cardTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }
        let model = model.cards[indexPath.row]
        cell.configure(with: model)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modalViewController = ModalViewController()
        modalViewController.card = model.cards[indexPath.row]
        if let navigator = navigationController {
            navigator.pushViewController(modalViewController, animated: true)
        }
    }
}
