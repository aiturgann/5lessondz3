//
//  AppLanguageManager.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 4/4/24.
//

import Foundation

enum LanguageType: String {
    case kg =  "ky-KG"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager {
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    private func setCurrentLanguage(language: LanguageType) {
        currentLanguage = language
    }
    
    private func setCurrentBundlePath(languageCode: String) {
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langBundle = Bundle(path: bundle) else {
            currentBundle = bundle
            return
        }
        currentBundle = langBundle
    }
    
    func setAppLanguage(language: LanguageType) {
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue )
    }
}

