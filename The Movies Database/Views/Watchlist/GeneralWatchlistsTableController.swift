//
//  GeneralWatchlistsTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 17/07/2021.
//

import Foundation
import UIKit

protocol WatchlistTableControllerDelegate {
    func deleteTapped(_ index: Int)
    func watchlistSelected(_ watchlist: WatchList)
}

class GeneralWatchlistsTableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: WatchlistTableControllerDelegate
    
    var data: [WatchList]
    
    init(_ data: [WatchList], delegate: WatchlistTableControllerDelegate) {
        self.data = data
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.watchlistCell, for: indexPath)!
        cell.delegate = self
        cell.tag = indexPath.row
        cell.updateCell(data[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.watchlistSelected(data[indexPath.row])
    }
    
    func setData(_ data: [WatchList]) {
        self.data = data
    }
    
    func getData() -> [WatchList] {
        return data
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension GeneralWatchlistsTableController: WatchlistCellDelegate {
    @objc func deleteTapped(_ index: Int) {
        delegate.deleteTapped(index)
    }
    
    
}
