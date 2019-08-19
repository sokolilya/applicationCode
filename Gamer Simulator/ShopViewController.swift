//
//  ShopViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class ShopViewController: UIViewController, GADInterstitialDelegate {
    
    var delegate : ShopDelegate?
    var allRubShop : Int! = 0
    var allDollarShop : Int! = 0
    var transportShop : String! = ""
    var realtyShop : String! = ""
    var techShop : String! = ""
    var checkCookerShop : Int! = 0
    var checkEat3000Shop : Int! = 0
    var checkTech : Int! = 0
    var checkRealty : Int! = 0
    var checkTransport : Int! = 0
    var checkRoomRent : Int! = 0
    var checkFlatRent : Int! = 0
    var checkNotebook : Int! = 0
    var checkI3PC : Int! = 0
    var checkConsole : Int! = 0
    var checkI5PC : Int! = 0
    var checkI7PC : Int! = 0
    var checkI9PC : Int! = 0
    var checkMonitor : Int! = 0
    var checkAllTech : Int! = 0
    var eatPointsShop : Int! = 0
    var smilePointsShop : Int! = 0
    var sleepPointsShop : Int! = 0
    var lastChanceShop : Int! = -1
    var checkLoseGameShop : Int! = 0
    
    var adChance : Int! = 0
    var interstitial: GADInterstitial!
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var eatPointsLabelShop: UILabel!
    @IBOutlet weak var smilePointsLabelShop: UILabel!
    @IBOutlet weak var sleepPointsLabelShop: UILabel!
    @IBAction func sleepPointsButtonAction(_ sender: Any) {
        sleepPointsShop = sleepPointsShop + 57
        smilePointsShop = smilePointsShop + 3
        eatPointsShop = eatPointsShop - 23
        if lastChanceShop > 0 {
            lastChanceShop = lastChanceShop - 1
        }
        lifeSetupShop()
        loseGameShop()
    }
    @IBAction func eatButtonAction(_ sender: Any) {
    }
    @IBAction func techButtonAction(_ sender: Any) {
    }
    @IBAction func realtyButtonAction(_ sender: Any) {
    }
    @IBAction func transportButtonAction(_ sender: Any) {
    }
    @IBAction func dollarsButtonAction(_ sender: Any) {
    }
    @IBAction func profileButtonActionShop(_ sender: Any) {
        delegate?.shopAction(rubShop: allRubShop, dollarShop: allDollarShop, transportShop: transportShop, realtyShop: realtyShop, buyedRealty: checkRealty, buyedTransport: checkTransport)
        delegate?.rentActionShop(roomRent: checkRoomRent, flatRent: checkFlatRent)
        delegate?.checkTechShop(notebook: checkNotebook, i3PC: checkI3PC, console: checkConsole, i5PC: checkI5PC, i7PC: checkI7PC, monitor: checkMonitor, i9PC: checkI9PC, check: checkAllTech)
        delegate?.eatAction(checkCooker: checkCookerShop, checkEat3000: checkEat3000Shop)
        delegate?.loseGameShop(lose: checkLoseGameShop, chance: lastChanceShop)
        delegate?.lifeActionShop(eat: eatPointsShop, smile: smilePointsShop, sleep: sleepPointsShop)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5876707192699554/7654571422")
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eatPointsLabelShop.text = String(eatPointsShop)
        smilePointsLabelShop.text = String(smilePointsShop)
        sleepPointsLabelShop.text = String(sleepPointsShop)
        lifeSetupShop()
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRealtyShop" {
            let vcS : ShopRealtyViewController = segue.destination as! ShopRealtyViewController
            vcS.delegate = self
            vcS.rubRealty = allRubShop
            vcS.dollarRealty = allDollarShop
            vcS.buyedRealty = realtyShop
            vcS.checkRealty = checkRealty
            vcS.roomRent = checkRoomRent
            vcS.flatRent = checkFlatRent
            vcS.smilePoints = smilePointsShop
        } else {
            if segue.identifier == "toRealtyShopP" {
                let vcS : ShopRealtyViewController = segue.destination as! ShopRealtyViewController
                vcS.delegate = self
                vcS.rubRealty = allRubShop
                vcS.dollarRealty = allDollarShop
                vcS.buyedRealty = realtyShop
                vcS.checkRealty = checkRealty
                vcS.roomRent = checkRoomRent
                vcS.flatRent = checkFlatRent
                vcS.smilePoints = smilePointsShop
            } else {
                if segue.identifier == "toTransportShop" {
                    let vcS : ShopTransportViewController = segue.destination as! ShopTransportViewController
                    vcS.delegate = self
                    vcS.rubTransport = allRubShop
                    vcS.dollarTransport = allDollarShop
                    vcS.buyedTransport = transportShop
                    vcS.checkBuyedTransport = checkTransport
                    vcS.smilePoints = smilePointsShop
                } else {
                    if segue.identifier == "toTransportShopP" {
                        let vcS : ShopTransportViewController = segue.destination as! ShopTransportViewController
                        vcS.delegate = self
                        vcS.rubTransport = allRubShop
                        vcS.dollarTransport = allDollarShop
                        vcS.buyedTransport = transportShop
                        vcS.checkBuyedTransport = checkTransport
                        vcS.smilePoints = smilePointsShop
                    } else {
                        if segue.identifier == "toTechShop" {
                            let vcS : ShopTechViewController = segue.destination as! ShopTechViewController
                            vcS.delegate = self
                            vcS.rubTech = allRubShop
                            vcS.dollarTech = allDollarShop
                            vcS.notebook = checkNotebook
                            vcS.i3PC = checkI3PC
                            vcS.console = checkConsole
                            vcS.i5PC = checkI5PC
                            vcS.i7PC = checkI7PC
                            vcS.monitor = checkMonitor
                            vcS.i9PC = checkI9PC
                            vcS.smilePoints = smilePointsShop
                            vcS.allTech = checkAllTech
                        } else {
                            if segue.identifier == "toTechShopP" {
                                let vcS : ShopTechViewController = segue.destination as! ShopTechViewController
                                vcS.delegate = self
                                vcS.rubTech = allRubShop
                                vcS.dollarTech = allDollarShop
                                vcS.notebook = checkNotebook
                                vcS.i3PC = checkI3PC
                                vcS.console = checkConsole
                                vcS.i5PC = checkI5PC
                                vcS.i7PC = checkI7PC
                                vcS.monitor = checkMonitor
                                vcS.i9PC = checkI9PC
                                vcS.smilePoints = smilePointsShop
                                vcS.allTech = checkAllTech
                            } else {
                                if segue.identifier == "toEatShop" {
                                    let vcS : ShopEatViewController = segue.destination as! ShopEatViewController
                                    vcS.delegate = self
                                    vcS.rubEat = allRubShop
                                    vcS.dollarEat = allDollarShop
                                    vcS.checkCooker = checkCookerShop
                                    vcS.checkEat3000 = checkEat3000Shop
                                    vcS.eatPoints = eatPointsShop
                                    vcS.smilePoints = smilePointsShop
                                    vcS.lastChance = lastChanceShop
                                } else {
                                    if segue.identifier == "toEatShopP" {
                                        let vcS : ShopEatViewController = segue.destination as! ShopEatViewController
                                        vcS.delegate = self
                                        vcS.rubEat = allRubShop
                                        vcS.dollarEat = allDollarShop
                                        vcS.checkCooker = checkCookerShop
                                        vcS.checkEat3000 = checkEat3000Shop
                                        vcS.eatPoints = eatPointsShop
                                        vcS.smilePoints = smilePointsShop
                                        vcS.lastChance = lastChanceShop
                                    } else {
                                        if segue.identifier == "toDollarsShop" {
                                            let vcS : DollarsShop = segue.destination as! DollarsShop
                                            vcS.delegate = self
                                            vcS.dollar = allDollarShop
                                        } else {
                                            if segue.identifier == "toDollarsShopP" {
                                                let vcS : DollarsShop = segue.destination as! DollarsShop
                                                vcS.delegate = self
                                                vcS.dollar = allDollarShop
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private func lifeSetupShop() {
        if sleepPointsShop > 0 {
            if sleepPointsShop > 100 {
                sleepPointsShop = 100
            }
        } else {
            if sleepPointsShop <= 0 {
                sleepPointsShop = 0
                if lastChanceShop < 0 {
                    lastChanceShop = 3
                }
            }
        }
        if smilePointsShop > 0 {
            if smilePointsShop > 100 {
                smilePointsShop = 100
            }
        } else {
            if smilePointsShop <= 0 {
                smilePointsShop = 0
                if lastChanceShop < 0 {
                    lastChanceShop = 3
                }
            }
        }
        if eatPointsShop > 0 {
            if eatPointsShop > 100 {
                eatPointsShop = 100
            }
        } else {
            if eatPointsShop <= 0 {
                eatPointsShop = 0
                if lastChanceShop < 0 {
                    lastChanceShop = 3
                }
            }
        }
        eatPointsLabelShop.text = String(eatPointsShop)
        smilePointsLabelShop.text = String(smilePointsShop)
        sleepPointsLabelShop.text = String(sleepPointsShop)
    }
    
    private func loseGameShop() {
        if locale.hasPrefix("ru") {
            if lastChanceShop == 0 {
                let alert = UIAlertController(title: "Внимание!!!", message: "Вы проиграли!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Начать заново", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameShop = 1
                    self.delegate?.loseGameShop(lose: self.checkLoseGameShop, chance: self.lastChanceShop)
                    self.delegate?.lifeActionShop(eat: self.eatPointsShop, smile: self.smilePointsShop, sleep: self.sleepPointsShop)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceShop == 3 {
                    let alert = UIAlertController(title: "Внимание!!!", message: "У вас есть \(lastChanceShop!) шага для того чтобы исправить ситуацию или вы проиграете! Потратьте их с пользой!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я справлюсь!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            if lastChanceShop == 0 {
                let alert = UIAlertController(title: "Attention!!!", message: "You lost!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Start new game", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameShop = 1
                    self.delegate?.loseGameShop(lose: self.checkLoseGameShop, chance: self.lastChanceShop)
                    self.delegate?.lifeActionShop(eat: self.eatPointsShop, smile: self.smilePointsShop, sleep: self.sleepPointsShop)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceShop == 3 {
                    let alert = UIAlertController(title: "Attention!!!", message: "You have \(lastChanceShop!) steps before you lose the game!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"I can win!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-5876707192699554/7654571422")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}

extension ShopViewController: EatShopDelegate {
    
    func lifeActionEatShop(eat: Int, smile: Int, lastChance: Int) {
        eatPointsShop = eat
        smilePointsShop = smile
        lastChanceShop = lastChance
        eatPointsLabelShop.text = String(eatPointsShop)
        smilePointsLabelShop.text = String(smilePointsShop)
    }
    
    func eatAction(rubEat: Int, dollarEat: Int, checkCooker: Int, checkEat3000: Int) {
        allRubShop = rubEat
        allDollarShop = dollarEat
        checkCookerShop = checkCooker
        checkEat3000Shop = checkEat3000
    }
}

extension ShopViewController: TechShopDelegate {
    
    func lifeActionTechShop(smile: Int) {
        smilePointsShop = smile
        smilePointsLabelShop.text = String(smilePointsShop)
    }
    
    func checkTech(notebook: Int, i3PC: Int, console: Int, i5PC: Int, i7PC: Int, monitor: Int, i9PC: Int, check: Int) {
        checkNotebook = notebook
        checkI3PC = i3PC
        checkConsole = console
        checkI5PC = i5PC
        checkI7PC = i7PC
        checkMonitor = monitor
        checkI9PC = i9PC
        checkAllTech = check
    }
    
    func techAction(rubTech: Int, dollarTech: Int) {
        allRubShop = rubTech
        allDollarShop = dollarTech
    }
}

extension ShopViewController: RealtyShopDelegate {
    
    func lifeActionRealtyShop(smile: Int) {
        smilePointsShop = smile
        smilePointsLabelShop.text = String(smilePointsShop)
    }
    
    func moneyRealty(rubRealty: Int, dollarRealty: Int) {
        allRubShop = rubRealty
        allDollarShop = dollarRealty
    }
    func rentAction(roomRent: Int, flatRent: Int) {
        checkRoomRent = roomRent
        checkFlatRent = flatRent
    }
    func realtyAction(buyedRealty: String, allRealty: Int) {
        checkRealty = allRealty
        realtyShop = buyedRealty
    }
}

extension ShopViewController: TransportShopDelegate {
    
    func lifeActionTransportShop(smile: Int) {
        smilePointsShop = smile
        smilePointsLabelShop.text = String(smilePointsShop)
    }
    
    func moneyTransport(rubTransport: Int, dollarTransport: Int) {
        allRubShop = rubTransport
        allDollarShop = dollarTransport
    }
    func transportAction(buyedTransport: String, allTransport: Int) {
        checkTransport = allTransport
        transportShop = buyedTransport
    }
}

extension ShopViewController: DollarsShopDelegate {
    
    func purchase(dollars: Int) {
        allDollarShop = dollars
    }
}
