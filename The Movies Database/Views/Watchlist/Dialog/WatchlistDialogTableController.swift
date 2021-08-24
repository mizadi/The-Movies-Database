//
//  WatchlistDialogTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit

class WatchlistDialogTableController: GeneralWatchlistsTableController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.watchlistCell, for: indexPath)!
        cell.lbTitle.text = data[indexPath.row].name
        cell.vwDelete.isHidden = true
        return cell
    }
    
}
