//
//  Container+Coordinators.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SplashCoordinator.self, initializer: SplashCoordinator.init)
        autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
        autoregister(DetailCoordinator.self, initializer: DetailCoordinator.init)
    }
}
