//
//  RootCoordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 25.09.2023..
//

import Foundation
import UIKit
import SwiftUI
import Combine

class RootCoordinator {
    let serviceFactory: ServiceFactory
    var user: User?
    var onRootChanged:((UIViewController) -> Void)?
    var rootViewController: UIViewController? {
        didSet {
            if let root = rootViewController {
                onRootChanged?(root)
            }
        }
    }
    private var childCoordinator: Coordinator?
    var cancellables = Set<AnyCancellable>()
    init (serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
}

extension RootCoordinator: Coordinator {
    @MainActor func start() {
        serviceFactory.userService.user.sink { [weak self] user in
            print("user changed = \(String(describing: user))")
            self?.start(user: user)
        }.store(in: &cancellables)
        start(user: serviceFactory.userService.user.value)
    }
}

private extension RootCoordinator {
    @MainActor func start(user: User?) {
        guard let user = user else {
            startWithoutUser()
            return
        }
        start(with: user)
    }
    @MainActor func startWithoutUser() {
        let authCoordintor = AuthentificationCoordinator(serviceFactory: serviceFactory)
        authCoordintor.start()
        rootViewController = authCoordintor.rootViewController
        childCoordinator = authCoordintor
    }
    
    @MainActor func start(with user: User) {
        let mainCoordintor = MainCoordinator(user: user, serviceFactory: serviceFactory)
        mainCoordintor.start()
        rootViewController = mainCoordintor.rootViewController
        childCoordinator = mainCoordintor
    }
}
