//
//  SideMenuNavigationController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 03/11/2026.
//

import ENSwiftSideMenu
import UIKit

// The app's navigation controller, with a side menu on the left.
// The app's navigation controller, with a side menu on the left.
class SideMenuNavigationController: ENSideMenuNavigationController {

    private let menuViewController = MenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu = ENSideMenu(sourceView: view, menuViewController: menuViewController, menuPosition: .left)
        // The menu is added on top of everything, so bring the navigation bar back to the front.
        view.bringSubviewToFront(navigationBar)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // The navigation bar covers the top of the menu, so the items start below it.
        menuViewController.tableView.contentInset.top = navigationBar.frame.maxY
    }
}
