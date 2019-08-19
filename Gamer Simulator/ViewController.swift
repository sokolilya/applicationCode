//
//  ViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 19/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate {
    
    @IBOutlet weak var eatPointsLabelProfile: UILabel!
    @IBOutlet weak var smilePointsLabelProfile: UILabel!
    @IBOutlet weak var sleepPointsLabelProfile: UILabel!
    @IBOutlet weak var rubScoreLabel: UILabel!
    @IBOutlet weak var dollarScoreLabel: UILabel!
    @IBOutlet weak var realtyLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var masterPointsLabel: UILabel!
    @IBOutlet weak var popularityPointsLabel: UILabel!
    @IBOutlet weak var workLevelLabel: UILabel!
    @IBAction func workButtonActionProfile(_ sender: Any) {
    }
    @IBAction func controllerButtonActionProfile(_ sender: Any) {
    }
    @IBAction func bankButtonActionProfile(_ sender: Any) {
    }
    @IBAction func shopButtonActionProfile(_ sender: Any) {
    }
    @IBAction func helpButtonAction(_ sender: Any) {
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
        save()
    }
    @IBAction func sleepPointsButtonActionProfile(_ sender: Any) {
        sleepPointsMain = sleepPointsMain + 57
        smilePointsMain = smilePointsMain + 3
        eatPointsMain = eatPointsMain - 23
        if lastChanceMain > 0 {
            lastChanceMain = lastChanceMain - 1
        }
        lifeSetupMain()
        loseGameMain()
        save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let user = try storage.appUser()
            allowedCardsMain = Int(user?.allowedCards ?? "0")
            buyedGamesMain = Int(user?.buyedGames ?? "0")
            buyedRealtyMain = Int(user?.buyedRealty ?? "0")
            buyedTransportMain = Int(user?.buyedTransport ?? "0")
            checkAllTechMain = Int(user?.checkAllTech ?? "0")
            checkConsoleMain = Int(user?.checkConsole ?? "0")
            checkCookerMain = Int(user?.checkCooker ?? "0")
            checkEat3000Main = Int(user?.checkEat3000 ?? "0")
            checkConsoleMain = Int(user?.checkConsole ?? "0")
            checkFlatRentMain = Int(user?.checkFlatRent ?? "0")
            checkGameLoseMain = Int(user?.checkGameLose ?? "0")
            checkI3PCMain = Int(user?.checkI3PC ?? "0")
            checkI5PCMain = Int(user?.checkI5PC ?? "0")
            checkI7PCMain = Int(user?.checkI7PC ?? "0")
            checkI9PCMain = Int(user?.checkI9PC ?? "0")
            checkMonitorMain = Int(user?.checkMonitor ?? "0")
            checkNotebookMain = Int(user?.checkNotebook ?? "0")
            checkRoomRentMain = Int(user?.checkRoomRent ?? "0")
            checkTechMain = Int(user?.checkTech ?? "0")
            checkTransportMain = Int(user?.checkTransport ?? "0")
            dollar = Int(user?.dollar ?? "15")
            eatPointsMain = Int(user?.eatPoints ?? "80")
            gamesMain = Int(user?.games ?? "0")
            lastChanceMain = Int(user?.lastChance ?? "-1")
            letsPlaysMain = Int(user?.letsPlays ?? "0")
            master = Int(user?.master ?? "0")
            playsMain = Int(user?.plays ?? "0")
            popularity = Int(user?.popularity ?? "0")
            rub = Int(user?.rub ?? "1000")
            sleepPointsMain = Int(user?.sleepPoints ?? "90")
            smilePointsMain = Int(user?.smilePoints ?? "100")
            visitedEventsMain = Int(user?.visitedEvents ?? "0")
            workLevel = user?.workLevel
        } catch {
            process(error: error)
        }
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5876707192699554/7654571422")
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rubScoreLabel.text = String(rub)
        dollarScoreLabel.text = String(dollar)
        eatPointsLabelProfile.text = String(eatPointsMain)
        smilePointsLabelProfile.text = String(smilePointsMain)
        sleepPointsLabelProfile.text = String(sleepPointsMain)
        popularityPointsLabel.text = String(popularity)
        masterPointsLabel.text = String(master)
        workLevelLabel.text = workLevel
        realty()
        transport()
        lifeSetupMain()
        if checkGameLoseMain == 1 {
            loseGameMainAgain()
        }
        save()
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    
    lazy var storage: IStorage = serviceLocator.storage
    
    var interstitial: GADInterstitial!
    var adChance : Int! = 0
    
    let locale = NSLocale.preferredLanguages.first!
    
    var rub : Int! = 1000
    var dollar : Int! = 15
    var master : Int! = 0
    var popularity : Int! = 0
    var check1main : Int! = 1
    var check2main : Int! = 2
    var check3main : Int! = 3
    var check4main : Int! = 4
    var check5main : Int! = 5
    var check6main : Int! = 6
    var check7main : Int! = 7
    var playsMain : Int! = 0
    var gamesMain : Int! = 0
    var buyedGamesMain : Int! = 0
    var letsPlaysMain : Int! = 0
    var allowedCardsMain : Int! = 0
    var visitedEventsMain : Int! = 0
    var checkEat3000Main : Int! = 0
    var checkCookerMain : Int! = 0
    var checkTechMain : Int! = 0
    var checkTransportMain : Int! = 0
    var checkRoomRentMain : Int! = 0
    var checkFlatRentMain : Int! = 0
    var buyedRealtyMain : Int! = 0
    var buyedTransportMain : Int! = 0
    var checkNotebookMain : Int! = 0
    var checkI3PCMain : Int! = 0
    var checkConsoleMain : Int! = 0
    var checkI5PCMain : Int! = 0
    var checkI7PCMain : Int! = 0
    var checkI9PCMain : Int! = 0
    var checkMonitorMain : Int! = 0
    var checkAllTechMain : Int! = 0
    var sleepPointsMain : Int! = 90
    var eatPointsMain : Int! = 80
    var smilePointsMain : Int! = 100
    var lastChanceMain : Int! = -1
    var checkGameLoseMain : Int! = 0
    var workLevel : String! = "Не трудоустроен"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWorkProfile" {
            let vc : WorkViewController = segue.destination as! WorkViewController
            vc.delegate = self
            vc.mainVCMasterPoints = master
            vc.check1 = check1main
            vc.check2 = check2main
            vc.check3 = check3main
            vc.check4 = check4main
            vc.check5 = check5main
            vc.check6 = check6main
            vc.check7 = check7main
            vc.checkRoomRentWork = checkRoomRentMain
            vc.checkFlatRentWork = checkFlatRentMain
            vc.rubWork = rub
            vc.checkRealtyWork = buyedRealtyMain
            vc.eatPointsWork = eatPointsMain
            vc.smilePointsWork = smilePointsMain
            vc.sleepPointsWork = sleepPointsMain
            vc.lastChanceWork = lastChanceMain
            vc.checkLoseGameWork = checkGameLoseMain
            vc.cookerWork = checkCookerMain
            vc.eat3000Work = checkEat3000Main
            vc.realty = buyedRealtyMain
            vc.transport = buyedTransportMain
        } else {
            if segue.identifier == "toBankProfile" {
                let vc : BankViewController = segue.destination as! BankViewController
                vc.delegate = self
                vc.allRub = rub
                vc.allDollar = dollar
                vc.eatPointsBank = eatPointsMain
                vc.smilePointsBank = smilePointsMain
                vc.sleepPointsBank = sleepPointsMain
                vc.lastChanceBank = lastChanceMain
                vc.checkLoseGameBank = checkGameLoseMain
            } else {
                if segue.identifier == "toControllerProfile" {
                    let vc : ControllerViewController = segue.destination as! ControllerViewController
                    vc.delegate = self
                    vc.allRub = rub
                    vc.allDollar = dollar
                    vc.allMaster = master
                    vc.allPopularity = popularity
                    vc.plays = playsMain
                    vc.games = gamesMain
                    vc.buyedGames = buyedGamesMain
                    vc.letsPlays = letsPlaysMain
                    vc.allowedCards = allowedCardsMain
                    vc.visitedEvents = visitedEventsMain
                    vc.professionController = workLevelLabel.text
                    vc.checkRoomRentC = checkRoomRentMain
                    vc.checkFlatRentC = checkFlatRentMain
                    vc.allTech = checkAllTechMain
                    vc.checkRealtyC = buyedRealtyMain
                    vc.eatPointsC = eatPointsMain
                    vc.smilePointsC = smilePointsMain
                    vc.sleepPointsC = sleepPointsMain
                    vc.lastChanceC = lastChanceMain
                    vc.checkLoseGameC = checkGameLoseMain
                    vc.realty = buyedRealtyMain
                    vc.transport = buyedTransportMain
                    vc.cookerC = checkCookerMain
                    vc.eat3000C = checkEat3000Main
                } else {
                    if segue.identifier == "toShopProfile" {
                        let vc : ShopViewController = segue.destination as! ShopViewController
                        vc.delegate = self
                        vc.allRubShop = rub
                        vc.allDollarShop = dollar
                        vc.transportShop = transportLabel.text
                        vc.realtyShop = realtyLabel.text
                        vc.checkTech = checkTechMain
                        vc.checkTransport = checkTransportMain
                        vc.checkRoomRent = checkRoomRentMain
                        vc.checkFlatRent = checkFlatRentMain
                        vc.checkRealty = buyedRealtyMain
                        vc.checkTransport = buyedTransportMain
                        vc.checkNotebook = checkNotebookMain
                        vc.checkI3PC = checkI3PCMain
                        vc.checkConsole = checkConsoleMain
                        vc.checkI5PC = checkI5PCMain
                        vc.checkI7PC = checkI7PCMain
                        vc.checkMonitor = checkMonitorMain
                        vc.checkI9PC = checkI9PCMain
                        vc.checkAllTech = checkAllTechMain
                        vc.checkCookerShop = checkCookerMain
                        vc.checkEat3000Shop = checkEat3000Main
                        vc.eatPointsShop = eatPointsMain
                        vc.smilePointsShop = smilePointsMain
                        vc.sleepPointsShop = sleepPointsMain
                        vc.lastChanceShop = lastChanceMain
                        vc.checkLoseGameShop = checkGameLoseMain
                    }
                }
            }
        }
    }
    
    private func realty() {
        if locale.hasPrefix("ru") {
            
            if buyedRealtyMain == 0 {
                realtyLabel.text = "Бомж"
            } else {
                if buyedRealtyMain == 1 {
                    realtyLabel.text = "Бомж на вокзале"
                } else {
                    if buyedRealtyMain == 2 {
                        realtyLabel.text = "Снимает комнату"
                    } else {
                        if buyedRealtyMain == 3 {
                            realtyLabel.text = "Снимает квартиру"
                        } else {
                            if buyedRealtyMain == 4 {
                                realtyLabel.text = "Квартира"
                            } else {
                                if buyedRealtyMain == 5 {
                                    realtyLabel.text = "Пентхаус"
                                } else {
                                    if buyedRealtyMain == 6 {
                                        realtyLabel.text = "Вилла"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
                if buyedRealtyMain == 0 {
                    realtyLabel.text = "Bum"
                } else {
                    if buyedRealtyMain == 1 {
                        realtyLabel.text = "Bum on railway"
                    } else {
                        if buyedRealtyMain == 2 {
                            realtyLabel.text = "Rent room"
                        } else {
                            if buyedRealtyMain == 3 {
                                realtyLabel.text = "Rent flat"
                            } else {
                                if buyedRealtyMain == 4 {
                                    realtyLabel.text = "Flat"
                                } else {
                                    if buyedRealtyMain == 5 {
                                        realtyLabel.text = "Penthause"
                                    } else {
                                        if buyedRealtyMain == 6 {
                                            realtyLabel.text = "Villa"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private func transport() {
        
        if locale.hasPrefix("ru") {
            if buyedTransportMain == 0 {
                transportLabel.text = "Пешком"
            } else {
                if buyedTransportMain == 1 {
                    transportLabel.text = "Велосипед"
                } else {
                    if buyedTransportMain == 2 {
                        transportLabel.text = "Электросамокат"
                    } else {
                        if buyedTransportMain == 3 {
                            transportLabel.text = "Скутер"
                        } else {
                            if buyedTransportMain == 4 {
                                transportLabel.text = "Б/у машина"
                            } else {
                                if buyedTransportMain == 5 {
                                    transportLabel.text = "Машина"
                                } else {
                                    if buyedTransportMain == 6 {
                                        transportLabel.text = "Премиум авто"
                                    } else {
                                        if buyedTransportMain == 7 {
                                            transportLabel.text = "Вертолет"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
                if buyedTransportMain == 0 {
                    transportLabel.text = "On foot"
                } else {
                    if buyedTransportMain == 1 {
                        transportLabel.text = "Bycicle"
                    } else {
                        if buyedTransportMain == 2 {
                            transportLabel.text = "Electric scooter"
                        } else {
                            if buyedTransportMain == 3 {
                                transportLabel.text = "Scooter"
                            } else {
                                if buyedTransportMain == 4 {
                                    transportLabel.text = "Re-owned car"
                                } else {
                                    if buyedTransportMain == 5 {
                                        transportLabel.text = "Car"
                                    } else {
                                        if buyedTransportMain == 6 {
                                            transportLabel.text = "Premium car"
                                        } else {
                                            if buyedTransportMain == 7 {
                                                transportLabel.text = "Helicopter"
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
    private func lifeSetupMain() {
        if sleepPointsMain > 100 {
            sleepPointsMain = 100
        }
        if sleepPointsMain < 0 {
            sleepPointsMain = 0
            if lastChanceMain < 0 {
                lastChanceMain = 3
            }
        }
        if smilePointsMain > 100 {
            smilePointsMain = 100
        }
        if smilePointsMain < 0 {
            smilePointsMain = 0
            if lastChanceMain < 0 {
                lastChanceMain = 3
            }
        }
        if eatPointsMain > 100 {
            eatPointsMain = 100
        }
        if eatPointsMain < 0 {
            eatPointsMain = 0
            if lastChanceMain < 0 {
                lastChanceMain = 3
            }
        }
        eatPointsLabelProfile.text = String(eatPointsMain)
        smilePointsLabelProfile.text = String(smilePointsMain)
        sleepPointsLabelProfile.text = String(sleepPointsMain)
    }
    private func loseGameMain() {
        if locale.hasPrefix("ru") {
            if lastChanceMain == 0 {
                let alert = UIAlertController(title: "Внимание!!!", message: "Вы проиграли!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Начать заново", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.lastChanceMain = -1
                    self.rub = 1000
                    self.dollar = 15
                    self.master = 0
                    self.popularity = 0
                    self.playsMain = 0
                    self.gamesMain = 0
                    self.buyedGamesMain = 0
                    self.letsPlaysMain = 0
                    self.allowedCardsMain = 0
                    self.visitedEventsMain = 0
                    self.checkEat3000Main = 0
                    self.checkCookerMain = 0
                    self.checkTechMain = 0
                    self.checkTransportMain = 0
                    self.checkRoomRentMain = 0
                    self.checkFlatRentMain = 0
                    self.buyedRealtyMain = 0
                    self.buyedTransportMain = 0
                    self.checkNotebookMain = 0
                    self.checkI3PCMain = 0
                    self.checkConsoleMain = 0
                    self.checkI5PCMain = 0
                    self.checkI7PCMain = 0
                    self.checkI9PCMain = 0
                    self.checkMonitorMain = 0
                    self.checkAllTechMain = 0
                    self.sleepPointsMain = 90
                    self.eatPointsMain = 80
                    self.smilePointsMain = 100
                    self.eatPointsLabelProfile.text = String(self.eatPointsMain)
                    self.smilePointsLabelProfile.text = String(self.smilePointsMain)
                    self.sleepPointsLabelProfile.text = String(self.sleepPointsMain)
                    self.rubScoreLabel.text = String(self.rub)
                    self.dollarScoreLabel.text = String(self.dollar)
                    self.transportLabel.text = "Пешком"
                    self.realtyLabel.text = "Бомж"
                    self.masterPointsLabel.text = String(self.master)
                    self.popularityPointsLabel.text = String(self.popularity)
                    self.workLevel = "Не трудоустроен"
                    self.workLevelLabel.text = "Не трудоустроен"
                    self.checkGameLoseMain = 0
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceMain == 3 {
                    let alert = UIAlertController(title: "Внимание!!!", message: "У вас есть \(lastChanceMain!) шага для того чтобы исправить ситуацию или вы проиграете! Потратьте их с пользой!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я справлюсь!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
                if lastChanceMain == 0 {
                    let alert = UIAlertController(title: "Attention!!!", message: "You lost!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Start new game", style: UIAlertAction.Style.default, handler:{ (action) in
                        self.lastChanceMain = -1
                        self.rub = 1000
                        self.dollar = 15
                        self.master = 0
                        self.popularity = 0
                        self.playsMain = 0
                        self.gamesMain = 0
                        self.buyedGamesMain = 0
                        self.letsPlaysMain = 0
                        self.allowedCardsMain = 0
                        self.visitedEventsMain = 0
                        self.checkEat3000Main = 0
                        self.checkCookerMain = 0
                        self.checkTechMain = 0
                        self.checkTransportMain = 0
                        self.checkRoomRentMain = 0
                        self.checkFlatRentMain = 0
                        self.buyedRealtyMain = 0
                        self.buyedTransportMain = 0
                        self.checkNotebookMain = 0
                        self.checkI3PCMain = 0
                        self.checkConsoleMain = 0
                        self.checkI5PCMain = 0
                        self.checkI7PCMain = 0
                        self.checkI9PCMain = 0
                        self.checkMonitorMain = 0
                        self.checkAllTechMain = 0
                        self.sleepPointsMain = 90
                        self.eatPointsMain = 80
                        self.smilePointsMain = 100
                        self.eatPointsLabelProfile.text = String(self.eatPointsMain)
                        self.smilePointsLabelProfile.text = String(self.smilePointsMain)
                        self.sleepPointsLabelProfile.text = String(self.sleepPointsMain)
                        self.rubScoreLabel.text = String(self.rub)
                        self.dollarScoreLabel.text = String(self.dollar)
                        self.transportLabel.text = "On foot"
                        self.realtyLabel.text = "Bum"
                        self.masterPointsLabel.text = String(self.master)
                        self.popularityPointsLabel.text = String(self.popularity)
                        self.workLevel = "Doesn't have"
                        self.workLevelLabel.text = "Doesn't have"
                        self.checkGameLoseMain = 0
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if lastChanceMain == 3 {
                        let alert = UIAlertController(title: "Attention!!!", message: "You have \(lastChanceMain!) steps before you lose the game!", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title:"I can win!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func loseGameMainAgain() {
        if locale.hasPrefix("ru") {
            if lastChanceMain == 0 {
                lastChanceMain = -1
                rub = 1000
                dollar = 15
                master = 0
                popularity = 0
                playsMain = 0
                gamesMain = 0
                buyedGamesMain = 0
                letsPlaysMain = 0
                allowedCardsMain = 0
                visitedEventsMain = 0
                checkEat3000Main = 0
                checkCookerMain = 0
                checkTechMain = 0
                checkTransportMain = 0
                checkRoomRentMain = 0
                checkFlatRentMain = 0
                buyedRealtyMain = 0
                buyedTransportMain = 0
                checkNotebookMain = 0
                checkI3PCMain = 0
                checkConsoleMain = 0
                checkI5PCMain = 0
                checkI7PCMain = 0
                checkI9PCMain = 0
                checkMonitorMain = 0
                checkAllTechMain = 0
                sleepPointsMain = 90
                eatPointsMain = 80
                smilePointsMain = 100
                eatPointsLabelProfile.text = String(eatPointsMain)
                smilePointsLabelProfile.text = String(smilePointsMain)
                sleepPointsLabelProfile.text = String(sleepPointsMain)
                rubScoreLabel.text = String(rub)
                dollarScoreLabel.text = String(dollar)
                transportLabel.text = "Пешком"
                realtyLabel.text = "Бомж"
                masterPointsLabel.text = String(master)
                popularityPointsLabel.text = String(popularity)
                workLevel = "Не трудоустроен"
                workLevelLabel.text = "Не трудоустроен"
                checkGameLoseMain = 0
            }
        } else {
                if lastChanceMain == 0 {
                    lastChanceMain = -1
                    rub = 1000
                    dollar = 15
                    master = 0
                    popularity = 0
                    playsMain = 0
                    gamesMain = 0
                    buyedGamesMain = 0
                    letsPlaysMain = 0
                    allowedCardsMain = 0
                    visitedEventsMain = 0
                    checkEat3000Main = 0
                    checkCookerMain = 0
                    checkTechMain = 0
                    checkTransportMain = 0
                    checkRoomRentMain = 0
                    checkFlatRentMain = 0
                    buyedRealtyMain = 0
                    buyedTransportMain = 0
                    checkNotebookMain = 0
                    checkI3PCMain = 0
                    checkConsoleMain = 0
                    checkI5PCMain = 0
                    checkI7PCMain = 0
                    checkI9PCMain = 0
                    checkMonitorMain = 0
                    checkAllTechMain = 0
                    sleepPointsMain = 90
                    eatPointsMain = 80
                    smilePointsMain = 100
                    eatPointsLabelProfile.text = String(eatPointsMain)
                    smilePointsLabelProfile.text = String(smilePointsMain)
                    sleepPointsLabelProfile.text = String(sleepPointsMain)
                    rubScoreLabel.text = String(rub)
                    dollarScoreLabel.text = String(dollar)
                    transportLabel.text = "On foot"
                    realtyLabel.text = "Bum"
                    masterPointsLabel.text = String(master)
                    popularityPointsLabel.text = String(popularity)
                    workLevel = "Doesn't have"
                    workLevelLabel.text = "Doesn't have"
                    checkGameLoseMain = 0
            }
        }
    }
    
    private func process(error: Error) {
        print(error)
    }
    
    private func save() {
        storage.saveAppUser(allowedCards: allowedCardsMain, buyedGames: buyedGamesMain, buyedRealty: buyedRealtyMain, buyedTransport: buyedTransportMain, allTech: checkAllTechMain, console: checkConsoleMain, cooker: checkCookerMain, eat3000: checkEat3000Main, flatRent: checkFlatRentMain, gameLose: checkGameLoseMain, i3PC: checkI3PCMain, i5PC: checkI5PCMain, i7PC: checkI7PCMain, i9PC: checkI9PCMain, monitor: checkMonitorMain, notebook: checkNotebookMain, roomRent: checkRoomRentMain, tech: checkTechMain, transport: checkTransportMain, dollar: dollar, eatPoints: eatPointsMain, games: gamesMain, lastChance: lastChanceMain, letsPlays: letsPlaysMain, master: master, plays: playsMain, popularity: popularity, rub: rub, sleepPoints: sleepPointsMain, smilePoints: smilePointsMain, visitedEvents: visitedEventsMain, workLevel: workLevel)
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

extension ViewController: WorkDelegate {
    
    func loseGameWork(lose: Int, chance: Int) {
        checkGameLoseMain = lose
        lastChanceMain = chance
    }
    
    func lifeActionWork(eat: Int, smile: Int, sleep: Int) {
        eatPointsMain = eat
        smilePointsMain = smile
        sleepPointsMain = sleep
    }
    
    func rubChangeWork(rubWork: Int) {
        rub = rubWork
        rubScoreLabel.text = String(rub)
    }
    func rentActionWork(roomRent: Int, flatRent: Int, checkRealty: Int) {
        checkFlatRentMain = flatRent
        checkRoomRentMain = roomRent
        buyedRealtyMain = checkRealty
    }
    func yourProfession(profession: String, check1: Int, check2: Int, check3: Int, check4: Int, check5: Int, check6: Int, check7: Int) {
        workLevelLabel.text = profession
        workLevel = profession
        check1main = check1
        check2main = check2
        check3main = check3
        check4main = check4
        check5main = check5
        check6main = check6
        check7main = check7
    }
    
    func workDone(salary: Int, masterPoints: Int) {
        rub = rub + salary
        master = master + masterPoints
        rubScoreLabel.text = String(rub)
        masterPointsLabel.text = String(master)
    }
}

extension ViewController: BankDelegate{
    
    func loseGameBank(lose: Int, chance: Int) {
        checkGameLoseMain = lose
        lastChanceMain = chance
    }
    
    func lifeActionBank(eat: Int, smile: Int, sleep: Int) {
        eatPointsMain = eat
        smilePointsMain = smile
        sleepPointsMain = sleep
    }
    
    func bankAction(rubBank: Int, dollarBank: Int) {
        rub = rub + rubBank
        dollar = dollar + dollarBank
        rubScoreLabel.text = String(rub)
        dollarScoreLabel.text = String(dollar)
    }
}

extension ViewController: ControllerDelegate {
    
    func loseGameController(lose: Int, chance: Int) {
        checkGameLoseMain = lose
        lastChanceMain = chance
    }
    
    func lifeActionController(eat: Int, smile: Int, sleep: Int) {
        eatPointsMain = eat
        smilePointsMain = smile
        sleepPointsMain = sleep
    }
    
    func rubChangeC(rubC: Int) {
        rub = rubC
        rubScoreLabel.text = String(rub)
    }
    func rentActionController(roomRent: Int, flatRent: Int, checkRealty: Int) {
        checkFlatRentMain = flatRent
        checkRoomRentMain = roomRent
        buyedRealtyMain = checkRealty
    }
    func changes(plays: Int, games: Int, buyedGames: Int, letsPlays: Int, allowedCards: Int, visitedEvents: Int) {
        playsMain = plays
        gamesMain = games
        buyedGamesMain = buyedGames
        letsPlaysMain = letsPlays
        allowedCardsMain = allowedCards
        visitedEventsMain = visitedEvents
    }
    func controllerAction(rubC: Int, dollarC: Int, masterPointsC: Int, popularityPointsC: Int) {
        rub = rub + rubC
        dollar = dollar + dollarC
        master = master + masterPointsC
        popularity = popularity + popularityPointsC
        rubScoreLabel.text = String(rub)
        dollarScoreLabel.text = String(dollar)
        masterPointsLabel.text = String(master)
        popularityPointsLabel.text = String(popularity)
    }
    func profession(profession: String) {
        workLevelLabel.text = profession
    }
}

extension ViewController: ShopDelegate {
    
    func loseGameShop(lose: Int, chance: Int) {
        checkGameLoseMain = lose
        lastChanceMain = chance
    }
    
    func lifeActionShop(eat: Int, smile: Int, sleep: Int) {
        eatPointsMain = eat
        smilePointsMain = smile
        sleepPointsMain = sleep
    }
    
    func eatAction(checkCooker: Int, checkEat3000: Int){
        checkCookerMain = checkCooker
        checkEat3000Main = checkEat3000
    }

    func checkTechShop(notebook: Int, i3PC: Int, console: Int, i5PC: Int, i7PC: Int, monitor: Int, i9PC: Int, check: Int) {
        checkNotebookMain = notebook
        checkI3PCMain = i3PC
        checkI5PCMain = i5PC
        checkI7PCMain = i7PC
        checkI9PCMain = i9PC
        checkConsoleMain = console
        checkMonitorMain = monitor
        checkAllTechMain = check
    }
    
    func rentActionShop(roomRent: Int, flatRent: Int) {
        checkRoomRentMain = roomRent
        checkFlatRentMain = flatRent
    }
    
    func shopAction(rubShop: Int, dollarShop: Int, transportShop: String, realtyShop: String, buyedRealty: Int, buyedTransport: Int) {
        rub = rubShop
        dollar = dollarShop
        rubScoreLabel.text = String(rub)
        dollarScoreLabel.text = String(dollar)
        transportLabel.text = transportShop
        realtyLabel.text = realtyShop
        buyedRealtyMain = buyedRealty
        buyedTransportMain = buyedTransport
    }
    
}
