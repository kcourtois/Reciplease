//
//  RecipeStorageManager.swift
//  Reciplease
//
//  Created by Kévin Courtois on 29/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecipeStorageManager {
    let persistentContainer: NSPersistentContainer!

    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()

    // MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }

    // MARK: CRUD
    func insertFavorite(recipe: Recipe) -> FavoriteRecipe? {

        guard let favorite = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe",
                                                               into: backgroundContext) as? FavoriteRecipe else {
            return nil
        }

        favorite.name = recipe.name
        favorite.image = recipe.image.pngData()
        favorite.ingredients = recipe.ingredients
        favorite.time = Int16(recipe.time)
        favorite.servings = Int16(recipe.servings)
        favorite.source = recipe.source

        return favorite
    }

    func fetchAll() -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [FavoriteRecipe]()
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }

    }

    //Compare given recipe source to favorites, and return same favorite recipe if exists
    func fetchFavorite(recipe: Recipe) -> FavoriteRecipe? {
        var favorite: FavoriteRecipe?
        let favs = fetchAll()
        for (index, fav) in favs.enumerated() where recipe.source == fav.source {
            favorite = favs[index]
        }
        return favorite
    }

}
