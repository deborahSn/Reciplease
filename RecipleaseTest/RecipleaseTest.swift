//
//  RecipleaseTest.swift
//  RecipleaseTest
//
//  Created by Déborah Suon on 07/06/2022.
//

import XCTest
@testable import Reciplease

class RecipleaseTest: XCTestCase {

    var ingredientsList: [String] = ["tomato", "milk"]
    
    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil)
        let recipleaseSessionFake = FakeRecipleaseSession(fakeResponse: fakeResponse)
        let recipleaseService = RecipleaseService(recipeSession: recipleaseSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipleaseService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData)
        let recipeSessionFake = FakeRecipleaseSession(fakeResponse: fakeResponse)
        let recipeService = RecipleaseService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndDataNil() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil)
        let recipeSessionFake = FakeRecipleaseSession(fakeResponse: fakeResponse)
        let recipeService = RecipleaseService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData)
        let recipeSessionFake = FakeRecipleaseSession(fakeResponse: fakeResponse)
        let recipeService = RecipleaseService(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesSearch)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

}
