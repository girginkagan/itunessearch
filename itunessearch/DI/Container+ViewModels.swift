//
//  Container+ViewModels.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(SplashViewModel.self, initializer: SplashViewModel.init)
        autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
    }
}
