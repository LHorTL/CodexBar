import Foundation

enum L10n {
    private static var m: LocalizationManager { .shared }

    // MARK: - Tabs
    static var tabGeneral: String { self.m.string("tab.general") }
    static var tabProviders: String { self.m.string("tab.providers") }
    static var tabDisplay: String { self.m.string("tab.display") }
    static var tabAdvanced: String { self.m.string("tab.advanced") }
    static var tabAbout: String { self.m.string("tab.about") }
    static var tabDebug: String { self.m.string("tab.debug") }

    // MARK: - General Pane
    static var sectionSystem: String { self.m.string("section.system") }
    static var sectionUsage: String { self.m.string("section.usage") }
    static var sectionAutomation: String { self.m.string("section.automation") }
    static var startAtLogin: String { self.m.string("general.startAtLogin") }
    static var startAtLoginSubtitle: String { self.m.string("general.startAtLogin.subtitle") }
    static var showCostSummary: String { self.m.string("general.showCostSummary") }
    static var showCostSummarySubtitle: String { self.m.string("general.showCostSummary.subtitle") }
    static var autoRefreshHourly: String { self.m.string("general.autoRefreshHourly") }
    static var refreshCadence: String { self.m.string("general.refreshCadence") }
    static var refreshCadenceSubtitle: String { self.m.string("general.refreshCadence.subtitle") }
    static var autoRefreshOff: String { self.m.string("general.autoRefreshOff") }
    static var checkProviderStatus: String { self.m.string("general.checkProviderStatus") }
    static var checkProviderStatusSubtitle: String { self.m.string("general.checkProviderStatus.subtitle") }
    static var sessionQuotaNotifications: String { self.m.string("general.sessionQuotaNotifications") }
    static var sessionQuotaNotificationsSubtitle: String { self.m.string("general.sessionQuotaNotifications.subtitle") }
    static var quitCodexBar: String { self.m.string("general.quitCodexBar") }
    static var language: String { self.m.string("general.language") }
    static var languageSubtitle: String { self.m.string("general.language.subtitle") }
    static var costUnsupported: String { self.m.string("general.cost.unsupported") }
    static var costFetching: String { self.m.string("general.cost.fetching") }
    static var costLastAttempt: String { self.m.string("general.cost.lastAttempt") }
    static var costNoData: String { self.m.string("general.cost.noData") }

    // MARK: - Display Pane
    static var sectionMenuBar: String { self.m.string("section.menuBar") }
    static var sectionMenuContent: String { self.m.string("section.menuContent") }
    static var mergeIcons: String { self.m.string("display.mergeIcons") }
    static var mergeIconsSubtitle: String { self.m.string("display.mergeIcons.subtitle") }
    static var switcherShowsIcons: String { self.m.string("display.switcherShowsIcons") }
    static var switcherShowsIconsSubtitle: String { self.m.string("display.switcherShowsIcons.subtitle") }
    static var showMostUsedProvider: String { self.m.string("display.showMostUsedProvider") }
    static var showMostUsedProviderSubtitle: String { self.m.string("display.showMostUsedProvider.subtitle") }
    static var menuBarShowsPercent: String { self.m.string("display.menuBarShowsPercent") }
    static var menuBarShowsPercentSubtitle: String { self.m.string("display.menuBarShowsPercent.subtitle") }
    static var displayMode: String { self.m.string("display.displayMode") }
    static var displayModeSubtitle: String { self.m.string("display.displayMode.subtitle") }
    static var showUsageAsUsed: String { self.m.string("display.showUsageAsUsed") }
    static var showUsageAsUsedSubtitle: String { self.m.string("display.showUsageAsUsed.subtitle") }
    static var showResetTimeAsClock: String { self.m.string("display.showResetTimeAsClock") }
    static var showResetTimeAsClockSubtitle: String { self.m.string("display.showResetTimeAsClock.subtitle") }
    static var showCreditsExtraUsage: String { self.m.string("display.showCreditsExtraUsage") }
    static var showCreditsExtraUsageSubtitle: String { self.m.string("display.showCreditsExtraUsage.subtitle") }
    static var showAllTokenAccounts: String { self.m.string("display.showAllTokenAccounts") }
    static var showAllTokenAccountsSubtitle: String { self.m.string("display.showAllTokenAccounts.subtitle") }
    static var overviewTabProviders: String { self.m.string("display.overviewTabProviders") }
    static var overviewConfigure: String { self.m.string("display.overviewConfigure") }
    static var overviewEnableMerge: String { self.m.string("display.overviewEnableMerge") }
    static var overviewNoProviders: String { self.m.string("display.overviewNoProviders") }
    static var overviewNoSelected: String { self.m.string("display.overviewNoSelected") }
    static var overviewFollowOrder: String { self.m.string("display.overviewFollowOrder") }
    static func overviewChooseUpTo(_ n: Int) -> String { String(format: self.m.string("display.overviewChooseUpTo"), n) }

    // MARK: - Advanced Pane
    static var sectionKeyboardShortcut: String { self.m.string("section.keyboardShortcut") }
    static var openMenu: String { self.m.string("advanced.openMenu") }
    static var openMenuSubtitle: String { self.m.string("advanced.openMenu.subtitle") }
    static var installCLI: String { self.m.string("advanced.installCLI") }
    static var installCLISubtitle: String { self.m.string("advanced.installCLI.subtitle") }
    static var showDebugSettings: String { self.m.string("advanced.showDebugSettings") }
    static var showDebugSettingsSubtitle: String { self.m.string("advanced.showDebugSettings.subtitle") }
    static var surpriseMe: String { self.m.string("advanced.surpriseMe") }
    static var surpriseMeSubtitle: String { self.m.string("advanced.surpriseMe.subtitle") }
    static var hidePersonalInfo: String { self.m.string("advanced.hidePersonalInfo") }
    static var hidePersonalInfoSubtitle: String { self.m.string("advanced.hidePersonalInfo.subtitle") }
    static var sectionKeychainAccess: String { self.m.string("section.keychainAccess") }
    static var keychainAccessCaption: String { self.m.string("advanced.keychainAccess.caption") }
    static var disableKeychainAccess: String { self.m.string("advanced.disableKeychainAccess") }
    static var disableKeychainAccessSubtitle: String { self.m.string("advanced.disableKeychainAccess.subtitle") }
    static var sectionHTTPProxy: String { self.m.string("section.httpProxy") }
    static var httpProxyCaption: String { self.m.string("advanced.httpProxy.caption") }
    static var enableProxy: String { self.m.string("advanced.enableProxy") }
    static var enableProxySubtitle: String { self.m.string("advanced.enableProxy.subtitle") }
    static var proxyHost: String { self.m.string("advanced.proxy.host") }
    static var proxyPort: String { self.m.string("advanced.proxy.port") }
    static var proxyUsername: String { self.m.string("advanced.proxy.username") }
    static var proxyPassword: String { self.m.string("advanced.proxy.password") }
    static var cliNotFound: String { self.m.string("advanced.cli.notFound") }
    static var cliNoWriteAccess: String { self.m.string("advanced.cli.noWriteAccess") }
    static var cliInstalled: String { self.m.string("advanced.cli.installed") }
    static var cliExists: String { self.m.string("advanced.cli.exists") }
    static var cliFailed: String { self.m.string("advanced.cli.failed") }
    static var cliNoBinDirs: String { self.m.string("advanced.cli.noBinDirs") }

    // MARK: - About Pane
    static var aboutTagline: String { self.m.string("about.tagline") }
    static var aboutGitHub: String { self.m.string("about.github") }
    static var aboutWebsite: String { self.m.string("about.website") }
    static var aboutTwitter: String { self.m.string("about.twitter") }
    static var aboutEmail: String { self.m.string("about.email") }
    static var aboutAutoUpdate: String { self.m.string("about.autoUpdate") }
    static var aboutUpdateChannel: String { self.m.string("about.updateChannel") }
    static var aboutCheckForUpdates: String { self.m.string("about.checkForUpdates") }
    static var aboutUpdatesUnavailable: String { self.m.string("about.updatesUnavailable") }

    // MARK: - Debug Pane
    static var sectionLogging: String { self.m.string("section.logging") }
    static var enableFileLogging: String { self.m.string("debug.enableFileLogging") }
    static var verbosity: String { self.m.string("debug.verbosity") }
    static var verbositySubtitle: String { self.m.string("debug.verbosity.subtitle") }
    static var openLogFile: String { self.m.string("debug.openLogFile") }
    static var sectionAnimations: String { self.m.string("section.animations") }
    static var animationPattern: String { self.m.string("debug.animationPattern") }
    static var randomDefault: String { self.m.string("debug.randomDefault") }
    static var replayAnimation: String { self.m.string("debug.replayAnimation") }
    static var blinkNow: String { self.m.string("debug.blinkNow") }
    static var sectionProbeLogs: String { self.m.string("section.probeLogs") }
    static var probeLogsSubtitle: String { self.m.string("debug.probeLogs.subtitle") }
    static var fetchLog: String { self.m.string("debug.fetchLog") }
    static var copy: String { self.m.string("debug.copy") }
    static var saveToFile: String { self.m.string("debug.saveToFile") }
    static var loadParseDump: String { self.m.string("debug.loadParseDump") }
    static var rerunAutodetect: String { self.m.string("debug.rerunAutodetect") }
    static var loading: String { self.m.string("debug.loading") }
    static var noLogYet: String { self.m.string("debug.noLogYet") }
    static var sectionFetchStrategy: String { self.m.string("section.fetchStrategy") }
    static var fetchStrategySubtitle: String { self.m.string("debug.fetchStrategy.subtitle") }
    static var sectionOpenAICookies: String { self.m.string("section.openAICookies") }
    static var openAICookiesSubtitle: String { self.m.string("debug.openAICookies.subtitle") }
    static var openAICookiesNoLog: String { self.m.string("debug.openAICookies.noLog") }
    static var sectionCaches: String { self.m.string("section.caches") }
    static var clearCostCache: String { self.m.string("debug.clearCostCache") }
    static var clearCostCacheSubtitle: String { self.m.string("debug.clearCostCache.subtitle") }
    static var cleared: String { self.m.string("debug.cleared") }
    static var sectionNotifications: String { self.m.string("section.notifications") }
    static var notificationsSubtitle: String { self.m.string("debug.notifications.subtitle") }
    static var postDepleted: String { self.m.string("debug.postDepleted") }
    static var postRestored: String { self.m.string("debug.postRestored") }
    static var sectionCLISessions: String { self.m.string("section.cliSessions") }
    static var keepCLISessionsAlive: String { self.m.string("debug.keepCLISessionsAlive") }
    static var keepCLISessionsAliveSubtitle: String { self.m.string("debug.keepCLISessionsAlive.subtitle") }
    static var resetCLISessions: String { self.m.string("debug.resetCLISessions") }
    static var sectionErrorSimulation: String { self.m.string("section.errorSimulation") }
    static var errorSimulationSubtitle: String { self.m.string("debug.errorSimulation.subtitle") }
    static var setMenuError: String { self.m.string("debug.setMenuError") }
    static var clearMenuError: String { self.m.string("debug.clearMenuError") }
    static var setCostError: String { self.m.string("debug.setCostError") }
    static var clearCostError: String { self.m.string("debug.clearCostError") }
    static var sectionCLIPaths: String { self.m.string("section.cliPaths") }
    static var cliPathsSubtitle: String { self.m.string("debug.cliPaths.subtitle") }
    static var effectivePATH: String { self.m.string("debug.effectivePATH") }
    static var unavailable: String { self.m.string("debug.unavailable") }
    static var loginShellPATH: String { self.m.string("debug.loginShellPATH") }
    static var notFound: String { self.m.string("debug.notFound") }

    // MARK: - Enum Labels
    static var refreshManual: String { self.m.string("refresh.manual") }
    static var refreshOneMin: String { self.m.string("refresh.oneMinute") }
    static var refreshTwoMin: String { self.m.string("refresh.twoMinutes") }
    static var refreshFiveMin: String { self.m.string("refresh.fiveMinutes") }
    static var refreshFifteenMin: String { self.m.string("refresh.fifteenMinutes") }
    static var refreshThirtyMin: String { self.m.string("refresh.thirtyMinutes") }
    static var metricAutomatic: String { self.m.string("metric.automatic") }
    static var metricPrimary: String { self.m.string("metric.primary") }
    static var metricSecondary: String { self.m.string("metric.secondary") }
    static var metricTertiary: String { self.m.string("metric.tertiary") }
    static var metricAverage: String { self.m.string("metric.average") }
    static var displayModePercent: String { self.m.string("displayMode.percent") }
    static var displayModePace: String { self.m.string("displayMode.pace") }
    static var displayModeBoth: String { self.m.string("displayMode.both") }

    // MARK: - Menu
    static var menuSettings: String { self.m.string("menu.settings") }
    static var menuAbout: String { self.m.string("menu.about") }
    static var menuQuit: String { self.m.string("menu.quit") }
    static var menuRefresh: String { self.m.string("menu.refresh") }
    static var menuUsageDashboard: String { self.m.string("menu.usageDashboard") }
    static var menuStatusPage: String { self.m.string("menu.statusPage") }
    static var menuUpdateReady: String { self.m.string("menu.updateReady") }
    static var menuNoUsageConfigured: String { self.m.string("menu.noUsageConfigured") }
    static var menuNoUsageYet: String { self.m.string("menu.noUsageYet") }
    static var menuSwitchAccount: String { self.m.string("menu.switchAccount") }
    static var menuAddAccount: String { self.m.string("menu.addAccount") }

    // MARK: - Menu Card
    static var cardCost: String { self.m.string("card.cost") }
    static var cardCredits: String { self.m.string("card.credits") }
    static var cardCopied: String { self.m.string("card.copied") }
    static var cardCopyError: String { self.m.string("card.copyError") }
    static var cardNoUsageYet: String { self.m.string("card.noUsageYet") }
    static var cardAPIKeyLimit: String { self.m.string("card.apiKeyLimit") }

    // MARK: - Notifications
    static func sessionDepleted(_ provider: String) -> String { String(format: self.m.string("notification.sessionDepleted"), provider) }
    static var sessionDepletedBody: String { self.m.string("notification.sessionDepleted.body") }
    static func sessionRestored(_ provider: String) -> String { String(format: self.m.string("notification.sessionRestored"), provider) }
    static var sessionRestoredBody: String { self.m.string("notification.sessionRestored.body") }
}
