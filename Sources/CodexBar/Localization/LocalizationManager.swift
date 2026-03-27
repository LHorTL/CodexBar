import Foundation
import Observation

@Observable
final class LocalizationManager: @unchecked Sendable {
    static let shared = LocalizationManager()

    private(set) var currentLanguage: AppLanguage = .english
    private(set) var bundle: Bundle = .main

    func setLanguage(_ language: AppLanguage) {
        self.currentLanguage = language
        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
           let langBundle = Bundle(path: path)
        {
            self.bundle = langBundle
        } else {
            self.bundle = .main
        }
    }

    func string(_ key: String) -> String {
        self.bundle.localizedString(forKey: key, value: key, table: "Localizable")
    }
}
