//
//  ImageLoader.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import Foundation
import UIKit
class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        let localURL = self.localFileURL(for: url.absoluteString)
        
        if let localURL = localURL, FileManager.default.fileExists(atPath: localURL.path) {
            if let loadedImageData = loadLocalImage(from: localURL) {
                if let image = UIImage(data: loadedImageData) {
                    completion(.success(image))
                    return nil
                }
            }
        }
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {self.runningRequests.removeValue(forKey: uuid) }
            if let data = data, let image = UIImage(data: data) {
                if let localURL = localURL {
                    try? data.write(to: localURL)
                }
                completion(.success(image))
                return
            }

            guard let error = error else {
                // TODO: Need to handle Error
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
            
            // the request was cancelled, no need to call the callback
        }
        task.resume()
        
        // 6
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
    func localFileURL(for imageURL: String?) -> URL? {
        guard let urlString = imageURL else {
            return nil
        }
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        guard let imageName = getImageName(from: urlString) else { return nil }
        return documentsDirectoryURL.appendingPathComponent(imageName)
    }
    
    func getImageName(from urlString: String) -> String? {
        guard var base64String = urlString.data(using: .utf8)?.base64EncodedString() else { return nil }
        base64String = base64String.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
        
        guard base64String.count < 50 else {
            return String(base64String.dropFirst(base64String.count - 50))
        }
        
        return base64String
    }
    
    func loadLocalImage(from url: URL) -> Data? {
        do {
            let imageData = try Data(contentsOf: url)
            return imageData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
