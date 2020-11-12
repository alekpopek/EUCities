//
//  DetailsViewController.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

protocol DetailsViewControllerDelegate: class {
    func detailsViewControllerDelegateDidSelectMoreInfo(_ info:CityInfo?)
}

class DetailsViewController: UIViewController {

    let tableView:UITableView = UITableView()

    weak var delegate:DetailsViewControllerDelegate?
    
    var viewModel:DetailsViewModel!
    
    override func loadView() {
      super.loadView()
        
        title = viewModel.name
        
        view.backgroundColor = UIColor.white
        
        setupTableView()
        setupDetailsButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadAllData {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CityTableViewCell.self)
        tableView.register(DetailsTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300.0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupDetailsButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.details, style: .plain, target: self, action: #selector(showMore))
    }
    
    @objc private func showMore() {
        delegate?.detailsViewControllerDelegateDidSelectMoreInfo(viewModel.info)
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType(forIndexPath: indexPath)
        switch cellType {
        case .cityCellType:
            let cell = tableView.dequeueCell(CityTableViewCell.self, forIndexPath: indexPath)
            cell.favoriteButtonCallback = { [unowned self] in
                DispatchQueue.main.async {
                    viewModel.toggleFavorite(atIndex: indexPath.row)
                }
            }
            viewModel.configureCityCell(cell, atIndex: indexPath.row)
            return cell

        case .detailsCellType:
            let cell = tableView.dequeueCell(DetailsTableViewCell.self, forIndexPath: indexPath)
            viewModel.configureDetailsCell(cell, atIndex: indexPath.row)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = viewModel.cellType(forIndexPath: indexPath)
        switch cellType {
        case .cityCellType:
            return UITableView.automaticDimension
        case .detailsCellType:
            return 50.0
        }
    }
}
