//
//  BaseTableViewCell.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    let bottomSeparator = UIView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBottomSeparator()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBottomSeparator() {
        contentView.addSubview(bottomSeparator)
        bottomSeparator.backgroundColor = Style.colorSeparator

        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 0.0).isActive = true
        bottomSeparator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0.0).isActive = true
        bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5).isActive = true
        bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
