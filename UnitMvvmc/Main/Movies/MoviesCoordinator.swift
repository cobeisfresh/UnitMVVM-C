//
//  MoviesCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import Foundation
import UIKit
import SwiftUI

class MoviesCoordinator: Coordinator {
    var rootViewController: UIViewController?
    @MainActor func start() {
        let vm = MovieList.ViewModel(moviesService: serviceFactory.movieService)
        vm.onMovieSelected = { [weak self] movie in
            self?.showDetails(movie: movie)
        }
        let view = MovieList(viewModel: vm)
        let vc = UIHostingController(rootView: view)
        vc.title = "Movies"
        rootViewController = UINavigationController(rootViewController: vc)

    }
    
    let serviceFactory: ServiceFactory
    init (serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    @MainActor private func showDetails(movie: Movie) {
        let vm = MovieDetails.ViewModel(movie: movie, favoriteService: serviceFactory.favoriteService)
        let view = MovieDetails(viewModel: vm)
        let vc = UIHostingController(rootView: view)
        (rootViewController as? UINavigationController)?.pushViewController(vc, animated: true)
        
    }
}
