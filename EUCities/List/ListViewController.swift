//
//  ListViewController.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

protocol ListViewControllerDelegate: class {
    func listViewControllerDelegateDidSelectCity(_ city:City)
}

class ListViewController: UIViewController {

    let tableView:UITableView = UITableView()

    weak var delegate:ListViewControllerDelegate?
    
    var viewModel:ListViewModel!
        
    override func loadView() {
      super.loadView()
        
        title = Strings.cities
        view.backgroundColor = UIColor.white
        
        setupTableView()
        setupFavoritesButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadCities {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CityTableViewCell.self)
        
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
    
    private func setupFavoritesButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.favorites, style: .plain, target: self, action: #selector(showFavorites))
    }
    
    @objc private func showFavorites() {
        viewModel.showFavorites = !viewModel.showFavorites
        navigationItem.rightBarButtonItem?.title = viewModel.showFavorites ? Strings.all : Strings.favorites
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CityTableViewCell.self, forIndexPath: indexPath)
        cell.favoriteButtonCallback = { [unowned self] in
            DispatchQueue.main.async {
                viewModel.toggleFavorite(atIndex: indexPath.row)
            }
        }
        viewModel.configure(cell, atIndex: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let city = viewModel.item(atIndex: indexPath.row) {
            delegate?.listViewControllerDelegateDidSelectCity(city)
        }
    }
}
