//
//  WatchlistDialogController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit

protocol WatchlistDialogControllerDelegate {
    func watchlistSelected(_ watchlist: WatchList)
}

class WatchlistDialogController: UIViewController {
    
 
    @IBOutlet weak var ivAdd: UIImageView!
    @IBOutlet weak var vwNoWatchlists: UIView!
    @IBOutlet weak var tblMain: UITableView!
    private var tableController: WatchlistDialogTableController!
    
    private var delegate: WatchlistDialogControllerDelegate!
    
    private var presenter: WatchlistPresenter!
    
    private var data: [WatchList]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WatchlistPresenter()
        initTableview()
        setAddButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblMain.reloadData()
    }
    
    private func setAddButton() {
        ivAdd.isUserInteractionEnabled = true
        ivAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAddWatchlistDialog)))
    }
    
    private func initTableview() {
        tableController = WatchlistDialogTableController(data, delegate: self)
        tblMain.delegate = tableController
        tblMain.dataSource = tableController
        tblMain.register(UINib(nibName: R.nib.watchlistCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.watchlistCell.identifier)
        tblMain.tableFooterView = UIView()
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
            self.tblMain.reloadData()
        }
    }
    
    func setData(_ data: [WatchList]) {
        self.data = data
    }
    
    func setDelegate(_ delegate: WatchlistDialogControllerDelegate) {
        self.delegate = delegate
    }
    
}

extension WatchlistDialogController: WatchlistTableControllerDelegate {
    func deleteTapped(_ index: Int) {
        
    }
    
    func watchlistSelected(_ watchlist: WatchList) {
        delegate.watchlistSelected(watchlist)
    }
    
    
}
