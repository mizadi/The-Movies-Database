//
//  MovieTableCell.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit

protocol MovieTableCellDelegate {
    func addMovieToWatchlist(_ id: Int)
}

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var ivGoldStar: UIImageView!
    @IBOutlet weak var vwFavorite: UIView!
    @IBOutlet weak var ivFavorite: UIImageView!
    @IBOutlet weak var ivReleaseDate: UIImageView!
    
    private var delegate: MovieTableCellDelegate!
    
    override func prepareForReuse() {
        lbTitle.text = ""
        lbRank.text = ""
        lbLanguage.text = ""
        lbReleaseDate.text = ""
        ivGoldStar.image = nil
    }
    
    func updateCell(_ movie: MovieProtocol, indexPath: IndexPath) {
        //ivMain.image = nil
        lbTitle.text = movie.title
        if movie.release_date.isEmpty {
            ivReleaseDate.isHidden = true
        }else {
            ivReleaseDate.isHidden = false
            lbReleaseDate.text = movie.release_date
        }
        lbLanguage.text = LanguageHelper.getFullLanguage(for: movie.original_language) ?? ""
        lbRank.text = "\(movie.vote_average)/10"
        ivGoldStar.image = R.image.gold_star()!
        if movie.poster_path == nil || movie.poster_path!.isEmpty {
            ivMain.image = R.image.placeholder()
        } else {
            if let url = URL(string: Constants.imageBaseURL + (movie.poster_path ?? "")) {
                ivMain.loadImage(at: url)
            }
        }
        vwFavorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTapped)))
    }
    
    @objc func favoriteTapped() {
        delegate.addMovieToWatchlist(self.tag)
    }
    
    func setDelegate(_ delegate: MovieTableCellDelegate) {
        self.delegate = delegate
    }
    
    
}
