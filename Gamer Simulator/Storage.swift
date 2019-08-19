//
//  Storage.swift
//  Gamer Simulator
//
//  Created by Илья Соколов on 12/02/2019.
//  Copyright © 2019 Sokoloff Inc. All rights reserved.
//

import Foundation
import CoreData

typealias SaveCompletion = () -> Void

protocol IStorage {
    
    func appUser() throws -> AppUser?
    
    func performSave(with context: NSManagedObjectContext, completion: SaveCompletion?)
    
    func saveAppUser(allowedCards: Int, buyedGames: Int, buyedRealty: Int, buyedTransport: Int, allTech: Int, console: Int, cooker: Int, eat3000: Int, flatRent: Int, gameLose: Int, i3PC: Int, i5PC: Int, i7PC: Int, i9PC: Int, monitor: Int, notebook: Int, roomRent: Int, tech: Int, transport: Int, dollar: Int, eatPoints: Int, games: Int, lastChance: Int, letsPlays: Int, master: Int, plays: Int, popularity: Int, rub: Int, sleepPoints: Int, smilePoints: Int, visitedEvents: Int, workLevel: String)
    
}

class Storage: IStorage {
    
    var storeURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("MyStore.sqlite")
    }
    
    let dataModelName = "Model"
    let dataModelExtension = "momd"
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.dataModelName, withExtension: self.dataModelExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: nil)
        } catch {
            assert(false, "Error adding store: \(error)")
        }
        return coordinator
    }()
    
    lazy var masterContext: NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return masterContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
    }()
    
    lazy var saveContext: NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        saveContext.parent = self.mainContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    func performSave(with context: NSManagedObjectContext, completion: SaveCompletion? = nil) {
        guard context.hasChanges else {
            completion?()
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print("Context ssave error \(error)")
            }
            
            if let parentContext = context.parent {
                self.performSave(with: parentContext, completion: completion)
            } else {
                completion?()
            }
        }
    }
    
    func appUser() throws -> AppUser? {
        
        let request = NSFetchRequest<AppUser>(entityName: "AppUser")
        let users = try mainContext.fetch(request)
        
        if let user = users.first {
            return user
        }
        let user = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: mainContext)
            as! AppUser
        return user
    }
    
    func saveAppUser(allowedCards: Int, buyedGames: Int, buyedRealty: Int, buyedTransport: Int, allTech: Int, console: Int, cooker: Int, eat3000: Int, flatRent: Int, gameLose: Int, i3PC: Int, i5PC: Int, i7PC: Int, i9PC: Int, monitor: Int, notebook: Int, roomRent: Int, tech: Int, transport: Int, dollar: Int, eatPoints: Int, games: Int, lastChance: Int, letsPlays: Int, master: Int, plays: Int, popularity: Int, rub: Int, sleepPoints: Int, smilePoints: Int, visitedEvents: Int, workLevel: String) {
        saveContext.perform {
            do {
                let request = NSFetchRequest<AppUser>(entityName: "AppUser")
                let users = try self.saveContext.fetch(request)
                let user = users.first ?? (NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: self.saveContext)
                    as! AppUser)
                
                user.allowedCards = String(allowedCards)
                user.buyedGames = String(buyedGames)
                user.buyedRealty = String(buyedRealty)
                user.buyedTransport = String(buyedTransport)
                user.checkAllTech = String(allTech)
                user.checkConsole = String(console)
                user.checkCooker = String(cooker)
                user.checkEat3000 = String(eat3000)
                user.checkFlatRent = String(flatRent)
                user.checkGameLose = String(gameLose)
                user.checkI3PC = String(i3PC)
                user.checkI5PC = String(i5PC)
                user.checkI7PC = String(i7PC)
                user.checkI9PC = String(i9PC)
                user.checkMonitor = String(monitor)
                user.checkNotebook = String(notebook)
                user.checkRoomRent = String(roomRent)
                user.checkTech = String(tech)
                user.checkTransport = String(transport)
                user.dollar = String(dollar)
                user.eatPoints = String(eatPoints)
                user.games = String(games)
                user.lastChance = String(lastChance)
                user.letsPlays = String(letsPlays)
                user.master = String(master)
                user.plays = String(plays)
                user.popularity = String(popularity)
                user.rub = String(rub)
                user.sleepPoints = String(sleepPoints)
                user.smilePoints = String(smilePoints)
                user.visitedEvents = String(visitedEvents)
                user.workLevel = workLevel
                
                self.performSave(with: self.saveContext, completion: nil)
            } catch {
                print(error)
            }
        }
    }
}
