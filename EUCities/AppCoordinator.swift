//
//  AppCoordinator.swift
//  EUCities
//
//  Created by Aleksander Popek on 11/11/2020.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
}

class AppCoordinator: Coordinator {

    var window: UIWindow?

    var navigationController: UINavigationController

    required init(navigationController:UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showListViewController()
    }
    
    func showListViewController() {
        /// Initialize viewModel
        let viewModel = ListViewModel()

        /// Initialize viewController and inject viewModel
        let viewController = ListViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self
        
        /// Set viewController as rootViewController in navigationController
        navigationController.viewControllers = [viewController]
    }
    
    func showDetailsViewController(withCity city:City) {
        /// Initialize viewModel
        let viewModel = DetailsViewModel(city: city)
        
        /// Initialize viewController and inject viewModel
        let viewController = DetailsViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self

        /// Push viewController in navigation stack
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMoreinfoViewController(withInfo info:CityInfo?) {
        /// Initialize viewController
        let viewController = MoreInfoViewController()
        viewController.info = info

        /// Initialize navigationController and present viewController modally
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - ListViewControllerDelegate

extension AppCoordinator: ListViewControllerDelegate {
    func listViewControllerDelegateDidSelectCity(_ city: City) {
        showDetailsViewController(withCity: city)
    }
}

// MARK: - DetailsViewControllerDelegate

extension AppCoordinator: DetailsViewControllerDelegate {
    func detailsViewControllerDelegateDidSelectMoreInfo(_ info:CityInfo?) {
        showMoreinfoViewController(withInfo: info)
    }
}
