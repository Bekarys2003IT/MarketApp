//
//  BasketTableViewCell.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 30.05.2024.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let identifier = "BasketTableViewCell"
    
    private lazy var foodImageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    private lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .heavy)
        return label
    }()
    private lazy var priceLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .regular)
        return label
    }()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    private func setUI(){
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        

        //constraint
        foodImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func configure(with item: FoodItem) {
            titleLabel.text = item.title
            priceLabel.text = "$\(item.price)"
            if let url = URL(string: item.image) {
                foodImageView.kf.setImage(with: url)
            } else {
                foodImageView.image = nil
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
