//
//  BrowseViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit

class BrowseViewController: UIViewController {
    
    private var presenter: BrowsePresenter!
    
    private lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 35,weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
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
    private var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupCollectionView()
        setUI()
        navigationItem.hidesBackButton = true
        presenter = BrowsePresenter(view: self)
        presenter.onViewDidLoad()
    }
    private func setUI(){
        view.addSubview(categoryLabel)
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(collectionView)
        //constraint
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.right.equalTo(filterButton.snp.left).offset(-10)
            make.height.equalTo(40)
        }
        filterButton.snp.makeConstraints { make in
                    make.centerY.equalTo(searchBar)
                    make.right.equalToSuperview().offset(-10)
                    make.width.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-30)
            }
        
    }
    func refreshCollectionView() {
            collectionView.reloadData()
        }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 190, height: 190) 
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    
        }
    

    

}
extension BrowseViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let service = presenter.service(at: indexPath.row)
        cell.configure(with: service)
        return cell
    }
    
    
}
