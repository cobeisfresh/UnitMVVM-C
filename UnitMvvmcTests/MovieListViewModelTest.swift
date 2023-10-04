//
//  MovieListViewModelTest.swift
//  UnitMvvmcTests
//
//  Created by Mladen Ivastinovic on 04.10.2023..
//

import XCTest
@testable import UnitMvvmc

final class MovieListViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testLoadingMovies() async {
        let movies = MockedMovies.best5Movies
        let moviesService = MovieServiceMock()
        moviesService.topMoviesMocked = movies
        let vm = MovieList.ViewModel(moviesService: moviesService)
        XCTAssert(vm.movies.count == 0)
        await vm.loadMovies()
        XCTAssert(vm.movies.count == movies.count)
    }
    
    @MainActor func testMovieSelection() async {
        let movie = Movie.mocked
        let moviesService = MovieServiceMock()
        moviesService.topMoviesMocked = [movie]
        let vm = MovieList.ViewModel(moviesService: moviesService)
        await vm.loadMovies()
        
        
        // 1. Define an expectation
        let expectation = expectation(description: "onMovieSelected called")
        
        // 2. Exercise the asynchronous code
        vm.onMovieSelected = { selected in
            XCTAssertTrue(selected == movie)
            expectation.fulfill()
        }
        vm.select(movie: movie)
        
        // waitForExpectations(timeout: 1)
        await fulfillment(of: [expectation], timeout: 1)
    }
}
