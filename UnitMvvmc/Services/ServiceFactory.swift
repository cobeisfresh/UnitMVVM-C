//
//  ServiceFactory.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 29.09.2023..
//

import Foundation

class ServiceFactory {
    lazy var movieService: MovieServiceProtocol = {
        MovieService()
    }()
    
    lazy var favoriteService: FavoriteServiceProtocol = {
        FavoriteService(persistenceService: persistenceService)
    }()
    
    lazy var persistenceService: PersistenceServiceProtocol = {
        PersistenceService()
    }()
}
