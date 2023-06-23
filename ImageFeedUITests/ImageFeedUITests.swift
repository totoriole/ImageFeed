//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Toto Tsipun on 19.06.2023.
//

import XCTest

//Запускаем тест на авторизацию и работу с лентой отдельно!!!
final class ImageFeedUITests: XCTestCase {
    
    private let app = XCUIApplication() // переменная приложения
    
    override func setUpWithError() throws {
        continueAfterFailure = false // настройка выполнения тестов, которая прекратит выполнения тестов, если в тесте что-то пошло не так.
        
        app.launch() // запускаем приложение перед каждым тестом
    }
   
//Запускаем тест на авторизацию и работу с лентой отдельно!!!
    func testAuth() throws {
        // тестируем сценарий авторизации
        sleep(5)
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["AuthenticateWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 25))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 20))
        loginTextField.tap()
        loginTextField.typeText("")
        loginTextField.swipeUp()
        //webView.swipeUp()
        
        let passwordTextFiled = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextFiled.waitForExistence(timeout: 20))
        passwordTextFiled.tap()
        passwordTextFiled.typeText("")
        webView.swipeUp()
        sleep(5)
        
        print(app.debugDescription)
        
        let loginButton = webView.descendants(matching: .button).element
        loginButton.tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 15))
    }
    
//Запускаем тест на авторизацию и работу с лентой отдельно!!!
    func testFeed() throws {
        // тестируем сценарий ленты
        let tablesQuery = app.tables
        sleep(15)
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        sleep(5)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        sleep(15)
        cell.waitForExistence(timeout: 20)
        cellToLike.buttons["likeButton"].tap()
        sleep(15)
        cell.waitForExistence(timeout: 20)
        cellToLike.buttons["likeButton"].tap()
        
        sleep(20)
        
        cellToLike.tap()
        sleep(20)
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["SingleImageBackButton"]
        navBackButtonWhiteButton.tap()
    }
    
    func testProfile() throws {
        // тестируем сценарий профиля
        sleep(10)
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        let nameLabel = app.staticTexts["ProfileNameLabel"]
        let loginNameLabel = app.staticTexts["ProfileLoginNameLabel"]
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(loginNameLabel.exists)
        
        let logOutButton  = app.buttons["ProfileExitButton"]
        logOutButton.tap()
        
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
