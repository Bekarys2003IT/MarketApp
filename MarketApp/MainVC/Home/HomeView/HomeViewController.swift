//
//  HomeViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//
import UIKit
protocol HomeViewProtocol: AnyObject {
    func updateProfile(with name: String)
}
class HomeViewController: UIViewController, ButtonPresenterDelegate, FoodViewDelegate, FoodTableViewCellDelegate {
    
    private var networkingPresenter : FoodNetworking?
    private var buttonPresenter = HomeButtonPresenter()
    private var foodItems = [FoodItem]()
    private lazy var welcomeLabel:UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 18,weight: .light)
        label.textColor = UIColor(named: "labelColor")
        return label
    }()
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.font = .systemFont(ofSize: 23,weight: .heavy)
        label.textColor = UIColor(named: "labelColor")
        return label
    }()
    private lazy var searchBar:UISearchBar = {
       let search = UISearchBar()
        search.placeholder = "Search for a dish"
        search.layer.borderColor = UIColor.lightGray.cgColor
        search.layer.borderWidth = 1
        search.layer.cornerRadius = 8
        return search
    }()
    private lazy var filterButton:UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 25/255, green: 97/255, blue: 41/255, alpha: 1.0).cgColor
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fillEqually
        return stack
    }()
    private lazy var foodTableView:UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(FoodTableViewCell.self, forCellReuseIdentifier: "FoodTableViewCell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.hidesBackButton = true
        setUI()
        showPresenter()
        
    }
    private func setUI() {
        view.addSubview(welcomeLabel)
        view.addSubview(nameLabel)
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(foodTableView)
        
        //constraint
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(16)
        }
                
        nameLabel.snp.makeConstraints { make in
                    make.top.equalTo(welcomeLabel.snp.bottom).offset(5)
                    make.left.equalTo(welcomeLabel)
        }
                
        searchBar.snp.makeConstraints { make in
                    make.top.equalTo(nameLabel.snp.bottom).offset(10)
                    make.left.equalToSuperview().offset(10)
                    make.right.equalTo(filterButton.snp.left).offset(-10)
                    make.height.equalTo(40)
        }
                
        filterButton.snp.makeConstraints { make in
                    make.centerY.equalTo(searchBar)
                    make.right.equalToSuperview().offset(-10)
                    make.width.height.equalTo(40)
        }
                
        scrollView.snp.makeConstraints { make in
                    make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
                    make.height.equalTo(50)
        }
                
        stackView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
                
        foodTableView.snp.makeConstraints { make in
                    make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    private func showPresenter(){
        buttonPresenter.view = self  
        buttonPresenter.delegate = self
        networkingPresenter = FoodNetworking()
        networkingPresenter?.delegate = self
        networkingPresenter?.loadItems()
        buttonPresenter.loadButtons()
        buttonPresenter.loadProfile()
    }
    func displayButtons(titles: [String]) {
        for title in titles {
                    let button = UIButton(type: .system)
                    button.setTitle(title, for: .normal)
                    button.layer.cornerRadius = 8
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor.lightGray.cgColor
                    button.setTitleColor(UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0), for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
                    button.addTarget(self, action: #selector(scrollButton(_:)), for: .touchUpInside)
                    stackView.addArrangedSubview(button)
                }
            }
        func displayFoodItems(_ items: [FoodItem]) {
            DispatchQueue.main.async {
                   self.foodItems = items
                print("Now displaying \(self.foodItems.count) items.")
                   self.foodTableView.reloadData()
                print("TableView should be reloading with \(items.count) items.")
               }
        }
        
        func displayError(_ error: String) {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
        }
        @objc private func scrollButton(_ sender:UIButton) {
            stackView.arrangedSubviews.forEach { subview in
                guard let button = subview as? UIButton else { return }
                button.backgroundColor = .clear
                button.setTitleColor(UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0), for: .normal)
            }
            
            sender.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
            sender.setTitleColor(.white, for: .normal)
        }
        func buttonPressed(title: String) {
            print("Button with title \(title) pressed")
        }
    func loadProfile() {
        buttonPresenter.loadProfile()
    }
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows: \(foodItems.count)")
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = foodTableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as? FoodTableViewCell else { fatalError("Could not dequeue FoodTableViewCell")}
        let item = foodItems[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370 //Size of cells
    }
    func didTapFavoriteButton(on cell: FoodTableViewCell) {
            guard let indexPath = foodTableView.indexPath(for: cell) else { return }
            var item = foodItems[indexPath.row]
            item.isLiked = !(item.isLiked ?? false)
            networkingPresenter?.updateFavoriteStatus(for: item)
        }
}
extension HomeViewController: HomeViewProtocol {
        func updateProfile(with name: String) {
            nameLabel.text = name
    }
}
