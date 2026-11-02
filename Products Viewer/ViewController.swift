//
//  ViewController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

import NVActivityIndicatorView
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

        Task {
            // Runs on success and on failure, so the spinner never gets stuck.
            defer { activityIndicator.stopAnimating() }

            do {
                products = try await productService.fetchProducts()
                // The data came after the table appeared, so it must redraw.
                tableView.reloadData()
            } catch {
                print("Failed to load products: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Must match the Identifier on the prototype cell in the storyboard.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = products[indexPath.row].name
        cell.contentConfiguration = content

        return cell
    }
}
