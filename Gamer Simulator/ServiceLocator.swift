//
//  ServiceLocator.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 12/02/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation

var serviceLocator: IServiceLocator = ServiceLocator()

protocol IServiceLocator {
    var storage: IStorage {get}
}

class ServiceLocator: IServiceLocator {
    lazy var storage: IStorage = Storage()
}
