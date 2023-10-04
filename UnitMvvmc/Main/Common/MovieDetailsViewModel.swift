//
//  MovieDetailsViewModel.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 01.10.2023..
//

import Foundation

extension MovieDetails {
    @MainActor class ViewModel: ObservableObject {
        @Published var movie: Movie
        @Published var isFavorite: Bool
        
        private let favoriteService: FavoriteServiceProtocol
        init(movie: Movie, favoriteService: FavoriteServiceProtocol) {
            self.favoriteService = favoriteService
            self.movie = movie
            self.isFavorite = favoriteService.isfavorite(movie: movie)
        }
        
        func toggleFavorites() {
            isFavorite = favoriteService.toggleFavorite(movie: movie).isAdded
        }
        
        func refresh() {
            self.isFavorite = favoriteService.isfavorite(movie: movie)
        }
    }
}
