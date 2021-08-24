//
//  DialogHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 13/07/2021.
//

import Foundation
import UIKit
class DialogHelper {
    static let shared = DialogHelper()
    
    func approveOrCancelDialog(_ title: String, _ message: String, _ controller: UIViewController, completionHandler: @escaping (_ approve: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            completionHandler(true);
        }));
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            completionHandler(false);
        }));
        controller.present(alert, animated: true, completion: nil);
    }
    
    func openTextfieldDialog(_ controller: UIViewController, completion: @escaping (_ watchlistName: String?) -> Void) {
        let alert = UIAlertController(title: "New Watchlist", message: "Please enter a name", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Watchlist name"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            completion(textField?.text)
        }))

        // 4. Present the alert.
        controller.present(alert, animated: true, completion: nil)
    }
    
    func warningDialog(_ title: String, _ message: String, _ controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            
        }));
        controller.present(alert, animated: true, completion: nil)
    }

}
