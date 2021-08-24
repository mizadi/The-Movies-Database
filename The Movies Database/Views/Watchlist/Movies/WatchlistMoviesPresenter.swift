//
//  WatchlistPresenter.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
class WatchlistMoviesPresenter {
    func getMovies() -> [MovieProtocol]? {
        let watchListObject = WatchlistDatabaseHelper.shared.getWatchlist(id: "A7143713-194F-4CD6-9198-177E83FF9317")
        if let watchlist = watchListObject {
            return Array(watchlist.movies)
        }
        return nil
    }
}
