//
//  MenuViewController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 03/11/2026.
//

import ENSwiftSideMenu
import UIKit

// The content of the side menu: one row per screen the app can show.
class MenuViewController: UITableViewController {

    //array contains the menu items that will appear in the side menu.
    private let items = ["TableView"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Created in code, so there's no storyboard prototype cell to use.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        // Clear, so the library's blur shows behind the items.
        tableView.backgroundColor = .clear
        // SideMenuNavigationController sets the top spacing, so iOS shouldn't add its own.
        tableView.contentInsetAdjustmentBehavior = .never
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //tells the table view how many rows it needs.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) //Reuses an existing cell or creates one using the registered identifier
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row]
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //is called when the user taps a row.

        // The products screen needs its outlet from the storyboard, so it's created from there.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productsViewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController")
        // Closes the menu and shows the products as the main screen.
        sideMenuController()?.setContentViewController(productsViewController)
    }
}
