//
//  FavoriteService.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 01.10.2023..
//

import Foundation

protocol FavoriteServiceProtocol {
    var favorites: [Movie] { get }
    
    func isfavorite(movie: Movie) -> Bool
    func addToFavorites(movie: Movie) -> AddToFavoritesResult
    func removeFromFavorites(movie: Movie) -> RemoveFromFavoritesResult
    func toggleFavorite(movie: Movie) -> ToggleFavoritesResult
}

enum AddToFavoritesResult {
    case added
    case alreadyAdded
}

enum RemoveFromFavoritesResult {
    case removed
    case notInFavorites
}

enum ToggleFavoritesResult {
    case added
    case removed
    var isAdded: Bool {
        switch self {
        case .added:
            return true
        case .removed:
            return false
        }
    }
}

class FavoriteService: FavoriteServiceProtocol {
    private var persistenceService: FavoritesPersistenceServiceProtocol
    private(set)var favorites: [Movie] {
        get {
            persistenceService.favoritesMovies
        }
        set {
            persistenceService.favoritesMovies = newValue
        }
    }
    public init(persistenceService: FavoritesPersistenceServiceProtocol) {
        self.persistenceService = persistenceService
        favorites = persistenceService.favoritesMovies
    }

    
    func isfavorite(movie: Movie) -> Bool {
        return favorites.contains(movie)
    }
    
    func addToFavorites(movie: Movie) -> AddToFavoritesResult {
        guard !isfavorite(movie: movie) else {
            return .alreadyAdded
        }
        favorites.append(movie)
        return .added
    }
    
    func removeFromFavorites(movie: Movie) -> RemoveFromFavoritesResult {
        guard let index = favorites.firstIndex(of: movie) else {
            return .notInFavorites
        }
        favorites.remove(at: index)
        return .removed
    }
    
    func toggleFavorite(movie: Movie) -> ToggleFavoritesResult {
        if isfavorite(movie: movie) {
            _ = removeFromFavorites(movie: movie)
            return ToggleFavoritesResult.removed
        }
        _ = addToFavorites(movie: movie)
        return ToggleFavoritesResult.added
    }
}


class FavoriteServiceMock: FavoriteServiceProtocol {
    var favorites: [Movie] {
        MockedMovies.best5Movies
    }
    func isfavorite(movie: Movie) -> Bool {
        return true
    }
    func addToFavorites(movie: Movie) -> AddToFavoritesResult {
        .added
    }
    
    func removeFromFavorites(movie: Movie) -> RemoveFromFavoritesResult {
        .removed
    }
    
    func toggleFavorite(movie: Movie) -> ToggleFavoritesResult {
        .removed
    }
}
