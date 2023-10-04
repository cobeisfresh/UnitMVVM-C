//
//  ViewModel.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import Foundation

extension MovieList {
    @MainActor class ViewModel: ObservableObject {
        var onMovieSelected:((Movie) -> Void)?
        
        @Published var movies = [Movie]()
        @Published var error: String?
        
        private let moviesServices: MovieServiceProtocol
        init(moviesService: MovieServiceProtocol) {
            self.moviesServices = moviesService
            Task {
                await loadMovies()
            }
        }
        
        func loadMovies() async {
            let result = await moviesServices.getTopMovies()
            switch result {
            case .success(let movies):
                error = nil
                self.movies = movies
            case .failure(let error):
                self.error = error.localizedDescription
                self.movies = []
            }
        }
        
        func select(movie: Movie) {
            onMovieSelected?(movie)
        }
    }
}
