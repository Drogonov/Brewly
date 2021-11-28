//
//  BaseViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 19.11.2021.
//

import UIKit
import SwiftUI

protocol BaseViewLoader: AnyObject {
    func showLoader()
    func hideLoader()
}


class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var spinner = BaseLoaderViewController()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        configureNavigationBar()
        configureSwipeGesture()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func handleSwipeLeftGesture(gesture: UISwipeGestureRecognizer) -> Void {}

    @objc func handleSwipeRightGesture(gesture: UISwipeGestureRecognizer) -> Void {}

    // MARK: - Open methods
        
    func setNavigationBarTitle(with title: String) {
        self.navigationItem.title = title
    }
    
    func addMainViewToViewController<T: View>(_ newView: T) {
        let viewCtrl = UIHostingController(rootView: newView)
        addChild(viewCtrl)
        view.addSubview(viewCtrl.view)
        
        viewCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
        viewCtrl.didMove(toParent: self)
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.primaryTextColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.accentColor]
    }
    
    private func configureSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeftGesture))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRightGesture))
        swipeLeft.direction = .right

        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)

    }
}

extension BaseViewController: BaseViewLoader {
    func showLoader() {
        addChild(spinner)
        spinner.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner.view)
        spinner.spinner.startAnimation()
        spinner.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        spinner.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        spinner.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.didMove(toParent: self)
    }
    
    func hideLoader() {
        spinner.spinner.stopAnimation()
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

