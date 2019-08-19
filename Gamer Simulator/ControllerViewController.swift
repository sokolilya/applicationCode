//
//  ControllerViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class ControllerViewController: UIViewController, GADInterstitialDelegate {
    
    var delegate : ControllerDelegate?
    var allRub : Int?
    var allDollar : Int?
    var allMaster : Int?
    var allPopularity : Int?
    var plays : Int! = 0
    var games : Int! = 0
    var buyedGames : Int! = 0
    var letsPlays : Int! = 0
    var allowedCards : Int! = 0
    var visitedEvents : Int! = 0
    var salaryView : Int! = 0
    var salaryLetsPlay : Int! = 0
    var salaryStreamRub : Int! = 0
    var salaryStreamDollar : Int! = 0
    var salaryEvent : Int! = 0
    var chance : Int! = 0
    var professionController : String! = ""
    var checkRoomRentC : Int! = 0
    var checkFlatRentC : Int! = 0
    var checkRealtyC : Int! = 0
    var allTech : Int! = 0
    var eatPointsC : Int! = 0
    var smilePointsC : Int! = 0
    var sleepPointsC : Int! = 0
    var lastChanceC : Int! = -1
    var checkLoseGameC : Int! = 0
    var realty : Int! = 0
    var transport : Int! = 0
    var cookerC : Int! = 0
    var eat3000C : Int! = 0
    
    var adChance : Int! = 0
    var interstitial: GADInterstitial!
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var eatPointsLabelController: UILabel!
    @IBOutlet weak var smilePointsLabelController: UILabel!
    @IBOutlet weak var sleepPointsLabelController: UILabel!
    @IBAction func sleepPointsButtonActionController(_ sender: Any) {
        sleepPointsC = sleepPointsC + 57
        smilePointsC = smilePointsC + 3
        eatPointsC = eatPointsC - 23
        if lastChanceC > 0 {
            lastChanceC = lastChanceC - 1
        }
        lifeSetupC()
    }
    @IBAction func buyGameButtonAction(_ sender: Any) {
        if allRub! >= 1500 {
            delegate?.controllerAction(rubC: -1500, dollarC: 0, masterPointsC: 0, popularityPointsC: 0)
            allRub = allRub! - 1500
            plays = plays + 15
            games = games + 1
            letsPlays = letsPlays + 10
            buyedGames = buyedGames + 1
            allowedCards = allowedCards + 5
            smilePointsC = smilePointsC + 16
            lifeSetupC()
        } else {
            noMoney(money: 1500)
        }
    }
    @IBAction func buyCollectorsCardButtonAction(_ sender: Any) {
        if allowedCards > 0 {
            if allRub! >= 500 {
                delegate?.controllerAction(rubC: -500, dollarC: 0, masterPointsC: 0, popularityPointsC: 25)
                allRub = allRub! - 500
                allPopularity = allPopularity! + 25
                allowedCards = allowedCards - 1
                smilePointsC = smilePointsC + 7
                lifeSetupC()
            } else {
                noMoney(money: 500)
            }
        } else {
            noCards()
        }
    }
    @IBAction func playGameButtonAction(_ sender: Any) {
        if allTech >= 1 {
            if plays > 0 {
                delegate?.controllerAction(rubC: 0, dollarC: 0, masterPointsC: 25, popularityPointsC: 0)
                allMaster = allMaster! + 25
                plays = plays - 1
                checkRentC()
                if realty == 1 {
                    sleepPointsC = sleepPointsC - 7
                } else {
                    if realty == 2 {
                        sleepPointsC = sleepPointsC - 5
                    } else {
                        if realty == 3 {
                            sleepPointsC = sleepPointsC - 4
                        } else {
                            if realty == 4 {
                                sleepPointsC = sleepPointsC - 3
                            } else {
                                if realty == 5 {
                                    sleepPointsC = sleepPointsC - 2
                                } else {
                                    if realty == 6 {
                                        sleepPointsC = sleepPointsC - 1
                                    } else {
                                        sleepPointsC = sleepPointsC - 9
                                    }
                                }
                            }
                        }
                    }
                }
                if eat3000C == 1 {
                    eatPointsC = eatPointsC - 1
                } else {
                    if cookerC == 1 {
                        eatPointsC = eatPointsC - 5
                    } else {
                        eatPointsC = eatPointsC - 10
                    }
                }
                smilePointsC = smilePointsC + 8
                if lastChanceC > 0 {
                    lastChanceC = lastChanceC - 1
                }
                lifeSetupC()
            } else {
                noPlays()
            }
        } else {
            noNotebook()
        }
    }
    @IBAction func viewGameButtonAction(_ sender: Any) {
        if allTech >= 2 {
            if allPopularity! >= 250 {
                if games > 0{
                    salaryView = 1000 + (allPopularity! / 25)
                    delegate?.controllerAction(rubC: salaryView, dollarC: 0, masterPointsC: 75, popularityPointsC: 100)
                    allRub = allRub! + salaryView
                    allMaster = allMaster! + 75
                    allPopularity = allPopularity! + 100
                    games = games - 1
                    checkRentC()
                    if realty == 1 {
                        sleepPointsC = sleepPointsC - 21
                    } else {
                        if realty == 2 {
                            sleepPointsC = sleepPointsC - 16
                        } else {
                            if realty == 3 {
                                sleepPointsC = sleepPointsC - 12
                            } else {
                                if realty == 4 {
                                    sleepPointsC = sleepPointsC - 8
                                } else {
                                    if realty == 5 {
                                        sleepPointsC = sleepPointsC - 5
                                    } else {
                                        if realty == 6 {
                                            sleepPointsC = sleepPointsC - 2
                                        } else {
                                            sleepPointsC = sleepPointsC - 23
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if eat3000C == 1 {
                        eatPointsC = eatPointsC - 1
                    } else {
                        if cookerC == 1 {
                            eatPointsC = eatPointsC - 7
                        } else {
                            eatPointsC = eatPointsC - 13
                        }
                    }
                    smilePointsC = smilePointsC + 18
                    if lastChanceC > 0 {
                        lastChanceC = lastChanceC - 1
                    }
                    lifeSetupC()
                } else {
                    noGames()
                }
            } else {
                noPopularity(pop: 250)
            }
        } else {
            noI3PCOrConsole()
        }
    }
    @IBAction func doLetsPlayButtonAction(_ sender: Any) {
        if allTech >= 3 {
            if allPopularity! >= 2500 {
                if letsPlays > 0 {
                    salaryLetsPlay = 500 + (allPopularity! / 25)
                    delegate?.controllerAction(rubC: salaryLetsPlay, dollarC: 0, masterPointsC: 200, popularityPointsC: 150)
                    allRub = allRub! + salaryLetsPlay
                    allMaster = allMaster! + 200
                    allPopularity = allPopularity! + 150
                    letsPlays = letsPlays - 1
                    checkRentC()
                    if realty == 1 {
                        sleepPointsC = sleepPointsC - 9
                    } else {
                        if realty == 2 {
                            sleepPointsC = sleepPointsC - 6
                        } else {
                            if realty == 3 {
                                sleepPointsC = sleepPointsC - 4
                            } else {
                                if realty == 4 {
                                    sleepPointsC = sleepPointsC - 3
                                } else {
                                    if realty == 5 {
                                        sleepPointsC = sleepPointsC - 2
                                    } else {
                                        if realty == 6 {
                                            sleepPointsC = sleepPointsC - 1
                                        } else {
                                            sleepPointsC = sleepPointsC - 11
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if eat3000C == 1 {
                        eatPointsC = eatPointsC - 2
                    } else {
                        if cookerC == 1 {
                            eatPointsC = eatPointsC - 10
                        } else {
                            eatPointsC = eatPointsC - 19
                        }
                    }
                    smilePointsC = smilePointsC + 27
                    if lastChanceC > 0 {
                        lastChanceC = lastChanceC - 1
                    }
                    lifeSetupC()
                } else {
                    noLetsPlays()
                }
            } else {
                noPopularity(pop: 2500)
            }
        } else {
            noI5PC()
        }
    }
    @IBAction func streamGameButtonAction(_ sender: Any) {
        if allTech >= 4 {
            if allPopularity! >= 10000 {
                if buyedGames > 0 {
                    salaryStreamRub = 2000 + (allPopularity! / 25)
                    salaryStreamDollar = allPopularity! / 25 - 400
                    delegate?.controllerAction(rubC: salaryStreamRub, dollarC: salaryStreamDollar, masterPointsC: 350, popularityPointsC: 500)
                    allRub = allRub! + salaryStreamRub
                    allDollar = allDollar! + salaryStreamDollar
                    allMaster = allMaster! + 350
                    allPopularity = allPopularity! + 500
                    checkRentC()
                    if realty == 1 {
                        sleepPointsC = sleepPointsC - 32
                    } else {
                        if realty == 2 {
                            sleepPointsC = sleepPointsC - 24
                        } else {
                            if realty == 3 {
                                sleepPointsC = sleepPointsC - 17
                            } else {
                                if realty == 4 {
                                    sleepPointsC = sleepPointsC - 11
                                } else {
                                    if realty == 5 {
                                        sleepPointsC = sleepPointsC - 7
                                    } else {
                                        if realty == 6 {
                                            sleepPointsC = sleepPointsC - 3
                                        } else {
                                            sleepPointsC = sleepPointsC - 34
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if eat3000C == 1 {
                        eatPointsC = eatPointsC - 3
                    } else {
                        if cookerC == 1 {
                            eatPointsC = eatPointsC - 15
                        } else {
                            eatPointsC = eatPointsC - 29
                        }
                    }
                    smilePointsC = smilePointsC + 31
                    if lastChanceC > 0 {
                        lastChanceC = lastChanceC - 1
                    }
                    lifeSetupC()
                } else {
                    noBuyedGames()
                }
            } else {
                noPopularity(pop: 10000)
            }
        } else {
            noI7PC()
        }
    }
    @IBAction func visitEventButtonAction(_ sender: Any) {
        if allDollar! >= 3000 {
            delegate?.controllerAction(rubC: 0, dollarC: -3000, masterPointsC: 3000, popularityPointsC: 1000)
            allDollar = allDollar! - 3000
            allMaster = allMaster! + 3000
            allPopularity = allPopularity! + 1000
            visitedEvents = visitedEvents + 1
            checkRentC()
            if realty == 1 {
                sleepPointsC = sleepPointsC - 41
            } else {
                if realty == 2 {
                    sleepPointsC = sleepPointsC - 34
                } else {
                    if realty == 3 {
                        sleepPointsC = sleepPointsC - 25
                    } else {
                        if realty == 4 {
                            sleepPointsC = sleepPointsC - 17
                        } else {
                            if realty == 5 {
                                sleepPointsC = sleepPointsC - 10
                            } else {
                                if realty == 6 {
                                    sleepPointsC = sleepPointsC - 5
                                } else {
                                    sleepPointsC = sleepPointsC - 45
                                }
                            }
                        }
                    }
                }
            }
            if eat3000C == 1 {
                eatPointsC = eatPointsC - 4
            } else {
                if cookerC == 1 {
                    eatPointsC = eatPointsC - 19
                } else {
                    eatPointsC = eatPointsC - 38
                }
            }
            smilePointsC = smilePointsC + 70
            if lastChanceC > 0 {
                lastChanceC = lastChanceC - 1
            }
            lifeSetupC()
        } else {
            noDollar(dollar: 3000)
        }
    }
    @IBAction func takePartInEventButtonAction(_ sender: Any) {
        if allTech >= 5 {
            if visitedEvents >= 1 {
                if allDollar! >= 10000 {
                    chance = Int.random(in:1..<11)
                    visitedEvents = visitedEvents - 1
                    delegate?.controllerAction(rubC: 0, dollarC: -10000, masterPointsC: 0, popularityPointsC: 0)
                    allDollar = allDollar! - 10000
                    checkRentC()
                    if realty == 1 {
                        sleepPointsC = sleepPointsC - 75
                    } else {
                        if realty == 2 {
                            sleepPointsC = sleepPointsC - 62
                        } else {
                            if realty == 3 {
                                sleepPointsC = sleepPointsC - 45
                            } else {
                                if realty == 4 {
                                    sleepPointsC = sleepPointsC - 30
                                } else {
                                    if realty == 5 {
                                        sleepPointsC = sleepPointsC - 18
                                    } else {
                                        if realty == 6 {
                                            sleepPointsC = sleepPointsC - 8
                                        } else {
                                            sleepPointsC = sleepPointsC - 80
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if eat3000C == 1 {
                        eatPointsC = eatPointsC - 6
                    } else {
                        if cookerC == 1 {
                            eatPointsC = eatPointsC - 28
                        } else {
                            eatPointsC = eatPointsC - 55
                        }
                    }
                    smilePointsC = smilePointsC + 68
                    if lastChanceC > 0 {
                        lastChanceC = lastChanceC - 1
                    }
                    lifeSetupC()
                    if chance == 1 {
                        delegate?.controllerAction(rubC: 0, dollarC: 30000, masterPointsC: 10000, popularityPointsC: 15000)
                        allDollar = allDollar! + 30000
                        allMaster = allMaster! + 10000
                        allPopularity = allPopularity! + 15000
                        firstPlace()
                        if locale.hasPrefix("ru") {
                            delegate?.profession(profession: "Киберспортсмен")
                        } else {
                            delegate?.profession(profession: "Cybersportsman")
                        }
                        
                    } else {
                        if chance == 2 {
                            delegate?.controllerAction(rubC: 0, dollarC: 20000, masterPointsC: 7000, popularityPointsC: 10000)
                            allDollar = allDollar! + 20000
                            allMaster = allMaster! + 7000
                            allPopularity = allPopularity! + 10000
                            secondPlace()
                        } else {
                            if chance == 3 {
                                delegate?.controllerAction(rubC: 0, dollarC: 15000, masterPointsC: 5000, popularityPointsC: 7000)
                                allDollar = allDollar! + 15000
                                allMaster = allMaster! + 5000
                                allPopularity = allPopularity! + 7000
                                thirdPlace()
                            } else {
                                if chance == 4 {
                                    delegate?.controllerAction(rubC: 0, dollarC: 10000, masterPointsC: 3000, popularityPointsC: 3000)
                                    allDollar = allDollar! + 10000
                                    allMaster = allMaster! + 3000
                                    allPopularity = allPopularity! + 3000
                                    forthPlace()
                                } else {
                                    if chance == 5 {
                                        delegate?.controllerAction(rubC: 0, dollarC: 5000, masterPointsC: 1500, popularityPointsC: 1000)
                                        allDollar = allDollar! + 5000
                                        allMaster = allMaster! + 1500
                                        allPopularity = allPopularity! + 1000
                                        fifthPlace()
                                    } else {
                                        otherPlace(place: chance)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    noDollar(dollar: 10000)
                }
            } else {
                noEvents()
            }
        } else {
            noI9PC()
        }
    }
    @IBAction func adInNetButtonAction(_ sender: Any) {
        if allRub! >= 2000 {
            delegate?.controllerAction(rubC: -2000, dollarC: 0, masterPointsC: 0, popularityPointsC: 50)
            allRub = allRub! - 2000
            allPopularity = allPopularity! + 50
            smilePointsC = smilePointsC + 6
            lifeSetupC()
        } else {
            noMoney(money: 2000)
        }
    }
    @IBAction func adInSocialButtonAction(_ sender: Any) {
        if allRub! >= 5000 {
            delegate?.controllerAction(rubC: -5000, dollarC: 0, masterPointsC: 0, popularityPointsC: 150)
            allRub = allRub! - 5000
            allPopularity = allPopularity! + 150
            smilePointsC = smilePointsC + 12
            lifeSetupC()
        } else {
            noMoney(money: 5000)
        }
    }
    @IBAction func adFromBloggerButtonAction(_ sender: Any) {
        if allRub! >= 13000 {
            delegate?.controllerAction(rubC: -13000, dollarC: 0, masterPointsC: 0, popularityPointsC: 400)
            allRub = allRub! - 13000
            allPopularity = allPopularity! + 400
            smilePointsC = smilePointsC + 17
            lifeSetupC()
        } else {
            noMoney(money: 13000)
        }
    }
    @IBAction func makeCompetitionButtonAction(_ sender: Any) {
        if allRub! >= 35000 {
            delegate?.controllerAction(rubC: -35000, dollarC: 0, masterPointsC: 0, popularityPointsC: 1500)
            allRub = allRub! - 35000
            allPopularity = allPopularity! + 1500
            smilePointsC = smilePointsC + 25
            lifeSetupC()
        } else {
            noMoney(money: 35000)
        }
    }
    @IBAction func profileButtonActionController(_ sender: Any) {
        delegate?.rentActionController(roomRent: checkRoomRentC, flatRent: checkFlatRentC, checkRealty: checkRealtyC)
        delegate?.rubChangeC(rubC: allRub!)
        delegate?.changes(plays: plays, games: games, buyedGames: buyedGames, letsPlays: letsPlays, allowedCards: allowedCards, visitedEvents: visitedEvents)
        delegate?.lifeActionController(eat: eatPointsC, smile: smilePointsC, sleep: sleepPointsC)
        delegate?.loseGameController(lose: checkLoseGameC, chance: lastChanceC)
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
        sleepPointsLabelController.text = String(sleepPointsC)
        smilePointsLabelController.text = String(smilePointsC)
        eatPointsLabelController.text = String(eatPointsC)
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    private func noPlays() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы прошли все игры! Чтобы играть дальше купите новую игру!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойти за покупками", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You finish all your games! You must buy a new game!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Go for shopping", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noGames() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы сделали обзор на все купленные игры! Чтобы сделать обзор купите новую игру!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойти за покупками", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You do all reviews! You must buy a new game!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Go for shopping", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noLetsPlays() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы исчерпали каждую игру! Купите новую!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду куплю новую", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You do all let's plays whatyou can do! Buy a new game!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noMoney(money: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(money - allRub!) руб.!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You must to get \(money - allRub!) rub!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noBuyedGames() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "У вас нет ни одной игры! Купите хотя бы одну игру!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойти за покупками", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You have not got any games!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Go for shopping", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noPopularity(pop: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(pop - allPopularity!) очков популярности!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You must to get \(pop - allPopularity!) master points!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    private func noCards() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы купили все коллекционные карточки для этой игры! Чтобы приорести новые, купите игру!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойти за покупками", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You bought all collector's cards! Buy new game to get new cards!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Go for shopping", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func noEvents() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Перед тем как попасть на турнир нужно его посетить!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Смириться", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You must to visit the competition!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    private func noDollar(dollar: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вам не хватает \(dollar - allDollar!) $!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Пойду копить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You must to get \(dollar - allDollar!) $!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func firstPlace() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли 1 место на турнире! Вы получаете 30000 $ и 15000 очков популярности! Теперь вы становитесь Киберспортсменом!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Ура! Я очень рад!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You've got 1 place! You've got 30000 $ and 15000 master points! Now you are cybersportsman!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Oh... Cool!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func secondPlace() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли 2 место на турнире! Вы получаете 20000 $ и 10000 очков популярности!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Эх, пойду поиграю!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You've got 2 place! You've got 20000 $ and 10000 master points!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Cool!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func thirdPlace() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли 3 место на турнире! Вы получаете 15000 $ и 7000 очков популярности!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Самый главный победитель!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You've got 3 place! You've got 15000 $ and 7000 master points!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"I am 'winner'!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func forthPlace() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли 4 место на турнире! Вы получаете 10000 $ и 3000 очков популярности!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Уже почти!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You've got 4 place! You've got 10000 $ and 3000 master points!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"I am near!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func fifthPlace() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли 5 место на турнире! Вы получаете 5000 $ и 1000 очков популярности!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хотя бы так!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You've got 5 place! You've got 5000 $ and 1000 master points!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"I'm here!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func otherPlace(place: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы заняли \(place) место на турнире! Вы получаете бесценный опыт. В следующий раз у вас все получится!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Первый шаг на пути к победе!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You've got \(place) place! You've got some experience. Let's try again!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"It's my first step!", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkRentC() {
        if checkRealtyC == 2 {
            if checkRoomRentC > 0 {
                checkRoomRentC = checkRoomRentC - 1
            } else {
                if checkRoomRentC == 0 {
                    if allRub! >= 7000 {
                        allRub = allRub! - 7000
                        checkRoomRentC = checkRoomRentC + 30
                        rentSuccessC()
                    } else {
                        checkRealtyC = 0
                        noHomeC()
                    }
                }
            }
        }
        if checkRealtyC == 3 {
            if checkFlatRentC > 0 {
                checkFlatRentC = checkFlatRentC - 1
            } else {
                if checkFlatRentC == 0 {
                    if allRub! >= 25000 {
                        allRub = allRub! - 25000
                        checkFlatRentC = checkFlatRentC + 30
                        rentSuccessC()
                    } else {
                        checkRealtyC = 0
                        noHomeC()
                    }
                }
            }
        }
    }
    private func noHomeC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "У вас не хватает денег на продление аренды! Вы будете немедленно выселены!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Подкопить и продлить", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You haven't got money for rent!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func rentSuccessC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Аренда успешно продлена!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "Rent extended!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Cool", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func noNotebook() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы не можете играть в игры, у вас нет ни компьютера, ни консоли! Приобретите хотя бы ноутбук!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You have not got PC or notebook!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    private func noI3PCOrConsole() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Для снятия и обработки обзоров на игры вам не хватает мощности! Приобретите хотя бы ПК на i3 или консоль!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You must buy PC on i3 or console to do this!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    private func noI9PC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Вы крутой игрок, вам нужен хороший железный конь! Приобретите ПК на i9!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "You are cool player! You must to get PC on i9!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Interesting", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func noI5PC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Для отснятия качественных летсплеев, вам необходим апгрейд вашего железа! Приобретите ПК хотя бы на i5!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "For let's plays you must to get upgrade! Buy PC on i5 for the first time!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"OK. Let's do it", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func noI7PC() {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Для того, чтобы тянуть стримы вам нужен ПК помощнее! Избавьтесь от лагов! Приобретите ПК хотя бы на i7 и ваша аудитория скажет вам спасибо!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Хорошо", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention", message: "That's streams time!!! Please, buy PC on i7 for that!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Yes, sir", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func lifeSetupC() {
        if sleepPointsC > 100 {
            sleepPointsC = 100
        } else {
            if sleepPointsC <= 0 {
                sleepPointsC = 0
                if lastChanceC < 0 {
                    lastChanceC = 3
                }
            }
        }
        if smilePointsC > 100 {
            smilePointsC = 100
        } else {
            if smilePointsC <= 0 {
                smilePointsC = 0
                if lastChanceC < 0 {
                    lastChanceC = 3
                }
            }
        }
        if eatPointsC > 100 {
            eatPointsC = 100
        } else {
            if eatPointsC <= 0 {
                eatPointsC = 0
                if lastChanceC < 0 {
                    lastChanceC = 3
                }
            }
        }
        eatPointsLabelController.text = String(eatPointsC)
        smilePointsLabelController.text = String(smilePointsC)
        sleepPointsLabelController.text = String(sleepPointsC)
        loseGameC()
    }
    private func loseGameC() {
        if locale.hasPrefix("ru") {
            if lastChanceC == 0 {
                let alert = UIAlertController(title: "Внимание!!!", message: "Вы проиграли!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Начать заново", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameC = 1
                    self.delegate?.loseGameController(lose: self.checkLoseGameC, chance: self.lastChanceC)
                    self.delegate?.lifeActionController(eat: self.eatPointsC, smile: self.smilePointsC, sleep: self.sleepPointsC)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceC == 3 {
                    let alert = UIAlertController(title: "Внимание!!!", message: "У вас есть \(lastChanceC!) шага для того чтобы исправить ситуацию или вы проиграете! Потратьте их с пользой!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я справлюсь!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            if lastChanceC == 0 {
                let alert = UIAlertController(title: "Attention!!!", message: "You lost!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Start new game", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameC = 1
                    self.delegate?.loseGameController(lose: self.checkLoseGameC, chance: self.lastChanceC)
                    self.delegate?.lifeActionController(eat: self.eatPointsC, smile: self.smilePointsC, sleep: self.sleepPointsC)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceC == 3 {
                    let alert = UIAlertController(title: "Attention!!!", message: "You have \(lastChanceC!) steps before you lose the game!", preferredStyle: UIAlertController.Style.alert)
                    
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
