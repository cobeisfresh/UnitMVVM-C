//
//  RootCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 25.09.2023..
//

import Foundation
import UIKit
import SwiftUI

class RootCoordinator {
    let serviceFactory: ServiceFactory
    var user: User?
    var rootViewController: UIViewController?
    private var childCoordinator: Coordinator?
    init (serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
}

extension RootCoordinator: Coordinator {
    @MainActor func start() {
        user = User.mocked
        guard let user = user else {
            startWithoutUser()
            return
        }
        start(with: user)
    }
}

private extension RootCoordinator {
    func startWithoutUser() {
        let rootView = RootView()
        rootViewController = UIHostingController(rootView: rootView)
    }
    
    @MainActor func start(with user: User) {
        let mainCoordintor = MainCoordinator(user: user, serviceFactory: serviceFactory)
        mainCoordintor.start()
        rootViewController = mainCoordintor.rootViewController
        childCoordinator = mainCoordintor
    }
}
