//
//  Movie.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 30.09.2023..
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let year: Int
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}

extension Movie: Codable {

}


extension Movie {
    static let mocked = Movie(id: 1974, title: "Mocked movie title", year: 1974)
}
