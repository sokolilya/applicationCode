//
//  WorkViewController.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 27/01/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class WorkViewController: UIViewController, GADInterstitialDelegate {
    
    var mainVCMasterPoints : Int! = 0
    var delegate: WorkDelegate?
    var check : Int! = 0
    var check1 : Int! = 1
    var check2 : Int! = 2
    var check3 : Int! = 3
    var check4 : Int! = 4
    var check5 : Int! = 5
    var check6 : Int! = 6
    var check7 : Int! = 7
    var checkRoomRentWork : Int! = 0
    var checkFlatRentWork : Int! = 0
    var rubWork : Int! = 0
    var checkRealtyWork : Int! = 0
    var eatPointsWork : Int! = 0
    var smilePointsWork : Int! = 0
    var sleepPointsWork : Int! = 0
    var lastChanceWork : Int! = -1
    var checkLoseGameWork : Int! = 0
    var cookerWork : Int! = 0
    var eat3000Work : Int! = 0
    var realty : Int! = 0
    var transport : Int! = 0
    
    var adChance : Int! = 0
    var interstitial: GADInterstitial!
    
    let locale = NSLocale.preferredLanguages.first!
    
    @IBOutlet weak var eatPointsLabelWork: UILabel!
    @IBOutlet weak var smilePointsLabelWork: UILabel!
    @IBOutlet weak var sleepPointsLabelWork: UILabel!
    @IBOutlet weak var carWasherButton: UIButton!
    @IBOutlet weak var dishWasherButton: UIButton!
    @IBOutlet weak var postmanButton: UIButton!
    @IBOutlet weak var securityButton: UIButton!
    @IBOutlet weak var consultantButton: UIButton!
    @IBOutlet weak var juniorDeveloperButton: UIButton!
    @IBOutlet weak var systemAdministratorButton: UIButton!
    @IBOutlet weak var gameDeveloperButton: UIButton!
    @IBAction func sleepPointsButtonActionWork(_ sender: Any) {
        sleepPointsWork = sleepPointsWork + 57
        smilePointsWork = smilePointsWork + 3
        eatPointsWork = eatPointsWork - 23
        if lastChanceWork > 0 {
            lastChanceWork = lastChanceWork - 1
        }
        lifeSetupWork()
    }
    
    @IBAction func carWasherButtonAction(_ sender: Any) {
        let edge = 0
        if mainVCMasterPoints >= edge {
            work(salary: 114, masterPoints: 7)
            rubWork = rubWork + 114
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 8
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 6
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 6
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 4
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 3
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 1
                                } else {
                                    sleepPointsWork = sleepPointsWork - 8
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 3
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 3
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 2
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 2
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 2
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 1
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 1
                                    } else {
                                        smilePointsWork = smilePointsWork - 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 1
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 5
                } else {
                    eatPointsWork = eatPointsWork - 11
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func dishWasherButtonAction(_ sender: Any) {
        let edge = 150
        if mainVCMasterPoints >= edge {
            work(salary: 267, masterPoints: 15)
            rubWork = rubWork + 267
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 9
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 7
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 7
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 5
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 3
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 1
                                } else {
                                    sleepPointsWork = sleepPointsWork - 9
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 3
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 3
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 2
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 2
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 2
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 1
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 1
                                    } else {
                                        smilePointsWork = smilePointsWork - 6
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 1
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 6
                } else {
                    eatPointsWork = eatPointsWork - 13
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func postmanButtonAction(_ sender: Any) {
        let edge = 500
        if mainVCMasterPoints >= edge {
            work(salary: 593, masterPoints: 23)
            rubWork = rubWork + 593
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 10
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 8
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 8
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 5
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 3
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 1
                                } else {
                                    sleepPointsWork = sleepPointsWork - 11
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 3
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 3
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 2
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 2
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 2
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 1
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 1
                                    } else {
                                        smilePointsWork = smilePointsWork - 6
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 2
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 8
                } else {
                    eatPointsWork = eatPointsWork - 16
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func securityButtonAction(_ sender: Any) {
        let edge = 1300
        if mainVCMasterPoints >= edge {
            work(salary: 903, masterPoints: 57)
            rubWork = rubWork + 903
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 13
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 11
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 9
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 6
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 3
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 1
                                } else {
                                    sleepPointsWork = sleepPointsWork - 15
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 6
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 5
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 5
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 4
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 3
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 2
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 1
                                    } else {
                                        smilePointsWork = smilePointsWork - 9
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 2
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 8
                } else {
                    eatPointsWork = eatPointsWork - 16
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func consultantButtonAction(_ sender: Any) {
        let edge = 3500
        if mainVCMasterPoints >= edge {
            work(salary: 1347, masterPoints: 132)
            rubWork = rubWork + 1347
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 19
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 13
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 9
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 6
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 4
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 2
                                } else {
                                    sleepPointsWork = sleepPointsWork - 20
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 13
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 11
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 9
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 7
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 5
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 3
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 2
                                    } else {
                                        smilePointsWork = smilePointsWork - 17
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 2
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 11
                } else {
                    eatPointsWork = eatPointsWork - 23
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func juniorDeveloperButtonAction(_ sender: Any) {
        let edge = 25000
        if mainVCMasterPoints >= edge {
            work(salary: 1817, masterPoints: 568)
            rubWork = rubWork + 1817
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 30
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 23
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 18
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 9
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 6
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 3
                                } else {
                                    sleepPointsWork = sleepPointsWork - 32
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 13
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 11
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 9
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 7
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 5
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 3
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 2
                                    } else {
                                        smilePointsWork = smilePointsWork - 17
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 3
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 15
                } else {
                    eatPointsWork = eatPointsWork - 30
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func systemAdministartorButtonAction(_ sender: Any) {
        let edge = 250000
        if mainVCMasterPoints >= edge {
            work(salary: 3658, masterPoints: 1023)
            rubWork = rubWork + 3658
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 33
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 29
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 25
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 12
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 8
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 4
                                } else {
                                    sleepPointsWork = sleepPointsWork - 35
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 11
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 9
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 8
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 6
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 5
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 3
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 2
                                    } else {
                                        smilePointsWork = smilePointsWork - 15
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 4
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 17
                } else {
                    eatPointsWork = eatPointsWork - 35
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func gameDeveloperButtonAction(_ sender: Any) {
        let edge = 1500000
        if mainVCMasterPoints >= edge {
            work(salary: 5175, masterPoints: 3749)
            rubWork = rubWork + 5175
            if realty == 1 {
                sleepPointsWork = sleepPointsWork - 32
            } else {
                if realty == 2 {
                    sleepPointsWork = sleepPointsWork - 27
                } else {
                    if realty == 3 {
                        sleepPointsWork = sleepPointsWork - 23
                    } else {
                        if realty == 4 {
                            sleepPointsWork = sleepPointsWork - 12
                        } else {
                            if realty == 5 {
                                sleepPointsWork = sleepPointsWork - 8
                            } else {
                                if realty == 6 {
                                    sleepPointsWork = sleepPointsWork - 4
                                } else {
                                    sleepPointsWork = sleepPointsWork - 40
                                }
                            }
                        }
                    }
                }
            }
            if transport == 1 {
                smilePointsWork = smilePointsWork - 20
            } else {
                if transport == 2 {
                    smilePointsWork = smilePointsWork - 15
                } else {
                    if transport == 3 {
                        smilePointsWork = smilePointsWork - 12
                    } else {
                        if transport == 4 {
                            smilePointsWork = smilePointsWork - 9
                        } else {
                            if transport == 5 {
                                smilePointsWork = smilePointsWork - 7
                            } else {
                                if transport == 6 {
                                    smilePointsWork = smilePointsWork - 5
                                } else {
                                    if transport == 7 {
                                        smilePointsWork = smilePointsWork - 2
                                    } else {
                                        smilePointsWork = smilePointsWork - 24
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if eat3000Work == 1 {
                eatPointsWork = eatPointsWork - 4
            } else {
                if cookerWork == 1 {
                    eatPointsWork = eatPointsWork - 18
                } else {
                    eatPointsWork = eatPointsWork - 36
                }
            }
            if lastChanceWork > 0 {
                lastChanceWork = lastChanceWork - 1
            }
            lifeSetupWork()
            checkRent()
        } else {
            deniedWork(edge: edge)
        }
    }
    
    @IBAction func profileButtonActionWork(_ sender: Any) {
        delegate?.lifeActionWork(eat: eatPointsWork, smile: smilePointsWork, sleep: sleepPointsWork)
        delegate?.rentActionWork(roomRent: checkRoomRentWork, flatRent: checkFlatRentWork, checkRealty: checkRealtyWork)
        delegate?.rubChangeWork(rubWork: rubWork)
        delegate?.loseGameWork(lose: checkLoseGameWork, chance: lastChanceWork)
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
        eatPointsLabelWork.text = String(eatPointsWork)
        smilePointsLabelWork.text = String(smilePointsWork)
        sleepPointsLabelWork.text = String(sleepPointsWork)
        adChance = Int.random(in:1..<4)
        if adChance == 1 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
        checkWorkAv()
    }
    
    func work(salary: Int, masterPoints: Int) {
        delegate?.workDone(salary: salary, masterPoints: masterPoints)
        mainVCMasterPoints = mainVCMasterPoints + masterPoints
        checkWorkAv()
    }
    
    private func checkWorkAv() {
        if mainVCMasterPoints >= 1500000 {
            check = check7
            checkWork(check: check)
        } else {
            if mainVCMasterPoints >= 250000 {
                check = check6
                checkWork(check: check)
            } else {
                if mainVCMasterPoints >= 25000 {
                    check = check5
                    checkWork(check: check)
                } else {
                    if mainVCMasterPoints >= 3500 {
                        check = check4
                        checkWork(check: check)
                    } else {
                        if mainVCMasterPoints >= 1300 {
                            check = check3
                            checkWork(check: check)
                        } else {
                            if mainVCMasterPoints >= 500 {
                                check = check2
                                checkWork(check: check)
                            } else {
                                if mainVCMasterPoints >= 150 {
                                    check = check1
                                    checkWork(check: check)
                                } else {
                                    if mainVCMasterPoints >= 1 {
                                        delegate?.yourProfession(profession: carWasherButton.titleLabel!.text!, check1: 1, check2: 2, check3: 3, check4: 4, check5: 5, check6: 6, check7: 7)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deniedWork(edge: Int) {
        if locale.hasPrefix("ru") {
            let alert = UIAlertController(title: "Внимание", message: "Для данной работы вам не хватает \(edge - mainVCMasterPoints) очков мастерства. Продолжайте работать!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title:"Смириться", style: UIAlertAction.Style.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
                let alert = UIAlertController(title: "Attention", message: "You don't have \(edge - mainVCMasterPoints) master points for this work. Let's work!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkWork(check: Int) {
        if locale.hasPrefix("ru") {
            if check == 1 {
                check1 = 0
                let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать мойщиком посуды!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                delegate?.yourProfession(profession: dishWasherButton.titleLabel!.text!, check1: 0, check2: 2, check3: 3, check4: 4, check5: 5, check6: 6, check7: 7)
                self.present(alert, animated: true, completion: nil)
            } else {
                if check == 2 {
                    check2 = 0
                    let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать почтальоном!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    delegate?.yourProfession(profession: postmanButton.titleLabel!.text!, check1: 0, check2: 0, check3: 3, check4: 4, check5: 5, check6: 6, check7: 7)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if check == 3 {
                        check3 = 0
                        let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать охранником!", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        delegate?.yourProfession(profession: securityButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 4, check5: 5, check6: 6, check7: 7)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        if check == 4 {
                            check4 = 0
                            let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать консультантом в магазине!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            delegate?.yourProfession(profession: consultantButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 5, check6: 6, check7: 7)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            if check == 5 {
                                check5 = 0
                                let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать младшим разработчиком!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                delegate?.yourProfession(profession: juniorDeveloperButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 6, check7: 7)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                if check == 6 {
                                    check6 = 0
                                    let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать системным администратором!", preferredStyle: UIAlertController.Style.alert)
                                    
                                    alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                                        alert.dismiss(animated: true, completion: nil)
                                    }))
                                    delegate?.yourProfession(profession: systemAdministratorButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 0, check7: 7)
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    if check == 7 {
                                        check7 = 0
                                        let alert = UIAlertController(title: "Вам стала доступна новая работа!", message: "У вас хватает очков для новой работы. Теперь вы можете работать разработчиком игр!", preferredStyle: UIAlertController.Style.alert)
                                        
                                        alert.addAction(UIAlertAction(title:"Я так долго этого ждал!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                                            alert.dismiss(animated: true, completion: nil)
                                        }))
                                        delegate?.yourProfession(profession: gameDeveloperButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 0, check7: 0)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
                if check == 1 {
                    check1 = 0
                    let alert = UIAlertController(title: "You've got new work!", message: "You can be dish washer now!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    delegate?.yourProfession(profession: dishWasherButton.titleLabel!.text!, check1: 0, check2: 2, check3: 3, check4: 4, check5: 5, check6: 6, check7: 7)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if check == 2 {
                        check2 = 0
                        let alert = UIAlertController(title: "You've got new work!", message: "You can be postman now!", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        delegate?.yourProfession(profession: postmanButton.titleLabel!.text!, check1: 0, check2: 0, check3: 3, check4: 4, check5: 5, check6: 6, check7: 7)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        if check == 3 {
                            check3 = 0
                            let alert = UIAlertController(title: "You've got new work!", message: "You can be security now!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            delegate?.yourProfession(profession: securityButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 4, check5: 5, check6: 6, check7: 7)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            if check == 4 {
                                check4 = 0
                                let alert = UIAlertController(title: "You've got new work!", message: "You can be shop assistent now!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                delegate?.yourProfession(profession: consultantButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 5, check6: 6, check7: 7)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                if check == 5 {
                                    check5 = 0
                                    let alert = UIAlertController(title: "You've got new work!", message: "You can be junior developer now!", preferredStyle: UIAlertController.Style.alert)
                                    
                                    alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                                        alert.dismiss(animated: true, completion: nil)
                                    }))
                                    delegate?.yourProfession(profession: juniorDeveloperButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 6, check7: 7)
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    if check == 6 {
                                        check6 = 0
                                        let alert = UIAlertController(title: "You've got new work!", message: "You can be system administrator now!", preferredStyle: UIAlertController.Style.alert)
                                        
                                        alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                                            alert.dismiss(animated: true, completion: nil)
                                        }))
                                        delegate?.yourProfession(profession: systemAdministratorButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 0, check7: 7)
                                        self.present(alert, animated: true, completion: nil)
                                    } else {
                                        if check == 7 {
                                            check7 = 0
                                            let alert = UIAlertController(title: "You've got new work!", message: "You can be game developer now!", preferredStyle: UIAlertController.Style.alert)
                                            
                                            alert.addAction(UIAlertAction(title:"That's cool!", style: UIAlertAction.Style.default, handler:{ (action) in
                                                alert.dismiss(animated: true, completion: nil)
                                            }))
                                            delegate?.yourProfession(profession: gameDeveloperButton.titleLabel!.text!, check1: 0, check2: 0, check3: 0, check4: 0, check5: 0, check6: 0, check7: 0)
                                            self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func checkRent() {
        if checkRealtyWork == 2 {
            if checkRoomRentWork > 0 {
                checkRoomRentWork = checkRoomRentWork - 1
            } else {
                if checkRoomRentWork == 0 {
                    if rubWork >= 7000 {
                        rubWork = rubWork - 7000
                        checkRoomRentWork = checkRoomRentWork + 30
                        rentSuccess()
                    } else {
                        checkRealtyWork = 0
                        noHomeWork()
                    }
                }
            }
        }
        if checkRealtyWork == 3 {
            if checkFlatRentWork > 0 {
                checkFlatRentWork = checkFlatRentWork - 1
            } else {
                if checkFlatRentWork == 0 {
                    if rubWork >= 25000 {
                        rubWork = rubWork - 25000
                        checkFlatRentWork = checkFlatRentWork + 30
                        rentSuccess()
                    } else {
                        checkRealtyWork = 0
                        noHomeWork()
                    }
                }
            }
        }
    }
    
    private func noHomeWork() {
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
    
    private func rentSuccess() {
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
    
    private func lifeSetupWork() {
        if sleepPointsWork > 100 {
            sleepPointsWork = 100
        } else {
            if sleepPointsWork <= 0 {
                sleepPointsWork = 0
                if lastChanceWork < 0 {
                    lastChanceWork = 3
                }
            }
        }
        if smilePointsWork > 100 {
            smilePointsWork = 100
        } else {
            if smilePointsWork <= 0 {
                smilePointsWork = 0
                if lastChanceWork < 0 {
                    lastChanceWork = 3
                }
            }
        }
        if eatPointsWork > 100 {
            eatPointsWork = 100
        } else {
            if eatPointsWork <= 0 {
                eatPointsWork = 0
                if lastChanceWork < 0 {
                    lastChanceWork = 3
                }
            }
        }
        eatPointsLabelWork.text = String(eatPointsWork)
        smilePointsLabelWork.text = String(smilePointsWork)
        sleepPointsLabelWork.text = String(sleepPointsWork)
        loseGameWork()
    }
    
    private func loseGameWork() {
        if locale.hasPrefix("ru") {
            if lastChanceWork == 0 {
                let alert = UIAlertController(title: "Внимание!!!", message: "Вы проиграли!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Начать заново", style: UIAlertAction.Style.default, handler:{ (action) in
                    self.checkLoseGameWork = 1
                    self.delegate?.loseGameWork(lose: self.checkLoseGameWork, chance: self.lastChanceWork)
                    self.delegate?.lifeActionWork(eat: self.eatPointsWork, smile: self.smilePointsWork, sleep: self.sleepPointsWork)
                    self.dismiss(animated: true, completion: nil)
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                if lastChanceWork == 3 {
                    let alert = UIAlertController(title: "Внимание!!!", message: "У вас есть \(lastChanceWork!) шага для того чтобы исправить ситуацию или вы проиграете! Потратьте их с пользой!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Я справлюсь!!!", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
                if lastChanceWork == 0 {
                    let alert = UIAlertController(title: "Attention!!!", message: "You lost!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Start new game", style: UIAlertAction.Style.default, handler:{ (action) in
                        self.checkLoseGameWork = 1
                        self.delegate?.loseGameWork(lose: self.checkLoseGameWork, chance: self.lastChanceWork)
                        self.delegate?.lifeActionWork(eat: self.eatPointsWork, smile: self.smilePointsWork, sleep: self.sleepPointsWork)
                        self.dismiss(animated: true, completion: nil)
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if lastChanceWork == 3 {
                        let alert = UIAlertController(title: "Attention!!!", message: "You have \(lastChanceWork!) steps before you lose the game!", preferredStyle: UIAlertController.Style.alert)
                        
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
