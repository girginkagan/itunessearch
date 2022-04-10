//
//  Container+RegisterDependencies.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Swinject

extension Container {
    func registerDependencies() {
        registerCoordinators()
        registerViewModels()
        registerServices()
    }
}
