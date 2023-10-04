//
//  FavoritesViewModel.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 03.10.2023..
//

import Foundation

extension FavoritesView {
    @MainActor class ViewModel: ObservableObject {
        var onMovieSelected:((Movie) -> Void)?
        
        @Published var favorites = [Movie]()
        
        private let favoritesService: FavoriteServiceProtocol
        init(favoritesService: FavoriteServiceProtocol) {
            self.favoritesService = favoritesService
            favorites = favoritesService.favorites
        }
        
        func select(movie: Movie) {
            onMovieSelected?(movie)
        }
        
        func refresh() {
            favorites = favoritesService.favorites
        }
    }
}

