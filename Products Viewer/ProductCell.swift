//
//  ProductCell.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

import SkeletonView
import UIKit

class ProductCell: UITableViewCell {

    private let nameLabel = UILabel()

    // Runs once when a cell is created from the storyboard prototype.
    override func awakeFromNib() {
        super.awakeFromNib()

        // SkeletonView only covers views marked as skeletonable.
        isSkeletonable = true
        nameLabel.isSkeletonable = true
        // An empty label has no height, so it would show no placeholder.
        nameLabel.text = " "

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
    }
}
