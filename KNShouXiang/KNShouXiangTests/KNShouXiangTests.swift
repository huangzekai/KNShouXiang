//
//  KNShouXiangTests.swift
//  KNShouXiangTests
//
//  Created by kennykhuang on 2023/7/30.
//

import XCTest
import UIKit
@testable import KNShouXiang

final class KNShouXiangTests: XCTestCase {
    private let requiredLocales = ["zh-Hans", "zh-Hant", "ja", "en"]
    private let requiredLocalizationKeys = [
        "app.display_name",
        "tab.atlas",
        "tab.gallery",
        "tab.path",
        "tab.mine",
        "atlas.home.title",
        "atlas.home.subtitle",
        "atlas.category.lines.title",
        "atlas.category.mounts.title",
        "atlas.category.palaces.title",
        "atlas.category.basics.title",
        "atlas.category.tutorial.title",
        "atlas.category.rhythm.title",
        "line.overview.title",
        "gallery.life.title",
        "gallery.life.subtitle",
        "detail.position",
        "detail.observation",
        "detail.traditional_reading",
        "detail.modern_reading",
        "detail.misread",
        "detail.judgement",
        "detail.action_advice",
        "detail.disclaimer",
        "favorites.title",
        "favorites.subtitle",
        "learn.day.detail.goal",
        "learn.day.detail.practice",
        "learn.day.detail.examples",
        "commerce.paywall.title",
        "commerce.paywall.monthly",
        "commerce.paywall.yearly",
        "commerce.paywall.lifetime",
        "commerce.paywall.subtitle",
        "commerce.paywall.benefits.title",
        "commerce.paywall.benefits.body",
        "commerce.paywall.monthly.subtitle",
        "commerce.paywall.yearly.subtitle",
        "commerce.paywall.lifetime.subtitle",
        "commerce.paywall.restore",
        "commerce.locked.title",
        "commerce.locked.body",
        "commerce.unlock.watch_ad",
        "commerce.unlock.subscribe",
        "mine.title",
        "mine.subtitle",
        "line.life.title",
        "line.head.title",
        "line.heart.title",
        "line.career.title",
        "line.sun.title",
        "line.marriage.title",
        "detail.traditional_meaning",
        "detail.confusion",
        "detail.variants",
        "detail.variants"
    ]

    func testRootTabsUseApprovedV5AtlasInformationArchitecture() {
        XCTAssertEqual(PalmistryRepository.tabSpecs.map(\.id), ["atlas", "gallery", "path", "mine"])
        XCTAssertEqual(PalmistryRepository.tabSpecs.map(\.titleKey), ["tab.atlas", "tab.gallery", "tab.path", "tab.mine"])
    }

    func testRepositoryProvidesSixCanonicalPalmLinesWithAtlasDepth() {
        let ids = PalmistryRepository.lines.map(\.id)
        let counts = PalmistryRepository.lines.map(\.atlasCount)

        XCTAssertEqual(ids, ["life", "head", "heart", "career", "marriage", "sun"])
        XCTAssertEqual(counts, [52, 58, 44, 46, 39, 31])
        XCTAssertEqual(PalmistryRepository.totalAtlasCount, 270)
    }

    func testEachPalmLineHasPackagedAssetAndAtLeastFourVariants() {
        let expectedAssetNames = [
            "p5100",
            "p5200",
            "p5300",
            "p5400",
            "p5500",
            "p5600"
        ]

        XCTAssertEqual(PalmistryRepository.lines.map(\.assetName), expectedAssetNames)
        XCTAssertTrue(PalmistryRepository.lines.allSatisfy { !$0.summary.isEmpty })
        XCTAssertTrue(PalmistryRepository.lines.allSatisfy { $0.variants.count >= 4 })
        XCTAssertTrue(PalmistryRepository.lines.flatMap(\.variants).allSatisfy { !$0.title.isEmpty && !$0.meaning.isEmpty })
    }

    func testAtlasHomeUsesImageFirstCategoriesFromOriginalApp() {
        XCTAssertEqual(PalmistryRepository.atlasCategories.map(\.id), ["lines", "mounts", "palaces", "basics", "tutorial", "rhythm"])
        XCTAssertEqual(PalmistryRepository.atlasCategories.map(\.assetName), ["liudaxianwen", "badazhangqiu", "bagong", "jibenshouxiang", "shouxiangjiaocheng", "jiankang01"])
        XCTAssertTrue(PalmistryRepository.atlasCategories.allSatisfy { !$0.title.isEmpty && !$0.subtitle.isEmpty })
    }

    func testLifeLineGalleryProvidesImageLedExamples() {
        let items = PalmistryRepository.lineGalleryItems(for: "life")

        XCTAssertEqual(items.count, 52)
        XCTAssertEqual(items.prefix(3).map(\.assetName), ["p5100", "p5101", "p5102"])
        XCTAssertEqual(PalmistryRepository.galleryItem(withID: "life-8")?.assetName, "p5108")
        XCTAssertNil(PalmistryRepository.galleryItem(withID: "missing"))
        XCTAssertTrue(items.allSatisfy {
            !$0.title.isEmpty &&
            !$0.subtitle.isEmpty &&
            !$0.position.isEmpty &&
            !$0.observation.isEmpty &&
            !$0.traditionalReading.isEmpty &&
            !$0.modernReading.isEmpty &&
            !$0.misread.isEmpty &&
            !$0.judgement.isEmpty &&
            !$0.actionAdvice.isEmpty &&
            !$0.disclaimer.isEmpty
        })
    }

    func testGeneratedAtlasMapsAllImagesIntoLineGroups() {
        let expectedCounts = [
            "life": 52,
            "head": 58,
            "heart": 44,
            "career": 46,
            "marriage": 39,
            "sun": 31
        ]

        XCTAssertEqual(PalmistryRepository.generatedGalleryItems.count, 270)
        for (lineID, count) in expectedCounts {
            XCTAssertEqual(PalmistryRepository.lineGalleryItems(for: lineID).count, count)
        }
        let missingImages = PalmistryRepository.generatedGalleryItems
            .filter { PalmImageStore.image(named: $0.assetName) == nil }
            .map(\.assetName)
        XCTAssertTrue(missingImages.isEmpty, "Missing or unreadable atlas images: \(missingImages.prefix(10))")
    }

    func testSevenDayLearningPathIsImageLedAndProgressive() {
        XCTAssertEqual(PalmistryRepository.lessonDays.map(\.index), [1, 2, 3, 4, 5, 6, 7])
        XCTAssertEqual(PalmistryRepository.lessonDays.first?.itemIDs, ["life-0", "head-0", "heart-0"])
        XCTAssertEqual(PalmistryRepository.lessonDays.last?.itemIDs.contains("sun-0"), true)

        for day in PalmistryRepository.lessonDays {
            XCTAssertFalse(day.title.isEmpty)
            XCTAssertFalse(day.goal.isEmpty)
            XCTAssertFalse(day.practice.isEmpty)
            XCTAssertFalse(day.itemIDs.isEmpty)
            XCTAssertTrue(day.items.allSatisfy { PalmImageStore.image(named: $0.assetName) != nil })
        }
    }

    func testAtlasContainsExpectedFirstReleaseVolume() {
        XCTAssertEqual(PalmistryRepository.totalAtlasCount, 270)
        XCTAssertEqual(PalmistryRepository.line(withID: "heart")?.assetName, "p5300")
        XCTAssertEqual(PalmistryRepository.line(withID: "marriage")?.atlasCount, 39)
        XCTAssertNil(PalmistryRepository.line(withID: "unknown"))
    }

    func testCommerceConfigurationUsesApprovedProductsAndAdDefaults() {
        let config = KNCommerceConfig.palmistryDefault

        XCTAssertEqual(config.productIDs.monthly, "com.knshouxiang.premium.monthly")
        XCTAssertEqual(config.productIDs.yearly, "com.knshouxiang.premium.yearly")
        XCTAssertEqual(config.productIDs.lifetime, "com.knshouxiang.premium.lifetime")
        XCTAssertEqual(config.freePreviewCountPerLine, 5)
        XCTAssertEqual(config.rewardUnlockPolicy, .calendarDay)
        XCTAssertEqual(config.adMob.appOpenAdUnitID, "ca-app-pub-3940256099942544/5575463023")
        XCTAssertEqual(config.adMob.rewardedAdUnitID, "ca-app-pub-3940256099942544/1712485313")
    }

    func testEntitlementServiceAllowsFirstFiveItemsPerLineForFree() throws {
        let service = KNEntitlementService(
            config: .palmistryDefault,
            purchaseStateStore: InMemoryCommerceStateStore(),
            rewardUnlockStore: InMemoryCommerceRewardStore()
        )

        let fifthLife = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "life-4"))
        let sixthLife = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "life-5"))
        let fifthHeart = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "heart-4"))
        let sixthHeart = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "heart-5"))

        XCTAssertTrue(service.canReadDeepContent(for: fifthLife, at: fixedDate(hour: 9)))
        XCTAssertFalse(service.requiresUnlock(for: fifthLife, at: fixedDate(hour: 9)))
        XCTAssertFalse(service.canReadDeepContent(for: sixthLife, at: fixedDate(hour: 9)))
        XCTAssertTrue(service.requiresUnlock(for: sixthLife, at: fixedDate(hour: 9)))
        XCTAssertTrue(service.canReadDeepContent(for: fifthHeart, at: fixedDate(hour: 9)))
        XCTAssertFalse(service.canReadDeepContent(for: sixthHeart, at: fixedDate(hour: 9)))
    }

    func testRewardUnlockIsValidOnlyForTheSameCalendarDay() throws {
        let rewardStore = InMemoryCommerceRewardStore()
        let service = KNEntitlementService(
            config: .palmistryDefault,
            purchaseStateStore: InMemoryCommerceStateStore(),
            rewardUnlockStore: rewardStore
        )
        let item = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "life-5"))

        XCTAssertFalse(service.canReadDeepContent(for: item, at: fixedDate(day: 4, hour: 9)))
        service.markRewardUnlocked(contentID: item.id, at: fixedDate(day: 4, hour: 10))

        XCTAssertTrue(service.canReadDeepContent(for: item, at: fixedDate(day: 4, hour: 23)))
        XCTAssertFalse(service.canReadDeepContent(for: item, at: fixedDate(day: 5, hour: 0)))
    }

    func testPremiumEntitlementUnlocksAllContentAndDisablesAds() throws {
        let purchaseStore = InMemoryCommerceStateStore()
        purchaseStore.setPremiumActive(true)
        let service = KNEntitlementService(
            config: .palmistryDefault,
            purchaseStateStore: purchaseStore,
            rewardUnlockStore: InMemoryCommerceRewardStore()
        )
        let lockedItem = try XCTUnwrap(PalmistryRepository.galleryItem(withID: "sun-30"))

        XCTAssertTrue(service.canReadDeepContent(for: lockedItem, at: fixedDate(hour: 9)))
        XCTAssertFalse(service.shouldRequestAds(region: .global))
        XCTAssertEqual(KNAdProviderFactory.providerKind(config: .palmistryDefault, entitlementService: service, region: .global), .noop)
    }

    func testAdProviderSelectionUsesNoopForChinaAndAdMobForGlobalFreeUsers() {
        let service = KNEntitlementService(
            config: .palmistryDefault,
            purchaseStateStore: InMemoryCommerceStateStore(),
            rewardUnlockStore: InMemoryCommerceRewardStore()
        )

        XCTAssertEqual(KNAdProviderFactory.providerKind(config: .palmistryDefault, entitlementService: service, region: .chinaMainland), .noop)
        XCTAssertEqual(KNAdProviderFactory.providerKind(config: .palmistryDefault, entitlementService: service, region: .global), .adMob)
        XCTAssertEqual(KNAdProviderFactory.providerKind(config: .palmistryDefault, entitlementService: service, region: .unknown), .noop)
    }

    func testCommerceRuntimeCachesAdProviderSoPreloadedAdsAreNotLost() {
        XCTAssertTrue(KNCommerceRuntime.adProvider === KNCommerceRuntime.adProvider)
    }

    func testRequiredLocalizationsExistForSupportedLanguages() throws {
        for locale in requiredLocales {
            let dictionary = try localizationDictionary(for: locale)
            for key in requiredLocalizationKeys {
                let value = dictionary[key]?.trimmingCharacters(in: .whitespacesAndNewlines)
                XCTAssertNotNil(value, "Missing \(key) in \(locale).lproj/PalmGuide.strings")
                XCTAssertFalse(value?.isEmpty ?? true, "Empty \(key) in \(locale).lproj/PalmGuide.strings")
                XCTAssertNotEqual(value, key, "Untranslated \(key) in \(locale).lproj/PalmGuide.strings")
            }
        }
    }

    func testPalmGuideLocalizationsHaveMatchingKeyCoverage() throws {
        let baseline = Set(try localizationDictionary(for: "zh-Hans").keys)

        for locale in requiredLocales {
            let dictionary = try localizationDictionary(for: locale)
            XCTAssertEqual(Set(dictionary.keys), baseline, "\(locale).lproj/PalmGuide.strings key set must match zh-Hans")
            XCTAssertTrue(dictionary.allSatisfy { !$0.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        }
    }

    private func localizationDictionary(for locale: String) throws -> [String: String] {
        let path = try XCTUnwrap(
            Bundle.main.path(
                forResource: "PalmGuide",
                ofType: "strings",
                inDirectory: nil,
                forLocalization: locale
            ),
            "Missing PalmGuide.strings for \(locale)"
        )
        return try XCTUnwrap(NSDictionary(contentsOfFile: path) as? [String: String])
    }

    private func fixedDate(day: Int = 4, hour: Int) -> Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .gregorian)
        components.timeZone = TimeZone(secondsFromGMT: 8 * 3600)
        components.year = 2026
        components.month = 7
        components.day = day
        components.hour = hour
        return components.date!
    }
}
