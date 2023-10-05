//
//  AuthentificationCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 05.10.2023..
//

import Foundation
import UIKit
import SwiftUI

class AuthentificationCoordinator: Coordinator {
    var rootViewController: UIViewController?
    
    let serviceFactory: ServiceFactory
    init (serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    @MainActor func start() {
        let vm = LoginView.ViewModel(userService: serviceFactory.userService)
        let view = LoginView(viewModel: vm)
        let vc = UIHostingController(rootView: view)
        rootViewController = UINavigationController(rootViewController: vc)
    }
}
