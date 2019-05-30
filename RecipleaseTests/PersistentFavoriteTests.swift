//
//  File.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 29/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest
import CoreData

@testable import Reciplease

class PersistentFavoriteTests: XCTestCase {

    var sut: RecipeStorageManager!

    override func setUp() {
        super.setUp()

        initStubs()

        sut = RecipeStorageManager(container: mockPersistantContainer)

        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)),
                                               name: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil)

    }

    override func tearDown() {
         // swiftlint:disable:next notification_center_detachment
        NotificationCenter.default.removeObserver(self)

        flushData()

        super.tearDown()
    }

    func test_create_favorite() {

        //Given a recipe
        let recipe = Recipe(name: "Cheesecake", image: UIImage(), time: 0, servings: 2,
                            ingredients: ["cheese", "cake"], source: "https://stackoverflow.com/")

        //When add to favorites
        let favorite = sut.insertFavorite(recipe: recipe)

        //Assert: return favoriterecipe
        XCTAssertNotNil( favorite )

    }

    func test_fetch_all_favorites() {

        //Given a storage

        //When fetch
        let results = sut.fetchAll()

        //Assert return 5 recipes
        XCTAssertEqual(results.count, 5)
    }

    func test_remove_favorite() {

        //Given a item in persistent store
        let items = sut.fetchAll()
        let item = items[0]

        let numberOfItems = items.count

        //When remove a item
        sut.remove(objectID: item.objectID)
        sut.save()

        //Assert number of item - 1
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems-1)

    }

    func test_save() {

        //Given a recipe
        let recipe = Recipe(name: "Cheesecake", image: UIImage(), time: 0, servings: 2,
                            ingredients: ["cheese", "cake"], source: "https://stackoverflow.com/")

        _ = expectationForSaveNotification()

        _ = sut.insertFavorite(recipe: recipe)

        //When save

        //Assert save is called via notification (wait)
        expectation(forNotification: Notification.Name.NSManagedObjectContextDidSave, object: nil, handler: nil)

        sut.save()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    // MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification) -> Void)?

    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (_) in
            expect.fulfill()
        }
        return expect
    }

    func waitForSavedNotification(completeHandler: @escaping ((Notification) -> Void) ) {
        saveNotificationCompleteHandler = completeHandler
    }

    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }
}

// MARK: Creat some fakes
extension PersistentFavoriteTests {

    func initStubs() {

        func insertFavorite(recipe: Recipe) -> FavoriteRecipe? {

            let favorite = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe",
                                                               into: mockPersistantContainer.viewContext)

            favorite.setValue(recipe.name, forKey: "name")
            favorite.setValue(recipe.image.pngData(), forKey: "image")
            favorite.setValue(recipe.ingredients, forKey: "ingredients")
            favorite.setValue(Int16(recipe.time), forKey: "time")
            favorite.setValue(Int16(recipe.servings), forKey: "servings")
            favorite.setValue(recipe.source, forKey: "source")

            return favorite as? FavoriteRecipe
        }

        for index in 0..<5 {
            let recipe = Recipe(name: "Cheesecake\(index)", image: UIImage(), time: 0, servings: 2,
                                ingredients: ["cheese", "cake"], source: "https://stackoverflow.com/")
            _ = insertFavorite(recipe: recipe)
        }

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }

    }

    func flushData() {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        // swiftlint:disable:next force_try
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        // swiftlint:disable:next force_try
        try! mockPersistantContainer.viewContext.save()

    }

    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        // swiftlint:disable:next force_try
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }

}
