//
//  ShopTransportViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit

class ShopTransportViewController: UIViewController {
    
    var delegate : TransportShopDelegate?
    var rubTransport : Int! = 0
    var dollarTransport : Int! = 0
    var buyedTransport : String! = ""
    var buyed : String! = "Пройдено"
    var buyedEn : String! = "Not for me"
    var checkBuyedTransport : Int! = 0
    var smilePoints : Int! = 0
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var buyBucycleButton: UIButton!
    @IBOutlet weak var buyBicycleLabel: UILabel!
    @IBOutlet weak var buyElectricScooterButton: UIButton!
    @IBOutlet weak var buyElectricScooterLabel: UILabel!
    @IBOutlet weak var buyScooterButton: UIButton!
    @IBOutlet weak var buyScooterLabel: UILabel!
    @IBOutlet weak var buyReOwnedCarButton: UIButton!
    @IBOutlet weak var buyReOwnedCarLabel: UILabel!
    @IBOutlet weak var buyCarButton: UIButton!
    @IBOutlet weak var buyCarLabel: UILabel!
    @IBOutlet weak var buyPremiumAutoButton: UIButton!
    @IBOutlet weak var buyPremiumAutoLabel: UILabel!
    @IBOutlet weak var buyHelicopterButton: UIButton!
    @IBOutlet weak var buyHelicopterLabel: UILabel!
    @IBAction func buyBicycleAction(_ sender: Any) {
        if rubTransport >= 9990 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Велосипед", allTransport: 1)
            } else {
                delegate?.transportAction(buyedTransport: "Bycicle", allTransport: 1)
            }
            rubTransport = rubTransport - 9990
            checkBuyedTransport = 1
            smilePoints = smilePoints + 15
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noMoneyT(money: 9990)
        }
    }
    
    @IBAction func buyElectricScooterAction(_ sender: Any) {
        if rubTransport >= 25990 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Электросамокат", allTransport: 2)
            } else {
                delegate?.transportAction(buyedTransport: "Electric scooter", allTransport: 2)
            }
            rubTransport = rubTransport - 25990
            checkBuyedTransport = 2
            smilePoints = smilePoints + 45
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noMoneyT(money: 25990)
        }
    }
    
    @IBAction func buyScooterAction(_ sender: Any) {
        if rubTransport >= 55000 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Скутер", allTransport: 3)
            } else {
                delegate?.transportAction(buyedTransport: "Scooter", allTransport: 3)
            }
            
            rubTransport = rubTransport - 55000
            checkBuyedTransport = 3
            smilePoints = smilePoints + 35
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noMoneyT(money: 55000)
        }
    }
    
    @IBAction func buyReOwnedCarAction(_ sender: Any) {
        if rubTransport >= 150000 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Б/у машина", allTransport: 4)
            } else {
                delegate?.transportAction(buyedTransport: "Re-owned car", allTransport: 4)
            }
            
            rubTransport = rubTransport - 150000
            checkBuyedTransport = 4
            smilePoints = smilePoints + 55
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noMoneyT(money: 150000)
        }
    }
    
    @IBAction func buyCarAction(_ sender: Any) {
        if rubTransport >= 650000 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Машина", allTransport: 5)
            } else {
                delegate?.transportAction(buyedTransport: "Car", allTransport: 5)
            }
            
            rubTransport = rubTransport - 650000
            checkBuyedTransport = 5
            smilePoints = smilePoints + 75
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noMoneyT(money: 650000)
        }
    }
    
    @IBAction func buyPremiumCarAction(_ sender: Any) {
        if dollarTransport >= 100000 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Премиум авто", allTransport: 6)
            } else {
                delegate?.transportAction(buyedTransport: "Premium car", allTransport: 6)
            }
            dollarTransport = dollarTransport - 100000
            checkBuyedTransport = 6
            smilePoints = smilePoints + 85
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noDollarT(dollar: 100000)
        }
    }
    
    @IBAction func buyHelicopterAction(_ sender: Any) {
        if dollarTransport >= 500000 {
            if locale.hasPrefix("ru") {
                delegate?.transportAction(buyedTransport: "Вертолет", allTransport: 7)
            } else {
                delegate?.transportAction(buyedTransport: "Helicopter", allTransport: 7)
            }
            
            dollarTransport = dollarTransport - 500000
            checkBuyedTransport = 7
            smilePoints = smilePoints + 100
            lifeSetupTransport()
            checkBuyedTranport(transport: checkBuyedTransport)
            buySuccess()
        } else {
            noDollarT(dollar: 500000)
        }
    }
    
    @IBAction func backToShopTransportAction(_ sender: Any) {
        dismiss(animated: true)
        delegate?.moneyTransport(rubTransport: rubTransport, dollarTransport: dollarTransport)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBuyedTranport(transport: checkBuyedTransport)
    }
    
    private func noMoneyT(money: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(money - rubTransport!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(money - rubTransport!) rub!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noDollarT(dollar: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(dollar - dollarTransport!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(dollar - dollarTransport!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkBuyedTranport(transport: Int) {
        if locale.hasPrefix("ru") {
            if transport == 1 {
                buyBucycleButton.isUserInteractionEnabled = false
                buyBicycleLabel.text = "Куплено"
                buyElectricScooterButton.isUserInteractionEnabled = true
                buyElectricScooterLabel.text = "25990 руб."
                buyScooterButton.isUserInteractionEnabled = true
                buyScooterLabel.text = "55000 руб."
                buyReOwnedCarButton.isUserInteractionEnabled = true
                buyReOwnedCarLabel.text = "150000 руб."
                buyCarButton.isUserInteractionEnabled = true
                buyCarLabel.text = "650000 руб."
                buyPremiumAutoButton.isUserInteractionEnabled = true
                buyPremiumAutoLabel.text = "100000 $"
                buyHelicopterButton.isUserInteractionEnabled = true
                buyHelicopterLabel.text = "500000 $"
            } else {
                if transport == 2 {
                    buyBucycleButton.isUserInteractionEnabled = false
                    buyBicycleLabel.text = buyed
                    buyElectricScooterButton.isUserInteractionEnabled = false
                    buyElectricScooterLabel.text = "Куплено"
                    buyScooterButton.isUserInteractionEnabled = true
                    buyScooterLabel.text = "55000 руб."
                    buyReOwnedCarButton.isUserInteractionEnabled = true
                    buyReOwnedCarLabel.text = "150000 руб."
                    buyCarButton.isUserInteractionEnabled = true
                    buyCarLabel.text = "650000 руб."
                    buyPremiumAutoButton.isUserInteractionEnabled = true
                    buyPremiumAutoLabel.text = "100000 $"
                    buyHelicopterButton.isUserInteractionEnabled = true
                    buyHelicopterLabel.text = "500000 $"
                } else {
                    if transport == 3 {
                        buyBucycleButton.isUserInteractionEnabled = false
                        buyBicycleLabel.text = buyed
                        buyElectricScooterButton.isUserInteractionEnabled = false
                        buyElectricScooterLabel.text = buyed
                        buyScooterButton.isUserInteractionEnabled = false
                        buyScooterLabel.text = "Куплено"
                        buyReOwnedCarButton.isUserInteractionEnabled = true
                        buyReOwnedCarLabel.text = "150000 руб."
                        buyCarButton.isUserInteractionEnabled = true
                        buyCarLabel.text = "650000 руб."
                        buyPremiumAutoButton.isUserInteractionEnabled = true
                        buyPremiumAutoLabel.text = "100000 $"
                        buyHelicopterButton.isUserInteractionEnabled = true
                        buyHelicopterLabel.text = "500000 $"
                    } else {
                        if transport == 4 {
                            buyBucycleButton.isUserInteractionEnabled = false
                            buyBicycleLabel.text = buyed
                            buyElectricScooterButton.isUserInteractionEnabled = false
                            buyElectricScooterLabel.text = buyed
                            buyScooterButton.isUserInteractionEnabled = false
                            buyScooterLabel.text = buyed
                            buyReOwnedCarButton.isUserInteractionEnabled = false
                            buyReOwnedCarLabel.text = "Куплено"
                            buyCarButton.isUserInteractionEnabled = true
                            buyCarLabel.text = "650000 руб."
                            buyPremiumAutoButton.isUserInteractionEnabled = true
                            buyPremiumAutoLabel.text = "100000 $"
                            buyHelicopterButton.isUserInteractionEnabled = true
                            buyHelicopterLabel.text = "500000 $"
                        } else {
                            if transport == 5 {
                                buyBucycleButton.isUserInteractionEnabled = false
                                buyBicycleLabel.text = buyed
                                buyElectricScooterButton.isUserInteractionEnabled = false
                                buyElectricScooterLabel.text = buyed
                                buyScooterButton.isUserInteractionEnabled = false
                                buyScooterLabel.text = buyed
                                buyReOwnedCarButton.isUserInteractionEnabled = false
                                buyReOwnedCarLabel.text = buyed
                                buyCarButton.isUserInteractionEnabled = false
                                buyCarLabel.text = "Куплено"
                                buyPremiumAutoButton.isUserInteractionEnabled = true
                                buyPremiumAutoLabel.text = "100000 $"
                                buyHelicopterButton.isUserInteractionEnabled = true
                                buyHelicopterLabel.text = "500000 $"
                            } else {
                                if transport == 6 {
                                    buyBucycleButton.isUserInteractionEnabled = false
                                    buyBicycleLabel.text = buyed
                                    buyElectricScooterButton.isUserInteractionEnabled = false
                                    buyElectricScooterLabel.text = buyed
                                    buyScooterButton.isUserInteractionEnabled = false
                                    buyScooterLabel.text = buyed
                                    buyReOwnedCarButton.isUserInteractionEnabled = false
                                    buyReOwnedCarLabel.text = buyed
                                    buyCarButton.isUserInteractionEnabled = false
                                    buyCarLabel.text = buyed
                                    buyPremiumAutoButton.isUserInteractionEnabled = false
                                    buyPremiumAutoLabel.text = "Куплено"
                                    buyHelicopterButton.isUserInteractionEnabled = true
                                    buyHelicopterLabel.text = "500000 $"
                                } else {
                                    if transport == 7 {
                                        buyBucycleButton.isUserInteractionEnabled = false
                                        buyBicycleLabel.text = buyed
                                        buyElectricScooterButton.isUserInteractionEnabled = false
                                        buyElectricScooterLabel.text = buyed
                                        buyScooterButton.isUserInteractionEnabled = false
                                        buyScooterLabel.text = buyed
                                        buyReOwnedCarButton.isUserInteractionEnabled = false
                                        buyReOwnedCarLabel.text = buyed
                                        buyCarButton.isUserInteractionEnabled = false
                                        buyCarLabel.text = buyed
                                        buyPremiumAutoButton.isUserInteractionEnabled = false
                                        buyPremiumAutoLabel.text = buyed
                                        buyHelicopterButton.isUserInteractionEnabled = false
                                        buyHelicopterLabel.text = "Куплено"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if transport == 1 {
                buyBucycleButton.isUserInteractionEnabled = false
                buyBicycleLabel.text = "Bought"
                buyElectricScooterButton.isUserInteractionEnabled = true
                buyElectricScooterLabel.text = "25990 rub"
                buyScooterButton.isUserInteractionEnabled = true
                buyScooterLabel.text = "55000 rub"
                buyReOwnedCarButton.isUserInteractionEnabled = true
                buyReOwnedCarLabel.text = "150000 rub"
                buyCarButton.isUserInteractionEnabled = true
                buyCarLabel.text = "650000 rub"
                buyPremiumAutoButton.isUserInteractionEnabled = true
                buyPremiumAutoLabel.text = "100000 $"
                buyHelicopterButton.isUserInteractionEnabled = true
                buyHelicopterLabel.text = "500000 $"
            } else {
                if transport == 2 {
                    buyBucycleButton.isUserInteractionEnabled = false
                    buyBicycleLabel.text = buyedEn
                    buyElectricScooterButton.isUserInteractionEnabled = false
                    buyElectricScooterLabel.text = "Bought"
                    buyScooterButton.isUserInteractionEnabled = true
                    buyScooterLabel.text = "55000 rub"
                    buyReOwnedCarButton.isUserInteractionEnabled = true
                    buyReOwnedCarLabel.text = "150000 rub"
                    buyCarButton.isUserInteractionEnabled = true
                    buyCarLabel.text = "650000 rub"
                    buyPremiumAutoButton.isUserInteractionEnabled = true
                    buyPremiumAutoLabel.text = "100000 $"
                    buyHelicopterButton.isUserInteractionEnabled = true
                    buyHelicopterLabel.text = "500000 $"
                } else {
                    if transport == 3 {
                        buyBucycleButton.isUserInteractionEnabled = false
                        buyBicycleLabel.text = buyedEn
                        buyElectricScooterButton.isUserInteractionEnabled = false
                        buyElectricScooterLabel.text = buyedEn
                        buyScooterButton.isUserInteractionEnabled = false
                        buyScooterLabel.text = "Bought"
                        buyReOwnedCarButton.isUserInteractionEnabled = true
                        buyReOwnedCarLabel.text = "150000 rub"
                        buyCarButton.isUserInteractionEnabled = true
                        buyCarLabel.text = "650000 rub"
                        buyPremiumAutoButton.isUserInteractionEnabled = true
                        buyPremiumAutoLabel.text = "100000 $"
                        buyHelicopterButton.isUserInteractionEnabled = true
                        buyHelicopterLabel.text = "500000 $"
                    } else {
                        if transport == 4 {
                            buyBucycleButton.isUserInteractionEnabled = false
                            buyBicycleLabel.text = buyedEn
                            buyElectricScooterButton.isUserInteractionEnabled = false
                            buyElectricScooterLabel.text = buyedEn
                            buyScooterButton.isUserInteractionEnabled = false
                            buyScooterLabel.text = buyedEn
                            buyReOwnedCarButton.isUserInteractionEnabled = false
                            buyReOwnedCarLabel.text = "Bought"
                            buyCarButton.isUserInteractionEnabled = true
                            buyCarLabel.text = "650000 rub"
                            buyPremiumAutoButton.isUserInteractionEnabled = true
                            buyPremiumAutoLabel.text = "100000 $"
                            buyHelicopterButton.isUserInteractionEnabled = true
                            buyHelicopterLabel.text = "500000 $"
                        } else {
                            if transport == 5 {
                                buyBucycleButton.isUserInteractionEnabled = false
                                buyBicycleLabel.text = buyedEn
                                buyElectricScooterButton.isUserInteractionEnabled = false
                                buyElectricScooterLabel.text = buyedEn
                                buyScooterButton.isUserInteractionEnabled = false
                                buyScooterLabel.text = buyedEn
                                buyReOwnedCarButton.isUserInteractionEnabled = false
                                buyReOwnedCarLabel.text = buyedEn
                                buyCarButton.isUserInteractionEnabled = false
                                buyCarLabel.text = "Bought"
                                buyPremiumAutoButton.isUserInteractionEnabled = true
                                buyPremiumAutoLabel.text = "100000 $"
                                buyHelicopterButton.isUserInteractionEnabled = true
                                buyHelicopterLabel.text = "500000 $"
                            } else {
                                if transport == 6 {
                                    buyBucycleButton.isUserInteractionEnabled = false
                                    buyBicycleLabel.text = buyedEn
                                    buyElectricScooterButton.isUserInteractionEnabled = false
                                    buyElectricScooterLabel.text = buyedEn
                                    buyScooterButton.isUserInteractionEnabled = false
                                    buyScooterLabel.text = buyedEn
                                    buyReOwnedCarButton.isUserInteractionEnabled = false
                                    buyReOwnedCarLabel.text = buyedEn
                                    buyCarButton.isUserInteractionEnabled = false
                                    buyCarLabel.text = buyedEn
                                    buyPremiumAutoButton.isUserInteractionEnabled = false
                                    buyPremiumAutoLabel.text = "Bought"
                                    buyHelicopterButton.isUserInteractionEnabled = true
                                    buyHelicopterLabel.text = "500000 $"
                                } else {
                                    if transport == 7 {
                                        buyBucycleButton.isUserInteractionEnabled = false
                                        buyBicycleLabel.text = buyedEn
                                        buyElectricScooterButton.isUserInteractionEnabled = false
                                        buyElectricScooterLabel.text = buyedEn
                                        buyScooterButton.isUserInteractionEnabled = false
                                        buyScooterLabel.text = buyedEn
                                        buyReOwnedCarButton.isUserInteractionEnabled = false
                                        buyReOwnedCarLabel.text = buyedEn
                                        buyCarButton.isUserInteractionEnabled = false
                                        buyCarLabel.text = buyedEn
                                        buyPremiumAutoButton.isUserInteractionEnabled = false
                                        buyPremiumAutoLabel.text = buyedEn
                                        buyHelicopterButton.isUserInteractionEnabled = false
                                        buyHelicopterLabel.text = "Bought"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    private func lifeSetupTransport() {
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
            let alert = UIAlertController(title: "Attention", message: "You bought new transport! Our congratulations!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Thanks", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
