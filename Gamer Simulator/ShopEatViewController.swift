//
//  ShopEatViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit

class ShopEatViewController: UIViewController {
    
    var delegate : EatShopDelegate?
    var rubEat : Int! = 0
    var dollarEat : Int! = 0
    var checkCooker : Int! = 0
    var checkEat3000 : Int! = 0
    var eatPoints : Int! = 0
    var smilePoints : Int! = 0
    var lastChance : Int! = 0
    
    let locale = NSLocale.preferredLanguages.first!

    @IBOutlet weak var orderCookerButton: UIButton!
    @IBOutlet weak var orderCookerLabel: UILabel!
    @IBOutlet weak var buyEat3000Button: UIButton!
    @IBOutlet weak var buyEat3000Label: UILabel!
    
    @IBAction func buySendwichAction(_ sender: Any) {
        if rubEat >= 75 {
            rubEat = rubEat - 75
            eatPoints = eatPoints + 15
            smilePoints = smilePoints + 2
            lifeSetupEat()
        } else {
            noMoneyEat(money: 75)
        }
    }
    
    @IBAction func railwayEatAction(_ sender: Any) {
        if rubEat >= 120 {
            rubEat = rubEat - 120
            eatPoints = eatPoints + 21
            smilePoints = smilePoints + 15
            lifeSetupEat()
        } else {
            noMoneyEat(money: 120)
        }
    }
    
    @IBAction func goToPelmennayaAction(_ sender: Any) {
        if rubEat >= 237 {
            rubEat = rubEat - 237
            eatPoints = eatPoints + 27
            smilePoints = smilePoints + 23
            lifeSetupEat()
        } else {
            noMoneyEat(money: 237)
        }
    }
    
    @IBAction func goToCafeAction(_ sender: Any) {
        if rubEat >= 536 {
            rubEat = rubEat - 536
            eatPoints = eatPoints + 34
            smilePoints = smilePoints + 25
            lifeSetupEat()
        } else {
            noMoneyEat(money: 536)
        }
    }
    
    @IBAction func visitRestaurantAction(_ sender: Any) {
        if rubEat >= 1893 {
            rubEat = rubEat - 1893
            eatPoints = eatPoints + 50
            smilePoints = smilePoints + 35
            lifeSetupEat()
        } else {
            noMoneyEat(money: 1893)
        }
    }
    
    @IBAction func orderCookerAction(_ sender: Any) {
        if dollarEat >= 25000 {
            dollarEat = dollarEat - 25000
            checkCooker = 1
            checkBuyedEat()
        } else {
            noDollarEat(dollar: 25000)
        }
    }
    
    @IBAction func buyEat3000Action(_ sender: Any) {
        if dollarEat >= 100000 {
            dollarEat = dollarEat - 100000
            checkEat3000 = 1
            checkBuyedEat()
        } else {
            noDollarEat(dollar: 100000)
        }
    }
    
    @IBAction func backToShopButtonAction(_ sender: Any) {
        dismiss(animated: true)
        delegate?.eatAction(rubEat: rubEat, dollarEat: dollarEat, checkCooker: checkCooker, checkEat3000: checkEat3000)
        delegate?.lifeActionEatShop(eat: eatPoints, smile: smilePoints, lastChance: lastChance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBuyedEat()
        lifeSetupEat()
    }
    
    private func noMoneyEat(money: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(money - rubEat!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Но я хотел покушать!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(money - rubEat!) rub!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"But I'm hungry!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func noDollarEat(dollar: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(dollar - dollarEat!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(dollar - dollarEat!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
        }
    }
    
    private func checkBuyedEat() {
        if checkCooker == 1 {
            orderCookerButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                orderCookerLabel.text = "Куплено"
            } else {
                orderCookerLabel.text = "Bought"
            }
        }
        if checkEat3000 == 1 {
            buyEat3000Button.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyEat3000Label.text = "Куплено"
            } else {
                buyEat3000Label.text = "Bought"
            }
        }
    }
    
    private func lifeSetupEat() {
        if smilePoints > 0 {
            if smilePoints > 100 {
                smilePoints = 100
            }
        }
        
        if eatPoints > 0 {
            if eatPoints > 100 {
                eatPoints = 100
                maxEat()
            }
            lastChance = -1
        }
    }
    
    private func maxEat() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "У вас максимум очков еды!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Замечательно", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "УYou have maximum eat points!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Perfect", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
