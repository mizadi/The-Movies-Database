//
//  MainTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit
class MainTableController: UIViewController {
    
    
    @IBOutlet weak var vwLoader: UIView!
    @IBOutlet weak var tblMovies: UITableView!
    
    private var tableController: GeneralMoviesTableController!
    
    private var presenter: MainTablePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainTablePresenter(delegate: self)
        presenter.pullMovies()
        initTableView()
    }
    
    func initTableView() {
        tableController = GeneralMoviesTableController([MovieProtocol](), delegate: self)
        tblMovies.delegate = tableController
        tblMovies.dataSource = tableController
        tblMovies.register(UINib(nibName: R.nib.loadingCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.loadingCell.identifier)
        tblMovies.register(UINib(nibName: R.nib.movieTableCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.movieTableCell.identifier)
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
extension MainTableController: MoviesTableControllerDelegate {
    func addToFavorites(_ movie: MovieProtocol) {
        openWatchlistDialog(movie)
    }
    
    func openWebview(_ url: URL) {
        let controller = WebviewHelper.openWebview(url, frame: self.parent!.view.bounds)
        self.present(controller, animated: true, completion: nil)
    }
    
    func loadMoreMovies(page: Int) {
        presenter.pullMovies(String(page))
    }
    
}

extension MainTableController: MainTablePresenterDelegate {
    func finishedPullingMovies(_ container: MoviesContainer) {
        guard let movies = container.results else {
            return
        }
        tableController.setPage(container.page)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableController.setData(movies)
            self.tableController.setIsLoading(false)
            UIView.performWithoutAnimation {
                self.tblMovies.reloadData()
            }
            AnimationHelper.shared.animateViewIn(viewIn: self.tblMovies, viewOut: self.vwLoader)
        }
    }
    
    func failedToPullMovies() {
        if let movies = presenter.shouldLoadLocalData() {
            tableController.setData(movies)
            DispatchQueue.main.async {
                self.tblMovies.reloadData()
                AnimationHelper.shared.animateViewIn(viewIn: self.tblMovies, viewOut: self.vwLoader)
                
            }
            
        } else {
            tableController.stopPulling()
            DispatchQueue.main.async {
                self.vwLoader.isHidden = true
                DialogHelper.shared.warningDialog("Oops", "It seems you dont have internet, please check your connection and try again", self)
            }
        }
        
    }
    
}
