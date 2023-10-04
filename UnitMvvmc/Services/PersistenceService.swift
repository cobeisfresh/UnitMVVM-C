//
//  PersistenceService.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 01.10.2023..
//

import Foundation

protocol PersistenceServiceProtocol {
    var favoritesMovies: [Movie] { get set }
}

class PersistenceService: PersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    enum Key: String {
        case movies
    }
    var favoritesMovies: [Movie] {
        get {
            if let data = userDefaults.object(forKey: Key.movies.rawValue) as? Data {
                do {
                    return try JSONDecoder().decode([Movie].self, from: data)
                } catch {
                    print("Error while decoding user data")
                }
            }
            return []
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: Key.movies.rawValue)
            } catch {
                print("Error while encoding user data")
            }
        }
    }
}

class PersistenceServiceMock: PersistenceServiceProtocol {
    var favoritesMovies =  [Movie]()
}
