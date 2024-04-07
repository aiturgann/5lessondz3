//
//  Extension + String.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 7/4/24.
//

import Foundation

extension String {
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, comment: "")
    }
}
