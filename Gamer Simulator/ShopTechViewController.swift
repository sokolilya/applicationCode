//
//  ShopTechViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit

class ShopTechViewController: UIViewController {
    
    var delegate : TechShopDelegate?
    var rubTech : Int! = 0
    var dollarTech : Int! = 0
    var buyed : String! = "Куплено"
    var buyedEn : String! = "Bought"
    var notebook : Int! = 0
    var i3PC : Int! = 0
    var console : Int! = 0
    var i5PC : Int! = 0
    var i7PC : Int! = 0
    var monitor : Int! = 0
    var i9PC : Int! = 0
    var allTech : Int! = 0
    var smilePoints : Int! = 0
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var buyCheapNotebookButton: UIButton!
    @IBOutlet weak var buyCheapNotebookLabel: UILabel!
    @IBOutlet weak var buyI3PCButton: UIButton!
    @IBOutlet weak var buyI3PCLabel: UILabel!
    @IBOutlet weak var buyConsoleButton: UIButton!
    @IBOutlet weak var buyConsoleLabel: UILabel!
    @IBOutlet weak var buyI5PCButton: UIButton!
    @IBOutlet weak var buyI5PCLabel: UILabel!
    @IBOutlet weak var buyI7PCButton: UIButton!
    @IBOutlet weak var buyI7PCLabel: UILabel!
    @IBOutlet weak var buy4KMonitorButton: UIButton!
    @IBOutlet weak var buy4KMonitorLabel: UILabel!
    @IBOutlet weak var buyI9PCButton: UIButton!
    @IBOutlet weak var buyI9PCLabel: UILabel!
    @IBAction func buyCheapNotebookAction(_ sender: Any) {
        if rubTech >= 17990 {
            rubTech = rubTech - 17990
            notebook = 1
            if allTech < 1 {
                allTech = 1
            }
            smilePoints = smilePoints + 10
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noMoneyTech(money: 17990)
        }
    }
    
    @IBAction func buyI3PCAction(_ sender: Any) {
        if rubTech >= 24990 {
            rubTech = rubTech - 24990
            i3PC = 1
            if allTech < 2 {
                allTech = 2
            }
            smilePoints = smilePoints + 25
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noMoneyTech(money: 24990)
        }
    }
    
    @IBAction func buyConsoleAction(_ sender: Any) {
        if rubTech >= 33990 {
            rubTech = rubTech - 33990
            console = 1
            if allTech < 2 {
                allTech = 2
            }
            smilePoints = smilePoints + 25
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noMoneyTech(money: 33990)
        }
    }
    
    @IBAction func buyI5PCAction(_ sender: Any) {
        if rubTech >= 96990 {
            rubTech = rubTech - 96990
            i5PC = 1
            if allTech < 3 {
                allTech = 3
            }
            smilePoints = smilePoints + 35
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noMoneyTech(money: 96990)
        }
    }
    
    @IBAction func buyI7PCAction(_ sender: Any) {
        if rubTech >= 192990 {
            rubTech = rubTech - 192990
            i7PC = 1
            if allTech < 4 {
                allTech = 4
            }
            smilePoints = smilePoints + 55
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noMoneyTech(money: 192990)
        }
    }
    
    @IBAction func buy4KScreenAction(_ sender: Any) {
        if i7PC == 1 {
            if rubTech >= 54990 {
                rubTech = rubTech - 54990
                monitor = 1
                smilePoints = smilePoints + 45
                lifeSetupTech()
                checkBuyedTech()
            } else {
                noMoneyTech(money: 54990)
            }
        } else {
            noI7PC()
        }
    }
    
    @IBAction func buyI9PCAction(_ sender: Any) {
        if dollarTech >= 15000 {
            dollarTech = dollarTech - 15000
            i9PC = 1
            if allTech < 5 {
                allTech = 5
            }
            smilePoints = smilePoints + 90
            lifeSetupTech()
            checkBuyedTech()
        } else {
            noDollarTech(dollar: 15000)
        }
    }
    
    @IBAction func backToShopTechAction(_ sender: Any) {
        dismiss(animated: true)
        delegate?.techAction(rubTech: rubTech, dollarTech: dollarTech)
        delegate?.checkTech(notebook: notebook, i3PC: i3PC, console: console, i5PC: i5PC, i7PC: i7PC, monitor: monitor, i9PC: i9PC, check: allTech)
        delegate?.lifeActionTechShop(smile: smilePoints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBuyedTech()
    }
    
    private func noMoneyTech(money: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(money - rubTech!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(money - rubTech!) rub!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func noDollarTech(dollar: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(dollar - dollarTech!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(dollar - dollarTech!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func checkBuyedTech() {
        if notebook == 1 {
            buyCheapNotebookButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyCheapNotebookLabel.text = buyed
            } else {
                buyCheapNotebookLabel.text = buyedEn
            }
            
        }
        if i3PC == 1 {
            buyI3PCButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyI3PCLabel.text = buyed
            } else {
                buyI3PCLabel.text = buyedEn
            }
            
        }
        if console == 1 {
            buyConsoleButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyConsoleLabel.text = buyed
            } else {
                buyConsoleLabel.text = buyedEn
            }
            
        }
        if i5PC == 1 {
            buyI5PCButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyI5PCLabel.text = buyed
            } else {
                buyI5PCLabel.text = buyedEn
            }
            
        }
        if i9PC == 1 {
            buyI9PCButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyI9PCLabel.text = buyed
            } else {
                buyI9PCLabel.text = buyedEn
            }
            
        }
        if i7PC == 1 {
            buyI7PCButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buyI7PCLabel.text = buyed
            } else {
                buyI7PCLabel.text = buyedEn
            }
            
        }
        if monitor == 1 {
            buy4KMonitorButton.isUserInteractionEnabled = false
            if locale.hasPrefix("ru") {
                buy4KMonitorLabel.text = buyed
            } else {
                buy4KMonitorLabel.text = buyedEn
            }
            
        }
    }
    
    private func noI7PC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Для покупки 4К монитора вам необходимо приобрести ПК на i7!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Все понял", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "For buying 4К monitor you must to get PC on i7!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Go for shopping", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func lifeSetupTech() {
        if smilePoints > 0 {
            if smilePoints > 100 {
                smilePoints = 100
            }
        }
    }
    
}
