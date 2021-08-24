//
//  SearchViewController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit
class SearchViewController: UIViewController {
    
    @IBOutlet weak var vwNoResults: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMovies: UITableView!
    
    private var tableController: GeneralMoviesTableController!
    
    private var presenter: SearchPresenter!
    
    private var searching = false
    
    private var searchTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter()
        initTableView()
        initSearchBar()
    }
    
    func initTableView() {
        tableController = GeneralMoviesTableController([MovieProtocol](), delegate: self)
        tblMovies.delegate = tableController
        tblMovies.dataSource = tableController
        tblMovies.register(UINib(nibName: R.nib.loadingCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.loadingCell.identifier)
        tblMovies.register(UINib(nibName: R.nib.movieTableCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.movieTableCell.identifier)
        tblMovies.tableFooterView = UIView()
        
    }
    
    func searchMovie(_ query: String) {
        presenter.searchMovie(page: "1", query: query) { [weak self] movies, error in
            guard let self = self else {
                return
            }
            if error == nil {
                if let movies = movies, !movies.isEmpty {
                    self.tableController.setPage(1)
                    self.tableController.setData(movies)
                    self.tblMovies.reloadData()
                    AnimationHelper.shared.animateViewIn(viewIn: self.tblMovies, viewOut: self.vwNoResults)
                }
                
            } else {
                DispatchQueue.main.async {
                    DialogHelper.shared.warningDialog("Oops", "Something went wrong, make sure your internet is connected", self)
                }
            }
            self.searching = false
        }
    }
    
    func initSearchBar() {
        searchBar.delegate = self
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tblMovies.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchTimer != nil {
            searchTimer.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            if searchText.count > 3 && !self.searching {
                self.searching = true
                self.searchMovie(searchText)
            }
        })
    }
    
    func openWatchlistDialog(_ movie: MovieProtocol) {
        var dialog: WatchlistTableDialog!
        dialog = WatchlistTableDialog { watchlist in
            watchlist.addToMovies(MovieDatabaseHelper.shared.createMovieDatabaseObject(movie))
            DatabaseHelper.shared.saveContext()
            dialog.removeDialog()
        }
        dialog.setData(WatchlistDatabaseHelper.shared.getWatchlists() ?? [WatchList]())
        dialog.createTableDialog(self)
    }
}
extension SearchViewController: MoviesTableControllerDelegate {
    func loadMoreMovies(page: Int) {
        presenter.searchMovie(page: String(page),query: searchBar.text!) { [weak self] movies, error in
            guard let self = self else {
                return
            }
            if error == nil {
                if let movies = movies, !movies.isEmpty {
                    self.tableController.setIsLoading(false)
                    self.tableController.setData(movies)
                    self.tblMovies.reloadData()
                }
            }
        }
    }
    
    func openWebview(_ url: URL) {
        let controller = WebviewHelper.openWebview(url, frame: self.view.bounds)
        self.present(controller, animated: true, completion: nil)
    }
    
    func addToFavorites(_ movie: MovieProtocol) {
        openWatchlistDialog(movie)
    }
}
