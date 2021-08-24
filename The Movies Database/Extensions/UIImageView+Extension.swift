//
//  UIImageView+Extension.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit
extension UIImageView {
    func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
