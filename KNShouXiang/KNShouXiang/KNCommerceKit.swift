//
//  KNCommerceKit.swift
//  KNShouXiang
//
//  Reusable commerce, entitlement, and ad-provider abstractions.
//

import Foundation
import StoreKit
import UIKit
#if canImport(GoogleMobileAds)
import GoogleMobileAds
#endif

struct KNCommerceProductIDs: Equatable {
    let monthly: String
    let yearly: String
    let lifetime: String

    var all: [String] {
        [monthly, yearly, lifetime]
    }
}

struct KNAdMobConfig: Equatable {
    let appID: String
    let appOpenAdUnitID: String
    let rewardedAdUnitID: String
}

enum KNRewardUnlockPolicy: Equatable {
    case calendarDay
}

struct KNCommerceConfig: Equatable {
    let productIDs: KNCommerceProductIDs
    let adMob: KNAdMobConfig
    let freePreviewCountPerLine: Int
    let rewardUnlockPolicy: KNRewardUnlockPolicy

    static let palmistryDefault = KNCommerceConfig(
        productIDs: KNCommerceProductIDs(
            monthly: "com.knshouxiang.premium.monthly",
            yearly: "com.knshouxiang.premium.yearly",
            lifetime: "com.knshouxiang.premium.lifetime"
        ),
        adMob: KNAdMobConfig(
            appID: "ca-app-pub-3940256099942544~1458002511",
            appOpenAdUnitID: "ca-app-pub-3940256099942544/5575463023",
            rewardedAdUnitID: "ca-app-pub-3940256099942544/1712485313"
        ),
        freePreviewCountPerLine: 5,
        rewardUnlockPolicy: .calendarDay
    )
}

enum KNCommerceRegion: Equatable {
    case chinaMainland
    case global
    case unknown
}

enum KNAdProviderKind: Equatable {
    case adMob
    case noop
    case mock
}

protocol KNCommerceStateStore: AnyObject {
    var isPremiumActive: Bool { get }
    func setPremiumActive(_ isActive: Bool)
}

final class UserDefaultsCommerceStateStore: KNCommerceStateStore {
    private let userDefaults: UserDefaults
    private let premiumKey: String

    init(userDefaults: UserDefaults = .standard, premiumKey: String = "kn.commerce.premium.active") {
        self.userDefaults = userDefaults
        self.premiumKey = premiumKey
    }

    var isPremiumActive: Bool {
        userDefaults.bool(forKey: premiumKey)
    }

    func setPremiumActive(_ isActive: Bool) {
        userDefaults.set(isActive, forKey: premiumKey)
    }
}

final class InMemoryCommerceStateStore: KNCommerceStateStore {
    private(set) var isPremiumActive = false

    func setPremiumActive(_ isActive: Bool) {
        isPremiumActive = isActive
    }
}

protocol KNCommerceRewardStore: AnyObject {
    func unlockDate(for contentID: String) -> Date?
    func setUnlockDate(_ date: Date, for contentID: String)
}

final class UserDefaultsCommerceRewardStore: KNCommerceRewardStore {
    private let userDefaults: UserDefaults
    private let keyPrefix: String

    init(userDefaults: UserDefaults = .standard, keyPrefix: String = "kn.commerce.reward.") {
        self.userDefaults = userDefaults
        self.keyPrefix = keyPrefix
    }

    func unlockDate(for contentID: String) -> Date? {
        userDefaults.object(forKey: keyPrefix + contentID) as? Date
    }

    func setUnlockDate(_ date: Date, for contentID: String) {
        userDefaults.set(date, forKey: keyPrefix + contentID)
    }
}

final class InMemoryCommerceRewardStore: KNCommerceRewardStore {
    private var dates = [String: Date]()

    func unlockDate(for contentID: String) -> Date? {
        dates[contentID]
    }

    func setUnlockDate(_ date: Date, for contentID: String) {
        dates[contentID] = date
    }
}

final class KNEntitlementService {
    let config: KNCommerceConfig
    private let purchaseStateStore: KNCommerceStateStore
    private let rewardUnlockStore: KNCommerceRewardStore
    private let calendar: Calendar

    init(
        config: KNCommerceConfig,
        purchaseStateStore: KNCommerceStateStore,
        rewardUnlockStore: KNCommerceRewardStore,
        calendar: Calendar = .current
    ) {
        self.config = config
        self.purchaseStateStore = purchaseStateStore
        self.rewardUnlockStore = rewardUnlockStore
        self.calendar = calendar
    }

    var isPremiumActive: Bool {
        purchaseStateStore.isPremiumActive
    }

    func canReadDeepContent(for item: PalmGalleryItem, at date: Date = Date()) -> Bool {
        isPremiumActive || isFreePreview(item) || hasRewardUnlock(contentID: item.id, at: date)
    }

    func requiresUnlock(for item: PalmGalleryItem, at date: Date = Date()) -> Bool {
        !canReadDeepContent(for: item, at: date)
    }

    func markRewardUnlocked(contentID: String, at date: Date = Date()) {
        rewardUnlockStore.setUnlockDate(date, for: contentID)
    }

    func shouldRequestAds(region: KNCommerceRegion) -> Bool {
        !isPremiumActive && region == .global
    }

    private func isFreePreview(_ item: PalmGalleryItem) -> Bool {
        item.index < config.freePreviewCountPerLine
    }

    private func hasRewardUnlock(contentID: String, at date: Date) -> Bool {
        guard let unlockedAt = rewardUnlockStore.unlockDate(for: contentID) else {
            return false
        }

        switch config.rewardUnlockPolicy {
        case .calendarDay:
            return calendar.isDate(unlockedAt, inSameDayAs: date)
        }
    }
}

protocol KNAdProvider: AnyObject {
    var kind: KNAdProviderKind { get }
    func start()
    func preloadAppOpen()
    func showAppOpenIfReady(from viewController: UIViewController)
    func preloadRewarded()
    func showRewarded(from viewController: UIViewController, completion: @escaping (Bool) -> Void)
}

final class KNNoopAdProvider: KNAdProvider {
    let kind: KNAdProviderKind = .noop

    func start() {}
    func preloadAppOpen() {}
    func showAppOpenIfReady(from viewController: UIViewController) {}
    func preloadRewarded() {}

    func showRewarded(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        completion(false)
    }
}

final class KNMockRewardedAdProvider: KNAdProvider {
    let kind: KNAdProviderKind = .mock
    private let shouldReward: Bool

    init(shouldReward: Bool = true) {
        self.shouldReward = shouldReward
    }

    func start() {}
    func preloadAppOpen() {}
    func showAppOpenIfReady(from viewController: UIViewController) {}
    func preloadRewarded() {}

    func showRewarded(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        completion(shouldReward)
    }
}

final class KNAdMobAdProvider: NSObject, KNAdProvider {
    let kind: KNAdProviderKind = .adMob
    private let config: KNAdMobConfig
    private let appOpenTimeoutInterval: TimeInterval = 4 * 3_600
    private var isLoadingAppOpen = false
    private var isShowingAppOpen = false
    private var appOpenLoadTime: Date?
    private var pendingRewardCompletion: ((Bool) -> Void)?

    #if canImport(GoogleMobileAds)
    private var appOpenAd: AppOpenAd?
    private var rewardedAd: RewardedAd?
    #endif

    init(config: KNAdMobConfig) {
        self.config = config
        super.init()
    }

    func start() {
        #if canImport(GoogleMobileAds)
        MobileAds.shared.start(completionHandler: nil)
        #endif
    }

    func preloadAppOpen() {
        #if canImport(GoogleMobileAds)
        Task { @MainActor in
            guard !isLoadingAppOpen, !isAppOpenAvailable else { return }
            isLoadingAppOpen = true
            do {
                appOpenAd = try await AppOpenAd.load(with: config.appOpenAdUnitID, request: Request())
                appOpenAd?.fullScreenContentDelegate = self
                appOpenLoadTime = Date()
            } catch {
                appOpenAd = nil
                appOpenLoadTime = nil
            }
            isLoadingAppOpen = false
        }
        #endif
    }

    func showAppOpenIfReady(from viewController: UIViewController) {
        #if canImport(GoogleMobileAds)
        guard !isShowingAppOpen, isAppOpenAvailable, let appOpenAd else {
            preloadAppOpen()
            return
        }
        isShowingAppOpen = true
        appOpenAd.present(from: viewController)
        #endif
    }

    func preloadRewarded() {
        #if canImport(GoogleMobileAds)
        Task { @MainActor in
            guard rewardedAd == nil else { return }
            do {
                rewardedAd = try await RewardedAd.load(with: config.rewardedAdUnitID, request: Request())
                rewardedAd?.fullScreenContentDelegate = self
            } catch {
                rewardedAd = nil
            }
        }
        #endif
    }

    func showRewarded(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        #if canImport(GoogleMobileAds)
        guard let rewardedAd else {
            preloadRewarded()
            completion(false)
            return
        }
        pendingRewardCompletion = completion
        rewardedAd.present(from: viewController) { [weak self] in
            self?.pendingRewardCompletion?(true)
            self?.pendingRewardCompletion = nil
        }
        #else
        completion(false)
        #endif
    }

    private var isAppOpenAvailable: Bool {
        #if canImport(GoogleMobileAds)
        guard appOpenAd != nil, let appOpenLoadTime else {
            return false
        }
        return Date().timeIntervalSince(appOpenLoadTime) < appOpenTimeoutInterval
        #else
        return false
        #endif
    }
}

#if canImport(GoogleMobileAds)
extension KNAdMobAdProvider: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        if appOpenAd === ad as AnyObject {
            appOpenAd = nil
            appOpenLoadTime = nil
            isShowingAppOpen = false
            preloadAppOpen()
        }
        if rewardedAd === ad as AnyObject {
            rewardedAd = nil
            preloadRewarded()
        }
    }

    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        if appOpenAd === ad as AnyObject {
            appOpenAd = nil
            appOpenLoadTime = nil
            isShowingAppOpen = false
            preloadAppOpen()
        }
        if rewardedAd === ad as AnyObject {
            rewardedAd = nil
            pendingRewardCompletion?(false)
            pendingRewardCompletion = nil
            preloadRewarded()
        }
    }
}
#endif

enum KNAdProviderFactory {
    static func providerKind(
        config: KNCommerceConfig,
        entitlementService: KNEntitlementService,
        region: KNCommerceRegion
    ) -> KNAdProviderKind {
        guard entitlementService.shouldRequestAds(region: region) else {
            return .noop
        }
        return .adMob
    }

    static func makeProvider(
        config: KNCommerceConfig,
        entitlementService: KNEntitlementService,
        region: KNCommerceRegion
    ) -> KNAdProvider {
        switch providerKind(config: config, entitlementService: entitlementService, region: region) {
        case .adMob:
            return KNAdMobAdProvider(config: config.adMob)
        case .mock:
            return KNMockRewardedAdProvider()
        case .noop:
            return KNNoopAdProvider()
        }
    }
}

enum KNCommerceRuntime {
    static let config = KNCommerceConfig.palmistryDefault
    static let stateStore = UserDefaultsCommerceStateStore()
    static let rewardStore = UserDefaultsCommerceRewardStore()
    private static var cachedAdProvider: KNAdProvider?
    static let entitlementService = KNEntitlementService(
        config: config,
        purchaseStateStore: stateStore,
        rewardUnlockStore: rewardStore
    )

    static var currentRegion: KNCommerceRegion {
        if Locale.current.regionCode == "CN" {
            return .chinaMainland
        }
        return .global
    }

    static var adProvider: KNAdProvider {
        if let cachedAdProvider {
            return cachedAdProvider
        }
        let provider = KNAdProviderFactory.makeProvider(
            config: config,
            entitlementService: entitlementService,
            region: currentRegion
        )
        cachedAdProvider = provider
        return provider
    }

    @available(iOS 15.0, *)
    static let storeKitService = KNStoreKitService(config: config, stateStore: stateStore)

    static func start() {
        if #available(iOS 15.0, *) {
            storeKitService.start()
            Task {
                await storeKitService.refreshEntitlements()
            }
        }
        adProvider.start()
        adProvider.preloadAppOpen()
        adProvider.preloadRewarded()
    }

    static func showAppOpenIfAllowed(from viewController: UIViewController) {
        guard entitlementService.shouldRequestAds(region: currentRegion) else {
            return
        }
        adProvider.showAppOpenIfReady(from: viewController)
    }
}

@available(iOS 15.0, *)
enum KNStorePurchaseResult: Equatable {
    case success
    case cancelled
    case pending
    case failed
}

@available(iOS 15.0, *)
final class KNStoreKitService {
    private let config: KNCommerceConfig
    private let stateStore: KNCommerceStateStore
    private(set) var products = [Product]()
    private var updatesTask: Task<Void, Never>?

    init(config: KNCommerceConfig, stateStore: KNCommerceStateStore) {
        self.config = config
        self.stateStore = stateStore
    }

    deinit {
        updatesTask?.cancel()
    }

    func start() {
        updatesTask = Task { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                if case .verified(let transaction) = result {
                    await self.refreshEntitlements()
                    await transaction.finish()
                }
            }
        }
    }

    @MainActor
    func loadProducts() async throws -> [Product] {
        products = try await Product.products(for: config.productIDs.all)
        return products
    }

    @MainActor
    func purchase(productID: String) async -> KNStorePurchaseResult {
        guard let product = products.first(where: { $0.id == productID }) else {
            return .failed
        }

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                guard case .verified(let transaction) = verification else {
                    return .failed
                }
                await refreshEntitlements()
                await transaction.finish()
                return .success
            case .userCancelled:
                return .cancelled
            case .pending:
                return .pending
            @unknown default:
                return .failed
            }
        } catch {
            return .failed
        }
    }

    @MainActor
    func refreshEntitlements() async {
        var hasPremium = false
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if config.productIDs.all.contains(transaction.productID) {
                hasPremium = true
                break
            }
        }
        stateStore.setPremiumActive(hasPremium)
    }
}
