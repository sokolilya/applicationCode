//
//  DollarsShop.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 01/03/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class DollarsShop: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @IBOutlet weak var d1000: UILabel!
    @IBOutlet weak var d5000: UILabel!
    @IBOutlet weak var d15000: UILabel!
    @IBOutlet weak var d50000: UILabel!
    @IBOutlet weak var d100000: UILabel!
    @IBOutlet weak var d250000: UILabel!
    @IBOutlet weak var d500000: UILabel!
    
    var delegate: DollarsShopDelegate?
    var dollar : Int! = 0
    let COINS1000_PRODUCT_ID = "com.gameSimulator.dollars1"
    let COINS5000_PRODUCT_ID = "com.gameSimulator.dollars2"
    let COINS15000_PRODUCT_ID = "com.gameSimulator.dollars3"
    let COINS50000_PRODUCT_ID = "com.gameSimulator.dollars4"
    let COINS100000_PRODUCT_ID = "com.gameSimulator.dollars5"
    let COINS250000_PRODUCT_ID = "com.gameSimulator.dollars6"
    let COINS500000_PRODUCT_ID = "com.gameSimulator.dollars7"
    
    let locale = NSLocale.preferredLanguages.first!
    
    var productID = ""
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    var coins = UserDefaults.standard.integer(forKey: "coins")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAvailableProducts()
    }
    
    @IBAction func backAction(_ sender: Any) {
        delegate?.purchase(dollars: dollar)
        dismiss(animated: true)
    }
    @IBAction func buy1000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[0])
    }
    @IBAction func buy5000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[1])
    }
    @IBAction func buy15000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[2])
    }
    @IBAction func buy50000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[3])
    }
    @IBAction func buy100000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[4])
    }
    @IBAction func buy250000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[5])
    }
    @IBAction func buy500000DollarsAction(_ sender: Any) {
        purchaseMyProduct(product: iapProducts[6])
    }
    
    func fetchAvailableProducts()  {
        
        let productIdentifiers = NSSet(objects:
            COINS1000_PRODUCT_ID,
            COINS5000_PRODUCT_ID,
            COINS15000_PRODUCT_ID,
            COINS50000_PRODUCT_ID,
            COINS100000_PRODUCT_ID,
            COINS250000_PRODUCT_ID,
            COINS500000_PRODUCT_ID
        )
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            iapProducts = response.products
            
            let numberFormatter = NumberFormatter()
            numberFormatter.formatterBehavior = .behavior10_4
            numberFormatter.numberStyle = .currency
            
            let firstProduct = response.products[0] as SKProduct
            
            numberFormatter.locale = firstProduct.priceLocale
            let price1Str = numberFormatter.string(from: firstProduct.price)
            
            d1000.text = price1Str!
            
            let secondProduct = response.products[1] as SKProduct
            
            numberFormatter.locale = secondProduct.priceLocale
            let price2Str = numberFormatter.string(from: secondProduct.price)
            
            d5000.text = price2Str!
            
            let thirdProduct = response.products[2] as SKProduct
            
            numberFormatter.locale = thirdProduct.priceLocale
            let price3Str = numberFormatter.string(from: thirdProduct.price)
            
            d15000.text = price3Str!
            
            let forthProduct = response.products[3] as SKProduct
            
            numberFormatter.locale = forthProduct.priceLocale
            let price4Str = numberFormatter.string(from: forthProduct.price)
            
            d50000.text = price4Str!
            
            let fifthProduct = response.products[4] as SKProduct
            
            numberFormatter.locale = fifthProduct.priceLocale
            let price5Str = numberFormatter.string(from: fifthProduct.price)
            
            d100000.text = price5Str!
            
            let sixthProduct = response.products[5] as SKProduct
            
            numberFormatter.locale = sixthProduct.priceLocale
            let price6Str = numberFormatter.string(from: sixthProduct.price)
            
            d250000.text = price6Str!
            
            let seventhProduct = response.products[6] as SKProduct
            
            numberFormatter.locale = seventhProduct.priceLocale
            let price7Str = numberFormatter.string(from: seventhProduct.price)
            
            d500000.text = price7Str!
        }
    }
    
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func purchaseMyProduct(product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            if locale.hasPrefix("ru") {
                let alert = UIAlertController(title: "Уведомление", message: "Отказано в проведении транзакции!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                    let alert = UIAlertController(title: "Notification", message: "Your transaction has been denied!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    if locale.hasPrefix("ru") {
                        if productID == COINS1000_PRODUCT_ID {
                            
                            coins += 1000
                            dollar += 1000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 1000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS5000_PRODUCT_ID {
                            
                            coins += 5000
                            dollar += 5000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 5000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS15000_PRODUCT_ID {
                            
                            coins += 15000
                            dollar += 15000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 15000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS50000_PRODUCT_ID {
                            
                            coins += 50000
                            dollar += 50000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 50000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS100000_PRODUCT_ID {
                            
                            coins += 100000
                            dollar += 100000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 100000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS250000_PRODUCT_ID {
                            
                            coins += 250000
                            dollar += 250000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 250000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else if productID == COINS500000_PRODUCT_ID {
                            
                            coins += 500000
                            dollar += 500000
                            UserDefaults.standard.set(coins, forKey: "coins")
                            
                            let alert = UIAlertController(title: "Уведомление", message: "Вы успешно приобрели 500000$!", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title:"Окей", style: UIAlertAction.Style.default, handler:{ (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                            if productID == COINS1000_PRODUCT_ID {
                                
                                coins += 1000
                                dollar += 1000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 1000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS5000_PRODUCT_ID {
                                
                                coins += 5000
                                dollar += 5000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 5000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS15000_PRODUCT_ID {
                                
                                coins += 15000
                                dollar += 15000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 15000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS50000_PRODUCT_ID {
                                
                                coins += 50000
                                dollar += 50000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 50000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS100000_PRODUCT_ID {
                                
                                coins += 100000
                                dollar += 100000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 100000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS250000_PRODUCT_ID {
                                
                                coins += 250000
                                dollar += 250000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 250000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                            } else if productID == COINS500000_PRODUCT_ID {
                                
                                coins += 500000
                                dollar += 500000
                                UserDefaults.standard.set(coins, forKey: "coins")
                                
                                let alert = UIAlertController(title: "Notification", message: "You bought 500000$!", preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title:"Okey", style: UIAlertAction.Style.default, handler:{ (action) in
                                    alert.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                        }
                    }
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }
            }
        }
    }
    
}
