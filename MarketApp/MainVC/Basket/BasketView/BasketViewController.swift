//
//  BasketViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit

protocol BasketViewProtocol: AnyObject {
    func deleteRow(at indexPath: IndexPath)
    func insertRow(at indexPath: IndexPath)
    func updateItems(_ items: [FoodItem])
    func reloadData()
}
class BasketViewController: UIViewController {
    private var presenter : BasketPresenter!
    private var favoriteItems: [FoodItem] = [] {
        didSet {
            basketTableView.reloadData()
        }
    }
    private let foodDB = FoodDB()
    
    private lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "My Favorites"
        label.font = .systemFont(ofSize: 35,weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return label
    }()
    private lazy var searchBar:UISearchBar = {
       let search = UISearchBar()
        search.placeholder = "Search your favorite"
        search.layer.borderColor = UIColor.lightGray.cgColor
        search.layer.borderWidth = 1
        search.layer.cornerRadius = 8
        return search
    }()
    private lazy var basketTableView:UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setUI()
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .favoritesUpdated, object: nil)
        loadFavorites()
        presenter = BasketPresenter(view: self, initialItems: favoriteItems)
    }
    private func setUI(){
        view.addSubview(categoryLabel)
        view.addSubview(searchBar)
        view.addSubview(basketTableView)
        //constraint
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        basketTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    @objc private func favoritesUpdated() {
            loadFavorites()
        }
        
    private func loadFavorites() {
        foodDB.fetchFavoriteItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.favoriteItems = items
                    self?.presenter.items = items
                    self?.basketTableView.reloadData()
                case .failure(let error):
                    print("Error fetching favorites: \(error)")
                }
            }
        }
    }
    func reloadData() {
            DispatchQueue.main.async {
                self.basketTableView.reloadData()
            }
        }
    func updateItems(_ items: [FoodItem]) {
            self.favoriteItems = items
        }

}
extension BasketViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
        let item = favoriteItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                presenter.deleteItemAt(indexPath: indexPath)
            }
        }
    
}
extension BasketViewController: BasketViewProtocol {
    func insertRow(at indexPath: IndexPath) {
        basketTableView.beginUpdates()
                basketTableView.insertRows(at: [indexPath], with: .automatic)
                basketTableView.endUpdates()
    }
    
    func deleteRow(at indexPath: IndexPath) {
        basketTableView.beginUpdates()
           basketTableView.deleteRows(at: [indexPath], with: .automatic)
           basketTableView.endUpdates()
    }
}
