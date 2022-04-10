//
//  Container+Services.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/10/22.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        autoregister(RestClient.self, initializer: RestClient.init).inObjectScope(.container)
    }
}
