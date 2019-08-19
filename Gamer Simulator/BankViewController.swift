//
//  BankViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class BankViewController: UIViewController, GADInterstitialDelegate {
    
    var delegate : BankDelegate?
    var rubBank : Int! = 0
    var dollarBank : Int! = 0
    var costDollar : Int?
    var costRub : Int?
    var dollarInt : Int?
    var rubInt : Int?
    var allRub : Int?
    var allDollar : Int?
    var forDollar : String?
    var forRub : String?
    var rubCheck : Int?
    var eatPointsBank : Int! = 0
    var smilePointsBank : Int! = 0
    var sleepPointsBank : Int! = 0
    var lastChanceBank : Int! = -1
    var checkLoseGameBank : Int! = 0
    
    var adChance : Int! = 0
    var interstitial: GADInterstitial!
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var eatPointsLabelBank: UILabel!
    @IBOutlet weak var smilePointsLabelBank: UILabel!
    @IBOutlet weak var sleepPointsLabelBank: UILabel!
    @IBOutlet weak var rubCostLabel: UILabel!
    @IBOutlet weak var dollarCostLabel: UILabel!
    @IBAction func sleepPointsButtonActionBank(_ sender: Any) {
        sleepPointsBank = sleepPointsBank + 57
        smilePointsBank = smilePointsBank + 3
        eatPointsBank = eatPointsBank - 23
        if lastChanceBank > 0 {
            lastChanceBank = lastChanceBank - 1
        }
        lifeSetupBank()
    }
    @IBOutlet weak var dollarTextField: UITextField!
    @IBAction func dollarTextFieldAction(_ sender: Any) {
        dollarInt = Int(dollarTextField.text ?? "0")
        if locale.hasPrefix("ru") {
            if dollarInt != nil {
                costDollar = dollarInt! * 65 / 65 * 65
                forRub = String(costDollar!)
                rubCostLabel.text = "\(forRub ?? "0") руб."
            } else {
                rubCostLabel.text = "0 руб."
            }
        } else {
            if dollarInt != nil {
                costDollar = dollarInt! * 65 / 65 * 65
                forRub = String(costDollar!)
                rubCostLabel.text = "\(forRub ?? "0") rub"
            } else {
                rubCostLabel.text = "0 rub"
            }
        }
        
    }
    @IBOutlet weak var rubTextField: UITextField!
    @IBAction func rubTextFieldAction(_ sender: Any) {
        rubInt = Int(rubTextField.text ?? "0")
        rubCheck = rubInt! % 65
        if rubInt != nil {
            costRub = rubInt! / 65 * 65 / 65
            forDollar = String(costRub!)
            dollarCostLabel.text = "\(forDollar ?? "0") $"
        } else {
            dollarCostLabel.text = "0 $"
        }
    }
    @IBAction func changeRubToDollarsButtonAction(_ sender: Any) {
        if costDollar! <= allRub! {
            if costDollar! != 0 {
                delegate?.bankAction(rubBank: -costDollar!, dollarBank: dollarInt!)
                allRub = allRub! - costDollar!
                allDollar = allDollar! + dollarInt!
                dollarTextField.text = ""
                if locale.hasPrefix("ru") {
                    rubCostLabel.text = "0 руб."
                } else {
                    rubCostLabel.text = "0 rub"
                }
                changeSuccess()
            } else {
                changeD()
            }
        } else {
            checkRub()
        }
    }
    @IBAction func changeDollarsToRubButtonAction(_ sender: Any) {
        if costRub! <= allDollar! {
            if costRub! != 0 {
                if rubCheck! == 0 {
                    delegate?.bankAction(rubBank: rubInt!, dollarBank: -costRub!)
                    allRub = allRub! + rubInt!
                    allDollar = allDollar! - costRub!
                    rubTextField.text = ""
                    dollarCostLabel.text = "0 $"
                    changeSuccess()
                } else {
                    changeDenied()
                }
            } else {
                changeD()
            }
        } else {
            checkDollar()
        }
    }
    @IBAction func profileButtonActionBank(_ sender: Any) {
        delegate?.lifeActionBank(eat: eatPointsBank, smile: smilePointsBank, sleep: sleepPointsBank)
        delegate?.loseGameBank(lose: checkLoseGameBank, chance: lastChanceBank)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5876707192699554/7654571422")
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eatPointsLabelBank.text = String(eatPointsBank)
        smilePointsLabelBank.text = String(smilePointsBank)
        sleepPointsLabelBank.text = String(sleepPointsBank)
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    
    private func doneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClick))
        
        toolBar.setItems([doneButton], animated: true)
        
        dollarTextField.inputAccessoryView = toolBar
        rubTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        view.endEditing(true)
    }
    private func checkRub() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(costDollar!-allRub!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Копить дальше", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(costDollar!-allRub!) rub!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey...", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func checkDollar() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(costRub! - allDollar!)$!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Копить дальше", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must to get \(costRub! - allDollar!)$!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey...", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func changeSuccess() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Уведомление", message: "Обмен произведен успешно!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notification", message: "Success!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    private func changeDenied() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Уведомление", message: "Обмен не может быть произведен. Измените запрос, чтобы он был кратен 65!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notification", message: "Chenge denied. The number must be a multiple of 65!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Okey...", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    private func changeD() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Уведомление", message: "Обмен не может быть воспроизведен! Нельзя обменять 0 на 0!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Понятно", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notification", message: "You can't change 0 for 0!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"I know", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    private func lifeSetupBank() {
        if sleepPointsBank > 100 {
            sleepPointsBank = 100
        } else {
            if sleepPointsBank <= 0 {
                sleepPointsBank = 0
                if lastChanceBank < 0 {
                    lastChanceBank = 3
                }
            }
        }
        if smilePointsBank > 100 {
            smilePointsBank = 100
        } else {
            if smilePointsBank <= 0 {
                smilePointsBank = 0
                if lastChanceBank < 0 {
                    lastChanceBank = 3
                }
            }
        }
        if eatPointsBank > 100 {
            eatPointsBank = 100
        } else {
            if eatPointsBank <= 0 {
                eatPointsBank = 0
                if lastChanceBank < 0 {
                    lastChanceBank = 3
                }
            }
        }
        eatPointsLabelBank.text = String(eatPointsBank)
        smilePointsLabelBank.text = String(smilePointsBank)
        sleepPointsLabelBank.text = String(sleepPointsBank)
        loseGameBank()
    }
    private func loseGameBank() {
        if locale.hasPrefix("ru") {
            if lastChanceBank == 0 {
                let alert = UIAlertController(title: "Внимание!!!", message: "Вы проиграли!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Начать заново", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameBank = 1
                    self.delegate?.loseGameBank(lose: self.checkLoseGameBank, chance: self.lastChanceBank)
                    self.delegate?.lifeActionBank(eat: self.eatPointsBank, smile: self.smilePointsBank, sleep: self.sleepPointsBank)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceBank == 3 {
                    let alert = UIAlertController(title: "Внимание!!!", message: "У вас есть \(lastChanceBank!) шага для того чтобы исправить ситуацию или вы проиграете! Потратьте их с пользой!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я справлюсь!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            if lastChanceBank == 0 {
                let alert = UIAlertController(title: "Attention!!!", message: "You lost!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Start new game", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameBank = 1
                    self.delegate?.loseGameBank(lose: self.checkLoseGameBank, chance: self.lastChanceBank)
                    self.delegate?.lifeActionBank(eat: self.eatPointsBank, smile: self.smilePointsBank, sleep: self.sleepPointsBank)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceBank == 3 {
                    let alert = UIAlertController(title: "Attention!!!", message: "You have \(lastChanceBank!) steps before you lose the game!", preferredStyle: UIAlertController.Style.alert)
                    
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
