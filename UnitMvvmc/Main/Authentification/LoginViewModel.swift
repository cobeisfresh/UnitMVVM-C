//
//  LoginViewModel.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import Foundation

extension LoginView {
    @MainActor class ViewModel: ObservableObject {

        @Published var userName: String
        
        private let userService: UserServiceProtocol
        init(userService: UserServiceProtocol) {
            self.userService = userService
            userName = userService.user.value?.username ?? User.mocked.username
        }
        
        func login() {
            userService.login(user: User(username: userName))
        }
    }
}
