//
//  WatchlistDatabaseHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 15/07/2021.
//

import Foundation
import CoreData
class WatchlistDatabaseHelper {
    static let shared = WatchlistDatabaseHelper()
    
    func addMovieToWatchlist(_ object: MovieProtocol) {
        var watchlist: WatchList!
        if let temp = getWatchlist(name: "Temp" ), !temp.isEmpty {
            watchlist = temp[0]
        } else {
            watchlist = WatchList(context: DatabaseHelper.shared.container.viewContext)
            watchlist.name = "Temp"
            watchlist.id = UUID().uuidString
        }
        let movie = MovieDatabaseHelper.shared.createMovieDatabaseObject(object)
        watchlist.addToMovies(movie)
        DatabaseHelper.shared.saveContext()
    }
    
    

    func getWatchlists() -> [WatchList]? {
        let request = NSFetchRequest<WatchList>(entityName: "WatchList")
        do {
            let watchlists = try DatabaseHelper.shared.container.viewContext.fetch(request)
            if !watchlists.isEmpty {
                return watchlists
            }
            return nil
        } catch {
            print("fetch failed")
            return nil
        }
    }
    
    func deleteWatchlist(_ id: String) {
        guard let watchlist = getWatchlist(id: id) else {
            return
        }
        DatabaseHelper.shared.container.viewContext.delete(watchlist)
        DatabaseHelper.shared.saveContext()
    }
    
    func getWatchlist(name: String) -> [WatchList]? {
        let request = NSFetchRequest<WatchList>(entityName: "WatchList")
        let predict: NSPredicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = predict
        do {
            let watchlists = try DatabaseHelper.shared.container.viewContext.fetch(request)
            return watchlists
        } catch {
            print("fetch failed")
            return nil
        }
    }
    
    func getWatchlist(id: String) -> WatchList? {
        let request = NSFetchRequest<WatchList>(entityName: "WatchList")
        let predict: NSPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = predict
        do {
            let watchlists = try DatabaseHelper.shared.container.viewContext.fetch(request)
            return watchlists[0]
        } catch {
            print("fetch failed")
            return nil
        }
    }
    //A7143713-194F-4CD6-9198-177E83FF9317
    func deleteMovieFromWatchlist(id: String, movie: Movie) {
        let watchlist = getWatchlist(id: id)
        watchlist?.removeFromMovies(movie)
        DatabaseHelper.shared.container.viewContext.delete(movie)
        DatabaseHelper.shared.saveContext()
    }
}
