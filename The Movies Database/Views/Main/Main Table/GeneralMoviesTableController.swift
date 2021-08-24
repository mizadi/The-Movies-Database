//
//  GeneralMoviesTableController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 17/07/2021.
//

import Foundation
import UIKit

protocol MoviesTableControllerDelegate {
    func loadMoreMovies(page: Int)
    func openWebview(_ url: URL)
    func addToFavorites(_ movie: MovieProtocol)
}

class GeneralMoviesTableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: [MovieProtocol]
    
    var delegate: MoviesTableControllerDelegate
    
    private var page: Int!
    
    private var isLoading = false
    
    init(_ data: [MovieProtocol], delegate: MoviesTableControllerDelegate) {
        self.data = data
        self.delegate = delegate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableCell.identifier, for: indexPath) as! MovieTableCell
            cell.tag = Int(data[indexPath.row].id)
            cell.setDelegate(self)
            cell.updateCell(data[indexPath.row], indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell.identifier, for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            if !isLoading {
                cell.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = data[indexPath.row].title
        guard let url = URL(string: Constants.youtubeSearch + title.replacingOccurrences(of: " ", with: "+")) else {
            return
        }
        delegate.openWebview(url)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            if page != nil {
                isLoading = true
                delegate.loadMoreMovies(page: page + 1)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 101
        } else {
            return 55
        }
    }
    
    func setData(_ movies: [MovieProtocol]) {
        data.append(contentsOf: movies)
    }
    
    func getData() -> [MovieProtocol] {
        return data
    }
    
    func setPage(_ page: Int) {
        self.page = page
    }
    
    func setIsLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func stopPulling() {
        isLoading = false
    }
    
}

extension GeneralMoviesTableController: MovieTableCellDelegate {
    
    @objc func addMovieToWatchlist(_ id: Int) {
        if let index = data.firstIndex(where: {$0.id == id}){
            delegate.addToFavorites(data[index])
        }
    }
}
