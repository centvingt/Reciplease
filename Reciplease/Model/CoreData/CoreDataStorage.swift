//
//  CoreDataStorage.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 21/07/2021.
//

import CoreData

protocol CoreDataStorageProtocol {
    func saveRecipe(_ recipe: Recipe)
    func getAllRecipes() -> [Recipe]?
    func getRecipe(with url: String) -> Recipe?
    func deleteRecipe(_ recipe: Recipe)
}

enum StorageType {
    case persistent, inMemory
}

class CoreDataStorage: CoreDataStorageProtocol {
    private let persistentContainer: NSPersistentContainer
    
    init(_ storageType: StorageType = .persistent) {
        self.persistentContainer = NSPersistentContainer(name: "Reciplease")
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        
        self.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("CoreDataStore ~> saveContext ~> Error ~>", error.localizedDescription)
            }
        } else {
            print("CoreDataStore ~> saveContext ~> No change to save")
        }
    }
    
    func saveRecipe(_ recipe: Recipe) {
        var cdRecipe: CDRecipe
        
        if let _ = getCDRecipe(with: recipe.url) {
            return
        }
        
//        cdRecipe = CDRecipe(context: context)
        cdRecipe = NSEntityDescription.insertNewObject(forEntityName: "CDRecipe", into: context) as! CDRecipe
        
        cdRecipe.calories = recipe.calories
        cdRecipe.image = recipe.image
        cdRecipe.ingredientLines = recipe.ingredientLines
        cdRecipe.label = recipe.label
        cdRecipe.totalTime = recipe.totalTime
        cdRecipe.url = recipe.url
        
        saveContext()
    }
    
    func getAllRecipes() -> [Recipe]? {
            let request: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
            guard
                let cdRecipes = try? context.fetch(request),
                !cdRecipes.isEmpty
            else { return nil }
        return cdRecipes.compactMap { cdRecipe in
            guard let recipe = Recipe(from: cdRecipe) else { return nil }
            return recipe
        }
    }
    
    func getRecipe(with url: String) -> Recipe? {
        guard let cdRecipe = getCDRecipe(with: url) else {
            return nil
        }
        
        return Recipe(from: cdRecipe)
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        let fetchRequest: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", recipe.url)
        fetchRequest.fetchLimit = 1
        
        guard let fetchResult = try? context.fetch(fetchRequest),
              let cdRecipe = fetchResult.first else {
            return
        }
        
        context.delete(cdRecipe)
    }
    
    private func getCDRecipe(with url: String) -> CDRecipe? {
        let fetchRequest: NSFetchRequest<CDRecipe> = CDRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        fetchRequest.fetchLimit = 1
        
        guard let fetchResult = try? context.fetch(fetchRequest),
              let cdRecipe = fetchResult.first else {
            return nil
        }
        
        return cdRecipe
    }
}

extension Recipe {
    init?(from cdRecipe: CDRecipe) {
        guard let label = cdRecipe.label,
              let image = cdRecipe.image,
              let url = cdRecipe.url,
              let ingredientLines = cdRecipe.ingredientLines
        else {
            return nil
        }
        
        self.calories = cdRecipe.calories
        self.totalTime = cdRecipe.totalTime
        self.label = label
        self.image = image
        self.url = url
        self.ingredientLines = ingredientLines
    }
}
