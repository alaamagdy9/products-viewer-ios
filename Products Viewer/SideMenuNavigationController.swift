//
//  SideMenuNavigationController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 03/11/2026.
//

import ENSwiftSideMenu
import UIKit

// The app's navigation controller, with a side menu on the left.
class SideMenuNavigationController: ENSideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Empty for now. The real menu with the "TableView" item comes next.
        sideMenu = ENSideMenu(sourceView: view, menuViewController: UIViewController(), menuPosition: .left)
        // The menu is added on top of everything, so bring the navigation bar back to the front.
        view.bringSubviewToFront(navigationBar)
    }
}
