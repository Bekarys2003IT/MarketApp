//
//  CollectionViewCell.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 29.05.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    lazy var whiteView: UIView = {
        let view = UIView()
               view.backgroundColor = .white
               view.layer.cornerRadius = 8
               view.layer.shadowColor = UIColor.black.cgColor
               view.layer.shadowOpacity = 0.1
               view.layer.shadowOffset = .zero
               view.layer.shadowRadius = 4
               view.clipsToBounds = true
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var foodLabel:UILabel = {
        let label = UILabel()
                label.font = .systemFont(ofSize: 22, weight: .bold)
                label.textColor = .white
                label.textAlignment = .center
                label.numberOfLines = 0
                return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(whiteView)
        whiteView.addSubview(iconImage)
        whiteView.addSubview(foodLabel)
        whiteView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        foodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

    }
    
    func configure(with service: BrowseService) {
        iconImage.image = UIImage(named: service.imageName)  
        foodLabel.text = service.name
    }
}
