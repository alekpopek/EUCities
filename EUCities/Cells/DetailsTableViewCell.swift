//
//  DetailsTableViewCell.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

class DetailsTableViewCell: BaseTableViewCell {

    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLeftLabel()
        setupRightLabel()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeftLabel() {
        contentView.addSubview(leftLabel)

        leftLabel.font = Style.fontRegular(size: 16)
        leftLabel.textColor = Style.color140
        rightLabel.textAlignment = .left

        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
    }

    private func setupRightLabel() {
        contentView.addSubview(rightLabel)
        
        rightLabel.font = Style.fontRegular(size: 16)
        rightLabel.textColor = Style.color40
        rightLabel.textAlignment = .right

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        
        leftLabel.rightAnchor.constraint(equalTo: rightLabel.leftAnchor, constant: -10.0).isActive = true
        leftLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}
