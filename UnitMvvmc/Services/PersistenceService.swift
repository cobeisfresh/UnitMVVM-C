//
//  PersistenceService.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 01.10.2023..
//

import Foundation

protocol FavoritesPersistenceServiceProtocol {
    var favoritesMovies: [Movie] { get set }
}

protocol UserPersistenceProtocol {
    var currentUser: User? { get set }
}

class PersistenceService: FavoritesPersistenceServiceProtocol {
    private let userDefaults = UserDefaults.standard
    enum Key: String {
        case movies
        case user
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

extension PersistenceService: UserPersistenceProtocol {
    var currentUser: User? {
        get {
            userDefaults.object(forKey: Key.user.rawValue) as? User
        }
        set {
            userDefaults.set(newValue, forKey: Key.user.rawValue)
        }
    }
}

class FavoritesPersistenceServiceMock: FavoritesPersistenceServiceProtocol {
    var favoritesMovies =  [Movie]()
}
