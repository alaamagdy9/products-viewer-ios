//
//  ViewController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

import NVActivityIndicatorView
import SkeletonView
import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    // The frame needs a real size because the library reads it on start.
    private let activityIndicator = NVActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 50, height: 50),
        type: .ballSpinFadeLoader,
        color: .systemBlue
    )

    private let productService = ProductService()
    // Starts empty, so the table has no rows until the feed arrives.
    private var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        tableView.dataSource = self
        // SkeletonView divides the table height by this to count its rows,
        // so it needs a fixed height and not the automatic one.
        tableView.rowHeight = 60
        tableView.isSkeletonable = true
        setUpActivityIndicator()
        loadProducts()
    }

    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Keeps the spinner in the middle in portrait and landscape.
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func loadProducts() {
        activityIndicator.startAnimating()
        tableView.showAnimatedSkeleton()

        Task {
            // Runs on success and on failure, so nothing stays on screen.
            // hideSkeleton also reloads the table with the real products.
            defer {
                activityIndicator.stopAnimating()
                tableView.hideSkeleton()
            }

            do {
                products = try await productService.fetchProducts()
            } catch {
                print("Failed to load products: \(error)")
            }
        }
    }
}

extension ViewController: SkeletonTableViewDataSource {

    // Tells SkeletonView which cell to use for the placeholder rows.
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ProductCell"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! is safe here because the storyboard prototype's class is ProductCell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configure(with: products[indexPath.row])

        return cell
    }
}
