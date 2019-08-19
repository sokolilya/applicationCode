//
//  ShopRealtyViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit

class ShopRealtyViewController: UIViewController {
    
    var delegate : RealtyShopDelegate?
    var rubRealty : Int! = 0
    var dollarRealty : Int! = 0
    var buyedRealty : String! = ""
    var roomRent : Int! = 0
    var flatRent : Int! = 0
    var checkRealty : Int! = 0
    var checked : String! = "Пройдено"
    var checkedEn : String! = "Not for me"
    var smilePoints : Int! = 0
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var sleepOnRailwayStationLabel: UILabel!
    @IBOutlet weak var railwayButton: UIButton!
    @IBOutlet weak var rentRoomLabel: UILabel!
    @IBOutlet weak var roomButton: UIButton!
    @IBOutlet weak var rentFlatLabel: UILabel!
    @IBOutlet weak var rentFlatButton: UIButton!
    @IBOutlet weak var buyFlatLabel: UILabel!
    @IBOutlet weak var buyFlatButton: UIButton!
    @IBOutlet weak var buyPenthouseLabel: UILabel!
    @IBOutlet weak var buyPenthouseButton: UIButton!
    @IBOutlet weak var buyVillaLabel: UILabel!
    @IBOutlet weak var buyVillaButton: UIButton!
    @IBAction func sleepRailwayStationAction(_ sender: Any) {
        if locale.hasPrefix("ru") {
            delegate?.realtyAction(buyedRealty: "Бомж на вокзале", allRealty: 1)
        } else {
            delegate?.realtyAction(buyedRealty: "Bum on railway", allRealty: 1)
        }
        
        checkRealty = 1
        smilePoints = smilePoints + 5
        lifeSetupRealty()
        checkBuyedRealty(buyed: checkRealty)
    }
    
    @IBAction func rentRoomAction(_ sender: Any) {
        if rubRealty >= 7000 {
            if locale.hasPrefix("ru") {
                delegate?.realtyAction(buyedRealty: "Снимает комнату", allRealty: 2)
            } else {
                delegate?.realtyAction(buyedRealty: "Rent room", allRealty: 2)
            }
            roomRent = roomRent + 30
            rubRealty = rubRealty - 7000
            checkRealty = 2
            smilePoints = smilePoints + 15
            lifeSetupRealty()
            checkBuyedRealty(buyed: checkRealty)
        } else {
            noMoney(money: 7000)
        }
    }
    
    @IBAction func rentFlatAction(_ sender: Any) {
        if rubRealty >= 25000 {
            if locale.hasPrefix("ru") {
                delegate?.realtyAction(buyedRealty: "Снимает квартиру", allRealty: 3)
            } else {
                delegate?.realtyAction(buyedRealty: "Rent flat", allRealty: 3)
            }
            
            flatRent = flatRent + 30
            rubRealty = rubRealty - 25000
            checkRealty = 3
            smilePoints = smilePoints + 25
            lifeSetupRealty()
            checkBuyedRealty(buyed: checkRealty)
        } else {
            noMoney(money: 25000)
        }
    }
    
    @IBAction func buyFlatAction(_ sender: Any) {
        if rubRealty >= 2300000 {
            if locale.hasPrefix("ru") {
                delegate?.realtyAction(buyedRealty: "Квартира", allRealty: 4)
            } else {
                delegate?.realtyAction(buyedRealty: "Flat", allRealty: 4)
            }
            
            rubRealty = rubRealty - 2300000
            checkRealty = 4
            smilePoints = smilePoints + 45
            lifeSetupRealty()
            checkBuyedRealty(buyed: checkRealty)
            buySuccess()
        } else {
            noMoney(money: 2300000)
        }
    }
    
    @IBAction func buyPenthouseAction(_ sender: Any) {
        if dollarRealty >= 150000 {
            if locale.hasPrefix("ru") {
                delegate?.realtyAction(buyedRealty: "Пентхаус", allRealty: 5)
            } else {
                delegate?.realtyAction(buyedRealty: "Penthause", allRealty: 5)
            }
            
            dollarRealty = dollarRealty - 150000
            checkRealty = 5
            smilePoints = smilePoints + 70
            lifeSetupRealty()
            checkBuyedRealty(buyed: checkRealty)
            buySuccess()
        } else {
            noDollar(dollar: 150000)
        }
    }
    
    @IBAction func buyVillaAction(_ sender: Any) {
        if dollarRealty >= 500000 {
            if locale.hasPrefix("ru") {
                delegate?.realtyAction(buyedRealty: "Вилла", allRealty: 6)
            } else {
                delegate?.realtyAction(buyedRealty: "Villa", allRealty: 6)
            }
            
            dollarRealty = dollarRealty - 500000
            checkRealty = 6
            smilePoints = smilePoints + 90
            lifeSetupRealty()
            checkBuyedRealty(buyed: checkRealty)
            buySuccess()
        } else {
            noDollar(dollar: 500000)
        }
    }
    
    @IBAction func backToShopRealtyAction(_ sender: Any) {
        delegate?.rentAction(roomRent: roomRent, flatRent: flatRent)
        delegate?.moneyRealty(rubRealty: rubRealty, dollarRealty: dollarRealty)
        delegate?.lifeActionRealtyShop(smile: smilePoints)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBuyedRealty(buyed: checkRealty)
    }
    
    private func noMoney(money: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(money - rubRealty!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(money - rubRealty!) rub!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noDollar(dollar: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(dollar - dollarRealty!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(dollar - dollarRealty!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkBuyedRealty(buyed: Int) {
        if locale.hasPrefix("ru") {
            if checkRealty == 6 {
                buyVillaLabel.text = "Куплено"
                buyVillaButton.isUserInteractionEnabled = false
                buyPenthouseLabel.text = checked
                buyPenthouseButton.isUserInteractionEnabled = false
                buyFlatLabel.text = checked
                buyFlatButton.isUserInteractionEnabled = false
                rentFlatLabel.text = checked
                rentFlatButton.isUserInteractionEnabled = false
                rentRoomLabel.text = checked
                roomButton.isUserInteractionEnabled = false
                sleepOnRailwayStationLabel.text = checked
                railwayButton.isUserInteractionEnabled = false
            } else {
                if checkRealty == 5 {
                    buyPenthouseLabel.text = "Куплено"
                    buyPenthouseButton.isUserInteractionEnabled = false
                    buyFlatLabel.text = checked
                    buyFlatButton.isUserInteractionEnabled = false
                    rentFlatLabel.text = checked
                    rentFlatButton.isUserInteractionEnabled = false
                    rentRoomLabel.text = checked
                    roomButton.isUserInteractionEnabled = false
                    sleepOnRailwayStationLabel.text = checked
                    railwayButton.isUserInteractionEnabled = false
                } else {
                    if checkRealty == 4 {
                        buyFlatLabel.text = "Куплено"
                        buyFlatButton.isUserInteractionEnabled = false
                        rentFlatLabel.text = checked
                        rentFlatButton.isUserInteractionEnabled = false
                        rentRoomLabel.text = checked
                        roomButton.isUserInteractionEnabled = false
                        sleepOnRailwayStationLabel.text = checked
                        railwayButton.isUserInteractionEnabled = false
                    } else {
                        if checkRealty == 3 {
                            rentFlatLabel.text = "Аренда"
                            rentFlatButton.isUserInteractionEnabled = false
                            rentRoomLabel.text = checked
                            roomButton.isUserInteractionEnabled = false
                            sleepOnRailwayStationLabel.text = checked
                            railwayButton.isUserInteractionEnabled = false
                        } else {
                            if checkRealty == 2 {
                                rentRoomLabel.text = "Аренда"
                                roomButton.isUserInteractionEnabled = false
                                sleepOnRailwayStationLabel.text = checked
                                railwayButton.isUserInteractionEnabled = false
                            } else {
                                if checkRealty == 1 {
                                    sleepOnRailwayStationLabel.text = "Пока так"
                                    railwayButton.isUserInteractionEnabled = false
                                } else {
                                    if checkRealty == 0 {
                                        buyVillaLabel.text = "500000 $"
                                        buyVillaButton.isUserInteractionEnabled = true
                                        buyPenthouseLabel.text = "150000 $"
                                        buyPenthouseButton.isUserInteractionEnabled = true
                                        buyFlatLabel.text = "2,3 млн. руб."
                                        buyFlatButton.isUserInteractionEnabled = true
                                        rentFlatLabel.text = "25000 руб."
                                        roomButton.isUserInteractionEnabled = true
                                        sleepOnRailwayStationLabel.text = "Бесплатно"
                                        railwayButton.isUserInteractionEnabled = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if checkRealty == 6 {
                buyVillaLabel.text = "Bought"
                buyVillaButton.isUserInteractionEnabled = false
                buyPenthouseLabel.text = checkedEn
                buyPenthouseButton.isUserInteractionEnabled = false
                buyFlatLabel.text = checkedEn
                buyFlatButton.isUserInteractionEnabled = false
                rentFlatLabel.text = checkedEn
                rentFlatButton.isUserInteractionEnabled = false
                rentRoomLabel.text = checkedEn
                roomButton.isUserInteractionEnabled = false
                sleepOnRailwayStationLabel.text = checkedEn
                railwayButton.isUserInteractionEnabled = false
            } else {
                if checkRealty == 5 {
                    buyPenthouseLabel.text = "Bought"
                    buyPenthouseButton.isUserInteractionEnabled = false
                    buyFlatLabel.text = checkedEn
                    buyFlatButton.isUserInteractionEnabled = false
                    rentFlatLabel.text = checkedEn
                    rentFlatButton.isUserInteractionEnabled = false
                    rentRoomLabel.text = checkedEn
                    roomButton.isUserInteractionEnabled = false
                    sleepOnRailwayStationLabel.text = checkedEn
                    railwayButton.isUserInteractionEnabled = false
                } else {
                    if checkRealty == 4 {
                        buyFlatLabel.text = "Bought"
                        buyFlatButton.isUserInteractionEnabled = false
                        rentFlatLabel.text = checkedEn
                        rentFlatButton.isUserInteractionEnabled = false
                        rentRoomLabel.text = checkedEn
                        roomButton.isUserInteractionEnabled = false
                        sleepOnRailwayStationLabel.text = checkedEn
                        railwayButton.isUserInteractionEnabled = false
                    } else {
                        if checkRealty == 3 {
                            rentFlatLabel.text = "Rent"
                            rentFlatButton.isUserInteractionEnabled = false
                            rentRoomLabel.text = checkedEn
                            roomButton.isUserInteractionEnabled = false
                            sleepOnRailwayStationLabel.text = checkedEn
                            railwayButton.isUserInteractionEnabled = false
                        } else {
                            if checkRealty == 2 {
                                rentRoomLabel.text = "Rent"
                                roomButton.isUserInteractionEnabled = false
                                sleepOnRailwayStationLabel.text = checkedEn
                                railwayButton.isUserInteractionEnabled = false
                            } else {
                                if checkRealty == 1 {
                                    sleepOnRailwayStationLabel.text = "For first time"
                                    railwayButton.isUserInteractionEnabled = false
                                } else {
                                    if checkRealty == 0 {
                                        buyVillaLabel.text = "500000 $"
                                        buyVillaButton.isUserInteractionEnabled = true
                                        buyPenthouseLabel.text = "150000 $"
                                        buyPenthouseButton.isUserInteractionEnabled = true
                                        buyFlatLabel.text = "2,3 million rub"
                                        buyFlatButton.isUserInteractionEnabled = true
                                        rentFlatLabel.text = "25000 rub"
                                        roomButton.isUserInteractionEnabled = true
                                        sleepOnRailwayStationLabel.text = "Free"
                                        railwayButton.isUserInteractionEnabled = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func lifeSetupRealty() {
        if smilePoints > 0 {
            if smilePoints > 100 {
                smilePoints = 100
            }
        }
    }
    
    private func buySuccess() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Поздравляем с покупкой! Вы получите дополнительные очки радости!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Спасибо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You bought new realty! Our congratulations!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Thanks", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
