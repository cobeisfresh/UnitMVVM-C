//
//  ProfileCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import Foundation
import UIKit
import SwiftUI


class ProfileCoordinator: Coordinator {
    var rootViewController: UIViewController?
    
    let serviceFactory: ServiceFactory
    init (serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    @MainActor func start() {
        let vm = ProfileView.ViewModel(userService: serviceFactory.userService)
        let view = ProfileView(viewModel: vm)
        let vc = UIHostingController(rootView: view)
        vc.title = "Profile"
        rootViewController = UINavigationController(rootViewController: vc)
    }
}
