//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Déborah Suon on 08/05/2022.
//


import Foundation
import CoreData

final class CoreDataManager{
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var recipes: [RecipleaseCoreData] {
        let request: NSFetchRequest<RecipleaseCoreData> = RecipleaseCoreData.fetchRequest()
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    func createTask(title: String, ingredients: String, image: String, url: String, time: Int) {
        let recipe = RecipleaseCoreData(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.image = image
        recipe.url = url
        recipe.time = Int16(time)
        coreDataStack.saveContext()
    }
    
    func deleteAllTasks() {
        recipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func checkIfRecipeIsFavorite(title: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipleaseCoreData> = RecipleaseCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        guard let counter = try? managedObjectContext.count(for: request) else { return false }
        return counter == 0 ? false : true
    }
    func deleteRecipe(recipeTitle: String, url: String) {
        let request: NSFetchRequest<RecipleaseCoreData> = RecipleaseCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", recipeTitle)
        request.predicate = NSPredicate(format: "url == %@", url)

        if let entity = try? managedObjectContext.fetch(request) {
            entity.forEach { managedObjectContext.delete($0) }
        }
        coreDataStack.saveContext()
    }

}
