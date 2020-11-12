//
//  CityTableViewCell.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

class CityTableViewCell: BaseTableViewCell {

    let mainImageView = UIImageView()
    let cityLabel = UILabel()
    let countryLabel = UILabel()
    let favoriteButton = UIButton(type: .custom)
    
    var isFavorite:Bool = false {
        didSet {
            if let image = UIImage(named: isFavorite ? "iconHeartSolid" : "iconHeartOutline") {
                favoriteButton.setImage(image, for: .normal)
            }
        }
    }
    
    var favoriteButtonCallback:(() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupMainImageView()
        setupFavoriteButton()
        setupCityLabel()
        setupCountryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImageView.image = nil
    }
            
    private func setupMainImageView() {
        contentView.addSubview(mainImageView)
        
        mainImageView.roundedCorners(5.0)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true

        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        mainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10.0).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 9/16).isActive = true
    }
    
    private func setupCityLabel() {
        contentView.addSubview(cityLabel)
        
        cityLabel.font = Style.fontRegular(size: 20)
        cityLabel.textColor = Style.color40

        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8.0).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10.0).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
    }

    private func setupFavoriteButton() {
        contentView.addSubview(favoriteButton)
        
        if let image = UIImage(named: "iconHeartOutline") {
            favoriteButton.setImage(image, for: .normal)
        }
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: -20)
        favoriteButton.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 0.0).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0.0).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor, multiplier: 1.0).isActive = true
    }

    private func setupCountryLabel() {
        contentView.addSubview(countryLabel)
        
        countryLabel.font = Style.fontRegular(size: 16)
        countryLabel.textColor = Style.color140

        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0.0).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10.0).isActive = true
        countryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0).isActive = true
    }
    
    @objc private func favoriteAction() {
        isFavorite = !isFavorite
        favoriteButtonCallback?()
    }
}
