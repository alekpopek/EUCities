//
//  MoreInfoViewController.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import UIKit

class MoreInfoViewController: UIViewController {

    let scrollView:UIScrollView = UIScrollView()
    let infoLabel:UILabel = UILabel()
    
    var info:CityInfo?
    
    override func loadView() {
      super.loadView()
        
        title = Strings.details
        view.backgroundColor = UIColor.white
        
        setupCloseButton()
        setupScrollView()
        setupLabel()
    }
        
    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Strings.close, style: .plain, target: self, action: #selector(close)
        )
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupLabel() {
        scrollView.addSubview(infoLabel)
        
        infoLabel.font = Style.fontRegular(size: 16)
        infoLabel.textColor = Style.color40
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .justified
        infoLabel.text = info?.about

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8.0).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor,constant: 10.0).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10.0).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20.0).isActive = true
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: {})
    }
}
