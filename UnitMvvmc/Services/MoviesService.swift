//
//  MoviesSerice.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import Foundation

protocol MovieServiceProtocol {
    func getTopMovies() async ->  Result<[Movie], Error>
}

enum MovieError: Error {
    case general
}

extension MovieError: LocalizedError {
    public var errorDescription: String? {
           switch self {
           case .general:
               return NSLocalizedString("Something went wrong!", comment: "General error")
           }
       }
}


class MovieService: MovieServiceProtocol {
    func getTopMovies() async ->  Result<[Movie], Error> {
        guard Int.random(in: 1..<5) != 3 else {
            return .failure(MovieError.general)
        }
        let movies = MockedMovies.allMovies.prefix(Int.random(in: 1..<10))
        return .success(movies.shuffled())
    }
    

}

class MockedMovies {
    static let allMovies = [
        Movie(id: 2001, title: "2001: A Space Odyssey", year: 1968),
        Movie(id: 2002, title: "The Godfather", year: 1972),
        Movie(id: 2003, title: "Citizen Kane", year: 1941),
        Movie(id: 2004, title: "Jeanne Dielman, 23, Quai du Commerce, 1080 Bruxelles", year: 1975),
        Movie(id: 2005, title: "Raiders of the Lost Ark", year: 1981),
        Movie(id: 2006, title: "La Dolce Vita", year: 1960),
        Movie(id: 2007, title: "Seven Samurai", year: 1954),
        Movie(id: 2008, title: "In the Mood for Love", year: 2008),
        Movie(id: 2009, title: "There Will Be Blood", year: 2007),
        Movie(id: 2010, title: "Singin’ in the Rain", year: 1952)
    ]
    static let best5Movies = [
        Movie(id: 1, title: "The Shawshank Redemption", year: 1994),
        Movie(id: 2, title: "The Godfather", year: 1972),
        Movie(id: 3, title: "The Dark Knight", year: 2008),
        Movie(id: 4, title: "The Godfather Part II", year: 1974),
        Movie(id: 5, title: "12 Angry Men", year: 1957),
    ]
}

class MovieServiceMock: MovieServiceProtocol {
    var topMoviesMocked = [Movie]()
    func getTopMovies() async -> Result<[Movie], Error> {
        return .success(topMoviesMocked)
    }
}


class MovieServiceMock1: MovieServiceProtocol {
    func getTopMovies() async -> Result<[Movie], Error> {
        var movies = [Movie]()
        for index in 1..<10 {
            movies.append(Movie(id: index, title: "Movie \(index)", year: 1980 + index))
        }
        return .success(movies)
    }
}

class MovieServiceMock2: MovieServiceProtocol {
    func getTopMovies() async -> Result<[Movie], Error> {
        .success(
            [Movie(id: 1, title: "Here can be anything you want", year: 1974),
            Movie(id: 1, title: "Here can be anything you want 2", year: 1974)]
        )
    }
}

class MovieServiceMockError: MovieServiceProtocol {
    func getTopMovies() async -> Result<[Movie], Error> {
        .failure(MovieError.general)
    }
}
