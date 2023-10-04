//
//  MovieDetailsViewModel.swift
//  UnitMvvmcTests
//
//  Created by Mladen Ivastinovic on 04.10.2023..
//

import XCTest
@testable import UnitMvvmc

final class MovieDetailsViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testAddedToFavorites() {
        let movie = Movie.mocked
        let persistenceServiceMocked = PersistenceServiceMock()
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        let vm = MovieDetails.ViewModel(movie: movie, favoriteService: favoriteService)
        XCTAssertFalse(vm.isFavorite)
        vm.toggleFavorites()
        XCTAssert(vm.isFavorite)
    }
    
    @MainActor func testRemovingFromFavorites() {
        let movie = Movie.mocked
        let persistenceServiceMocked = PersistenceServiceMock()
        persistenceServiceMocked.favoritesMovies = [movie]
        let favoriteService = FavoriteService(persistenceService: persistenceServiceMocked)
        let vm = MovieDetails.ViewModel(movie: movie, favoriteService: favoriteService)
        XCTAssert(vm.isFavorite)
        vm.toggleFavorites()
        XCTAssertFalse(vm.isFavorite)
    }

}
