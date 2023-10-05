//
//  User.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 04.10.2023..
//

import Foundation

struct User: Codable {
    let username: String
    //let id = UUID().uuidString
}

extension User {
    static let mocked = User(username: "Cobe")
}
