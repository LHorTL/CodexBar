import Foundation
import Observation

@Observable
final class LocalizationManager: @unchecked Sendable {
    static let shared = LocalizationManager()

    private static let resourceBundle: Bundle = .module

    private(set) var currentLanguage: AppLanguage = .english
    private(set) var bundle: Bundle = .module

    func setLanguage(_ language: AppLanguage) {
        self.currentLanguage = language
        if let path = Self.resourceBundle.path(forResource: language.rawValue, ofType: "lproj"),
           let langBundle = Bundle(path: path)
        {
            self.bundle = langBundle
        } else {
            self.bundle = Self.resourceBundle
        }
    }

    func string(_ key: String) -> String {
        self.bundle.localizedString(forKey: key, value: key, table: "Localizable")
    }
}
