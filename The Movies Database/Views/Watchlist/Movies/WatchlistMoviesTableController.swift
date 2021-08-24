//
//  WatchlistTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
import UIKit
protocol WatchlistMoviesTableControllerDelegate {
    func deleteMovie(with id: Int)
    func openWebview(_ url: URL)
}

class WatchlistMoviesTableController: GeneralMoviesTableController {
    
    private var watchlistDelegate: WatchlistMoviesTableControllerDelegate
    
    init(_ data: [MovieProtocol], delegate: MoviesTableControllerDelegate, watchlistDelegate: WatchlistMoviesTableControllerDelegate) {
        self.watchlistDelegate = watchlistDelegate
        super.init(data, delegate: delegate)
        self.data = data
        self.delegate = delegate
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableCell.identifier, for: indexPath) as! MovieTableCell
        cell.tag = Int(data[indexPath.row].id)
        cell.setDelegate(self)
        cell.ivFavorite.image = R.image.delete_icon()
        cell.updateCell(data[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func deleteMovie(with movieId: Int, id: String, completion: (_ index: Int?) -> Void) {
        if let index = data.firstIndex(where: {$0.id == movieId}) {
            WatchlistDatabaseHelper.shared.deleteMovieFromWatchlist(id: id, movie: data[index] as! Movie)
            data.remove(at: index)
            completion(index)
        }
        completion(nil)
    }
    
    override func addMovieToWatchlist(_ id: Int) {
        watchlistDelegate.deleteMovie(with: id)
    }
}
