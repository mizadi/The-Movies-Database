//
//  WatchlistViewController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit

class WatchlistViewController: UIViewController {
    
    @IBOutlet weak var vwNoWatchlists: UIView!
    @IBOutlet weak var ivAdd: UIImageView!
    @IBOutlet weak var tblWatchlists: UITableView!
    
    private var tableController: WatchlistTableController!
    
    private var presenter: WatchlistPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WatchlistPresenter()
        setAddButton()
        initTableView()
    }
    
    private func initTableView() {
        let watchlists = WatchlistDatabaseHelper.shared.getWatchlists()
        tableController = WatchlistTableController(watchlists ?? [WatchList](), delegate: self)
        tblWatchlists.delegate = tableController
        tblWatchlists.dataSource = tableController
        tblWatchlists.register(UINib(nibName: R.nib.watchlistCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.watchlistCell.identifier)
        tblWatchlists.tableFooterView = UIView()
        if watchlists == nil || watchlists!.isEmpty {
            AnimationHelper.shared.animateViewIn(viewIn: vwNoWatchlists, viewOut: tblWatchlists)
        } else {
            AnimationHelper.shared.animateViewIn(viewIn: tblWatchlists, viewOut: vwNoWatchlists)
        }
    }
    
    private func setAddButton() {
        ivAdd.isUserInteractionEnabled = true
        ivAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAddWatchlistDialog)))
    }
    
    @objc private func openAddWatchlistDialog() {
        DialogHelper.shared.openTextfieldDialog(self) { [weak self] watchlistName in
            guard let self = self else {
                return
            }
            guard let name = watchlistName else {
                return
            }
            self.presenter.addWatchlistToDatabase(name)
            self.tableController.setData(WatchlistDatabaseHelper.shared.getWatchlists() ?? [WatchList]())
            self.tblWatchlists.reloadData()
            AnimationHelper.shared.animateViewIn(viewIn: self.tblWatchlists, viewOut: self.vwNoWatchlists)
        }
    }
}

extension WatchlistViewController: WatchlistTableControllerDelegate {
    func deleteTapped(_ index: Int) {
        DialogHelper.shared.approveOrCancelDialog("Warning", "Are you sure you want to delete this watchlist?", self) { [weak self] delete in
            guard let self = self else {
                return
            }
            if delete {
                WatchlistDatabaseHelper.shared.deleteWatchlist(self.tableController.getData()[index].id)
                self.tableController.removeWatchlist(at: index)
                if self.tableController.getData().isEmpty {
                    AnimationHelper.shared.animateViewIn(viewIn: self.vwNoWatchlists, viewOut: self.tblWatchlists)
                } else {
                    self.tblWatchlists.reloadData()
                }
            }
        }
    }
    
    func watchlistSelected(_ watchlist: WatchList) {
        guard let controller = R.storyboard.watchlist.watchlistMoviesViewController() else {
            return
        }
        controller.watchlist = watchlist
        self.present(controller, animated: true, completion: nil)
    }
}
