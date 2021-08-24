//
//  CountryHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
class CountryHelper {
    static func getDeviceCountry() -> String? {
        return Locale.current.regionCode
    }
}
