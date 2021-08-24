//
//  WatchlistViewController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit

class WatchlistMoviesViewController: UIViewController {
    
    @IBOutlet weak var vwNoMovies: UIView!
    @IBOutlet weak var tblMovies: UITableView!
    
    var tableController: WatchlistMoviesTableController!
    
    var watchlist: WatchList!
    
    var presenter: WatchlistMoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WatchlistMoviesPresenter()
        initTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let movies = Array(watchlist.movies)
        if !movies.isEmpty {
            tableController.setData(movies)
            tblMovies.reloadData()
            AnimationHelper.shared.animateViewIn(viewIn: tblMovies, viewOut: vwNoMovies)
        }
    }
    
    func initTableView() {
        tableController = WatchlistMoviesTableController([MovieProtocol](), delegate: self, watchlistDelegate: self)
        tblMovies.delegate = tableController
        tblMovies.dataSource = tableController
        tblMovies.register(UINib(nibName: R.nib.loadingCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.loadingCell.identifier)
        tblMovies.register(UINib(nibName: R.nib.movieTableCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.movieTableCell.identifier)
        tblMovies.tableFooterView = UIView()
        
    }
}

extension WatchlistMoviesViewController: WatchlistMoviesTableControllerDelegate, MoviesTableControllerDelegate {
    func deleteMovie(with id: Int) {
        DialogHelper.shared.approveOrCancelDialog("Warning", "Are you sure you want to remove this movie from the watchlist?", self) { [weak self] delete in
            guard let self = self else {
                return
            }
            if delete {
                self.tableController.deleteMovie(with: id, id: self.watchlist.id) { index in
                    guard let index = index else {
                        return
                    }
                    if self.tableController.getData().isEmpty {
                        AnimationHelper.shared.animateViewIn(viewIn: self.vwNoMovies, viewOut: self.tblMovies)
                    } else {
                        self.tblMovies.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }
        }
    }

    func openWebview(_ url: URL) {
        let controller = WebviewHelper.openWebview(url, frame: self.view.bounds)
        self.present(controller, animated: true, completion: nil)
    }
    func loadMoreMovies(page: Int) {
        
    }
    
    func addToFavorites(_ movie: MovieProtocol) {
    
    }
}

