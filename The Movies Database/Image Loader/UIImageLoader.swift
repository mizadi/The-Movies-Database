//
//  UIImageLoader.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit
class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url) { [weak self] result in
            guard let self = self else {
                return
            }
            defer {
                self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    if imageView.image != nil {
                        
                        imageView.image = nil
                        UIView.transition(with: imageView,
                                          duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: { imageView.image = image },
                                          completion: nil)
                        
                    } else {
                        imageView.image = image
                    }
                }
            } catch {
                print("failed to load image to imageview")
            }
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
