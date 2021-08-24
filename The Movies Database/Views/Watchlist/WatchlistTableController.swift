//
//  WatchlistTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit



class WatchlistTableController: GeneralWatchlistsTableController {
    func removeWatchlist(at index: Int) {
        data.remove(at: index)
    }
}


