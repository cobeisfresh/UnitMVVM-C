//
//  Coordinator.swift
//  UnitMvvmc
//
//  Created by Mladen Ivastinovic on 25.09.2023..
//

import Foundation
import UIKit


protocol Coordinator {
    func start()
    var rootViewController: UIViewController? { get }
}

extension Coordinator {
    var rootViewController: UIViewController? {
        return nil
    }
}
