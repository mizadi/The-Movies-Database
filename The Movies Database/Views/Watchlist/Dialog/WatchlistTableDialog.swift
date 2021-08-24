//
//  WatchlistTableDialog.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit

class WatchlistTableDialog: NSObject {
    
    private var data: [WatchList]!

    private var completion: ((_ watchlist: WatchList) -> Void)
    
    private var alertController = UIAlertController()
    
    private var tblView = UITableView()
    
    private var alertVC: WatchlistDialogController!
    
    init(_ completion: @escaping (_ watchlist: WatchList) -> Void) {
        self.completion = completion
    }
    
    func createTableDialog(_ controller: UIViewController) {
        alertVC = R.storyboard.watchlistDialog.watchlistDialogController()
        let rect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
        alertVC.preferredContentSize = rect.size
        alertVC.setData(data)
        alertVC.setDelegate(self)
        self.alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alertController.setValue(alertVC, forKey: "contentViewController")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func removeDialog() {
        alertController.dismiss(animated: true, completion: nil)
    }
    
    func setData(_ data: [WatchList]) {
        self.data = data
    }
}
extension WatchlistTableDialog: WatchlistDialogControllerDelegate {
    func watchlistSelected(_ watchlist: WatchList) {
        completion(watchlist)
    }
    
    
}
