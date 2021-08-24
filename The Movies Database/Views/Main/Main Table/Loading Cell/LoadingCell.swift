//
//  LoadingCell.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
import UIKit
class LoadingCell: UITableViewCell {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        activityIndicator.color = R.color.black()!
    }
}
