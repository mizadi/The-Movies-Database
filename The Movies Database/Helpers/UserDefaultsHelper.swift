//
//  UserDefaultsHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 14/07/2021.
//

import Foundation
class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    @objc let preferences = UserDefaults.standard;
    
    func setString(forKey: String, value: String) {
        preferences.set(value, forKey: forKey);
        preferences.synchronize();
    }
    
    func getString(_ forKey: String) -> String? {
        if let string = preferences.string(forKey: forKey) {
            return string;
        }
        return nil;
    }
}

struct prefsKeys {
    static let localDatabaseId = "localDatabaseId"
}
