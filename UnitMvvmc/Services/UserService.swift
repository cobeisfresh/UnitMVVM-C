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
    let persistenceService: UserPersistenceProtocol
    init(persistenceService: UserPersistenceProtocol) {
        self.persistenceService = persistenceService
        self.user.value = persistenceService.currentUser
    }
    
    func login(user: User) {
        
    }
    func logout() {
        
    }
}
