//
//  KNShouXiangUITests.swift
//  KNShouXiangUITests
//
//  Created by kennykhuang on 2023/7/30.
//

import XCTest

final class KNShouXiangUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testMainTabsExposeCorePalmistryFlow() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-AppleLanguages", "(zh-Hans)", "-AppleLocale", "zh_Hans_CN"]
        app.launch()

        XCTAssertTrue(app.staticTexts["手相图鉴"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.tabBars.buttons["图鉴"].exists)
        XCTAssertTrue(app.tabBars.buttons["图库"].exists)
        XCTAssertTrue(app.tabBars.buttons["学径"].exists)
        XCTAssertTrue(app.tabBars.buttons["我的"].exists)

        let linesCategory = app.buttons["atlas.category.lines"]
        XCTAssertTrue(linesCategory.waitForExistence(timeout: 4))
        linesCategory.tap()
        XCTAssertTrue(app.navigationBars["六大线纹"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["先选主线，再看总图"].waitForExistence(timeout: 4))

        let lifeLine = app.buttons["atlas.line.life"]
        XCTAssertTrue(lifeLine.waitForExistence(timeout: 4))
        lifeLine.tap()
        XCTAssertTrue(app.navigationBars["生命线图谱"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["52 张图例 · 图注式浏览"].waitForExistence(timeout: 4))

        let eighthExample = app.buttons["gallery.featured.life-8"]
        XCTAssertTrue(eighthExample.waitForExistence(timeout: 4))
        eighthExample.tap()
        XCTAssertTrue(app.navigationBars["生命线 · 第 8 种"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["点图放大"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["深度解读已锁定"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.buttons["开通会员解锁全部"].waitForExistence(timeout: 4))
        app.navigationBars.buttons.element(boundBy: 0).tap()

        app.tabBars.buttons["图库"].tap()
        XCTAssertTrue(app.staticTexts["全部图库"].waitForExistence(timeout: 4))

        app.tabBars.buttons["学径"].tap()
        XCTAssertTrue(app.staticTexts["七日识掌"].waitForExistence(timeout: 4))
        let dayOne = app.buttons["learn.day.1"]
        XCTAssertTrue(dayOne.waitForExistence(timeout: 4))
        dayOne.tap()
        XCTAssertTrue(app.navigationBars["第 1 日 · 三线定位"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.staticTexts["配套图例"].waitForExistence(timeout: 4))
    }

    func testJapaneseLocalizationLoadsHomeScreen() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-AppleLanguages", "(ja)", "-AppleLocale", "ja_JP"]
        app.launch()

        XCTAssertTrue(app.staticTexts["手相図鑑"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.tabBars.buttons["図鑑"].exists)
        XCTAssertTrue(app.tabBars.buttons["画像集"].exists)
        XCTAssertTrue(app.tabBars.buttons["学習路"].exists)
        XCTAssertTrue(app.tabBars.buttons["マイ"].exists)
    }
}
