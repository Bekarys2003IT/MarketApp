//
//  HomeTableViewCell.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//
import UIKit
import Kingfisher
class FoodTableViewCell: UITableViewCell {

    private lazy var foodImageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
    private lazy var heartButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 60, height: 60) // Adjust frame as needed
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        let image = UIImage(named: "heartIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.green
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    private func setUI(){
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(heartButton)
        //constraint
        foodImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        heartButton.snp.makeConstraints { make in
            make.bottom.equalTo(foodImageView.snp.bottom).offset(-10)
            make.trailing.equalToSuperview().offset(-10)
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
//            heartButton = item.isLiked
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
