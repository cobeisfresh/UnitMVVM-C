//
//  FavoriteServiceTests.swift
//  UnitMvvmcTests
//
//  Created by Mladen Ivastinovic on 03.10.2023..
//

import XCTest
@testable import UnitMvvmc

final class FavoriteServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFavoriteAdded() {
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        let result = favoriteService.addToFavorites(movie: Movie.mocked)
        XCTAssert(result == .added)
    }
    
    func testFavoriteAlreadyAdded() {
        let movie = Movie.mocked
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        persistenceServiceMocked.favoritesMovies = [movie]
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        
        let result = favoriteService.addToFavorites(movie: movie)
        XCTAssert(result == .alreadyAdded)
    }
    
    func testFavoriteRemoved() {
        let movie = Movie.mocked
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        persistenceServiceMocked.favoritesMovies = [movie]
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        
        let result = favoriteService.removeFromFavorites(movie: movie)
        XCTAssert(result == .removed)
    }
    
    func testFavoriteNotRemoved() {
        let movie = Movie.mocked
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        
        let result = favoriteService.removeFromFavorites(movie: movie)
        XCTAssert(result == .notInFavorites)
    }
    
    func testFavoriteToggleAdd() {
        let movie = Movie.mocked
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        
        let result = favoriteService.toggleFavorite(movie: movie)
        XCTAssert(result == .added)
    }
    
    func testFavoriteToggleRemoved() {
        let movie = Movie.mocked
        let persistenceServiceMocked = FavoritesPersistenceServiceMock()
        persistenceServiceMocked.favoritesMovies = [movie]
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        
        let result = favoriteService.toggleFavorite(movie: movie)
        XCTAssert(result == .removed)
    }

}
