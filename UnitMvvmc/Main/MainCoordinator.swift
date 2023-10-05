//
//  MainCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 25.09.2023..
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    let serviceFactory: ServiceFactory
    let user: User
    var rootViewController: UIViewController?
    private var childCoordinators = [Coordinator]()
    init(user: User, serviceFactory: ServiceFactory) {
        self.user = user
        self.serviceFactory = serviceFactory
    }
    
    @MainActor func start() {
        let tabVC = UITabBarController()
        tabVC.viewControllers = [createMovies(), createFavorites(), createProfile()]
        rootViewController = tabVC
    }
    
    @MainActor private func createMovies() -> UIViewController {
        let movies = MoviesCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(movies)
        movies.start()
        return movies.rootViewController!
    }
    
    @MainActor private func createFavorites() -> UIViewController {
        let favorites = FavoritesCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(favorites)
        favorites.start()
        return favorites.rootViewController!
    }
    
    @MainActor private func createProfile() -> UIViewController {
        let profile = ProfileCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(profile)
        profile.start()
        return profile.rootViewController!
    }
}
