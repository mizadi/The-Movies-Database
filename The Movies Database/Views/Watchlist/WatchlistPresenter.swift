//
//  WatchlistPresenter.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
class WatchlistPresenter {
    func addWatchlistToDatabase(_ name: String) {
        let watchlist = WatchList(context: DatabaseHelper.shared.container.viewContext)
        watchlist.name = name
        watchlist.id = UUID().uuidString
        DatabaseHelper.shared.saveContext()
    }
}
