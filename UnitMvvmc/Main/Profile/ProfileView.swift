//
//  ProfileView.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("Hello, \(viewModel.user.username)")
            Spacer()
            Button("Logout!") {
                viewModel.logout()
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileView.ViewModel(userService: UserServiceMock()))
}
