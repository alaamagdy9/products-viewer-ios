//
//  ProductDetailViewController.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

//


import UIKit

class ProductDetailViewController: UIViewController {

    private let product: Product

    private let titleLabel = UILabel()
    private let imageView = UIImageView()

    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    // nil until the first layout, so the first check always applies a layout.
    private var isShowingLandscape: Bool?

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    // Required by UIKit, but this screen is never loaded from a storyboard.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
        setUpConstraints()
    }

    // UIKit calls this before laying out the screen, including after a rotation.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout()
    }

    private func setUpViews() {
        titleLabel.text = product.name
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground

        view.addSubview(titleLabel)
        view.addSubview(imageView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        // Title on top, with the image below it.
        portraitConstraints = [
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ]

        // Image on the left, with the title on its right.
        landscapeConstraints = [
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ]
    }

    private func updateLayout() {
        let isLandscape = view.bounds.width > view.bounds.height
        // Only swap when the orientation really changed.
        guard isLandscape != isShowingLandscape else { return }
        isShowingLandscape = isLandscape

        // Deactivate first, so the two sets are never active together.
        NSLayoutConstraint.deactivate(isLandscape ? portraitConstraints : landscapeConstraints)
        NSLayoutConstraint.activate(isLandscape ? landscapeConstraints : portraitConstraints)
    }
}
