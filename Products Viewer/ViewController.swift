import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let productService = ProductService()
    // Starts empty, so the table has no rows until the feed arrives.
    private var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        tableView.dataSource = self
        loadProducts()
    }

    private func loadProducts() {
        Task {
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
