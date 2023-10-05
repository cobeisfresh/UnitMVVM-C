//
//  ProfileViewModel.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import Foundation

extension ProfileView {
    @MainActor class ViewModel: ObservableObject {

        @Published var user: User
        
        private let userService: UserServiceProtocol
        init(userService: UserServiceProtocol) {
            self.userService = userService
            user = userService.user.value ?? User.mocked
        }
        
        func logout() {
            userService.logout()
        }
    }
}
