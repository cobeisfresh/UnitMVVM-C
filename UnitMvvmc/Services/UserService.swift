//
//  UserService.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 04.10.2023..
//

import Foundation
import Combine
 
protocol UserServiceProtocol {
    var user: CurrentValueSubject<User?, Never> { get }
    func login(user: User)
    func logout()
}

class UserService: UserServiceProtocol {
    let user = CurrentValueSubject<User?, Never>(nil)
    var persistenceService: UserPersistenceProtocol
    init(persistenceService: UserPersistenceProtocol) {
        self.persistenceService = persistenceService
        self.user.value = persistenceService.currentUser
    }
    
    func login(user: User) {
        persistenceService.currentUser = user
        self.user.send(user)
    }
    func logout() {
        persistenceService.currentUser = nil
        user.send(nil)
    }
}

class UserServiceMock: UserServiceProtocol {
    let user: CurrentValueSubject<User?, Never> = .init(User.mocked)
    func login(user: User) {
        
    }
    func logout() {
        
    }
}
