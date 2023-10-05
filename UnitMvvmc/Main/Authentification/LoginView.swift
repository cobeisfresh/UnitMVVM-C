//
//  LoginView.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.userName)
            Spacer()
            Button("Login") {
                viewModel.login()
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginView.ViewModel(userService: UserServiceMock()))
}
