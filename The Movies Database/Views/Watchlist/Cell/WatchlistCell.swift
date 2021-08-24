//
//  WatchlistCell.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit

protocol WatchlistCellDelegate {
    func deleteTapped(_ index: Int)
}

class WatchlistCell: UITableViewCell {
    
    var delegate: WatchlistCellDelegate!
    
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    func updateCell(_ name: String) {
        lbTitle.text = name
        vwDelete.isUserInteractionEnabled = true
        vwDelete.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteTapped)))
    }
    
    @objc func deleteTapped() {
        delegate.deleteTapped(self.tag)
    }
    
}

