//
//  CoreDataManagerTests.swift
//  RecipleaseTest
//
//  Created by Déborah Suon on 21/08/2022.
//

import XCTest
@testable import Reciplease


final class CoreDataManagerTests: XCTestCase {
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAddRecipeMethod_ShouldBeCorrectlySaved() {
        coreDataManager.createTask(title: "My Recipe", ingredients: "Ingredients", image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html", time: 0)
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "My Recipe")
        XCTAssertTrue(coreDataManager.recipes[0].ingredients == "Ingredients")
        XCTAssertTrue(coreDataManager.recipes[0].time == 0)
        XCTAssertTrue(coreDataManager.recipes[0].image == "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg")
        XCTAssertTrue(coreDataManager.recipes[0].url == "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavorite = coreDataManager.checkIfRecipeIsFavorite(title: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(coreDataManager.recipes.count > 0)
        XCTAssertTrue(recipeIsFavorite)
    }

    func testDeleteRecipeMethod_ShouldBeCorrectlyDeleted() {
        coreDataManager.createTask(title: "My Recipe One", ingredients: "Ingredients", image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html", time: 0)
        coreDataManager.createTask(title: "My Recipe Two", ingredients: "Ingredients", image: "https://www.edamam.com/web-img/ef8/ef85302a1ac4ac3a94f22ca566ddeea2.jpg", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa", time: 0)
        
        coreDataManager.deleteRecipe(recipeTitle: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavoriteOne = coreDataManager.checkIfRecipeIsFavorite(title: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertFalse(recipeIsFavoriteOne)
        
        let recipeIsFavoriteTwo = coreDataManager.checkIfRecipeIsFavorite(title: "My Recipe Two", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa")
        XCTAssertTrue(recipeIsFavoriteTwo)
        XCTAssertFalse(coreDataManager.recipes.isEmpty)
    }
}
