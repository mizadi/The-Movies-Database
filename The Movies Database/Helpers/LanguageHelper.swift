//
//  LanguageHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
class LanguageHelper {
    static func getFullLanguage(for string: String) -> String? {
        let language = Locale.current.localizedString(forLanguageCode: string)
        return language
    }
}
