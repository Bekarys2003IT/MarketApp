//
//  HomeTableViewCell.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//
import UIKit
import Kingfisher
protocol FoodTableViewCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: FoodTableViewCell)
}
class FoodTableViewCell: UITableViewCell {

    weak var delegate:FoodTableViewCellDelegate?
    
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
    private lazy var likeView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = .init(x: 0, y: 0, width: 60, height: 60)
        view.layer.cornerRadius = view.frame.width/2
        return view
    }()
    private lazy var favoriteButton:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = UIColor.green
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let filledImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
           button.setImage(filledImage, for: .selected)
        button.addTarget(self, action: #selector(isFavoriteTapped), for: .touchUpInside)
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
        contentView.addSubview(likeView)
        likeView.addSubview(favoriteButton)
        contentView.bringSubviewToFront(likeView)
        //constraint
       
        foodImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
        likeView.snp.makeConstraints { make in
            make.bottom.equalTo(foodImageView.snp.bottom).offset(-10)
            make.trailing.equalTo(foodImageView.snp.trailing).offset(-10)
            make.width.height.equalTo(60)
        }

        favoriteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(35)
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
        favoriteButton.isSelected = FavoritesManager.shared.isFavorite(item)
        }
    @objc private func isFavoriteTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.tintColor = sender.isSelected ? UIColor.green : UIColor.green
        delegate?.didTapFavoriteButton(on: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
