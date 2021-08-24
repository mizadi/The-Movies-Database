//
//  ViewController.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 11/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var vwSearch: UIView!
    
    private var pageController: UIPageViewController!
    private var controllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchButton()
        createControllers()
        createSegemntedControl()
        setPageController()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  R.segue.mainViewController.mainPageController.identifier {
            pageController = segue.destination as? UIPageViewController
        }
    }
    
    func setSearchButton() {
        vwSearch.isUserInteractionEnabled = true
        vwSearch.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTapped)))
    }
    
    @objc func searchTapped() {
        guard let controller = R.storyboard.search.searchViewController() else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func createControllers() {
        guard let watchlistController = R.storyboard.watchlist.watchlistViewController() else {
            return
        }
        guard let moviesController = R.storyboard.mainTable.mainTableController() else {
            return
        }
        controllers = [moviesController,watchlistController]
    }
    
    func createSegemntedControl() {
        segmentedControl.addTarget(self, action: #selector(changeMainView(_:)), for: .valueChanged)
    }
    
    @objc func changeMainView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            pageController.setViewControllers([controllers[1]], direction: .forward, animated: true, completion: nil)
        } else {
            pageController.setViewControllers([controllers[0]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func setPageController() {
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    
}
