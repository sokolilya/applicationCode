//
//  Protocols.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 31/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation

protocol WorkDelegate {
    func loseGameWork(lose: Int, chance: Int)
    func rubChangeWork(rubWork: Int)
    func rentActionWork(roomRent: Int, flatRent: Int, checkRealty: Int)
    func workDone(salary: Int, masterPoints: Int)
    func yourProfession(profession: String, check1: Int, check2: Int, check3: Int, check4: Int, check5: Int, check6: Int, check7: Int)
    func lifeActionWork(eat: Int, smile: Int, sleep: Int)
}

protocol BankDelegate {
    func loseGameBank(lose: Int, chance: Int)
    func lifeActionBank(eat: Int, smile: Int, sleep: Int)
    func bankAction(rubBank: Int, dollarBank: Int)
}

protocol ControllerDelegate {
    func loseGameController(lose: Int, chance: Int)
    func rubChangeC(rubC: Int)
    func rentActionController(roomRent: Int, flatRent: Int, checkRealty: Int)
    func controllerAction(rubC: Int, dollarC: Int, masterPointsC: Int, popularityPointsC: Int)
    func changes(plays: Int, games: Int, buyedGames: Int, letsPlays: Int, allowedCards: Int, visitedEvents: Int)
    func profession(profession: String)
    func lifeActionController(eat: Int, smile: Int, sleep: Int)
}

protocol ShopDelegate {
    func loseGameShop(lose: Int, chance: Int)
    func shopAction(rubShop: Int, dollarShop: Int, transportShop: String, realtyShop: String, buyedRealty: Int, buyedTransport: Int)
    func rentActionShop(roomRent: Int, flatRent: Int)
    func checkTechShop(notebook: Int, i3PC: Int, console: Int, i5PC: Int, i7PC: Int, monitor: Int, i9PC: Int, check: Int)
    func eatAction(checkCooker: Int, checkEat3000: Int)
    func lifeActionShop(eat: Int, smile: Int, sleep: Int)
}

protocol EatShopDelegate {
    func eatAction(rubEat: Int, dollarEat: Int, checkCooker: Int, checkEat3000: Int)
    func lifeActionEatShop(eat: Int, smile: Int, lastChance: Int)
}

protocol RealtyShopDelegate {
    func moneyRealty(rubRealty: Int, dollarRealty: Int)
    func realtyAction(buyedRealty: String, allRealty: Int)
    func rentAction(roomRent: Int, flatRent: Int)
    func lifeActionRealtyShop(smile: Int)
}

protocol TransportShopDelegate {
    func moneyTransport(rubTransport: Int, dollarTransport: Int)
    func transportAction(buyedTransport: String, allTransport: Int)
    func lifeActionTransportShop(smile: Int)
}

protocol TechShopDelegate {
    func techAction(rubTech: Int, dollarTech: Int)
    func checkTech(notebook: Int, i3PC: Int, console: Int, i5PC: Int, i7PC: Int, monitor: Int, i9PC: Int, check: Int)
    func lifeActionTechShop(smile: Int)
}

protocol DollarsShopDelegate {
    func purchase(dollars: Int)
}
