//
//  AnimationHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 16/07/2021.
//

import Foundation
import UIKit
class AnimationHelper {
    static let shared = AnimationHelper()
    
    func animateViewIn(viewIn: UIView, viewOut: UIView) {
        UIView.animate(withDuration: 0.5) {
            viewOut.alpha = 0.0
            viewIn.alpha = 1.0
        }
    }
}
