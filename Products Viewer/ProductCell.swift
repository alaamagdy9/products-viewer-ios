//
//  ProductCell.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.




//displaying a product's name inside a table view.

import SkeletonView
import UIKit

class ProductCell: UITableViewCell {
    
    private let productImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    // Runs when the cell is created from the storyboard prototype.
    override func awakeFromNib() {
        super.awakeFromNib()
        // SkeletonView only covers views marked as skeletonable.
        isSkeletonable = true
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        productImageView.contentMode = .scaleAspectFit
        // Gray box until the image loads.
        productImageView.backgroundColor = .secondarySystemBackground
        
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionLabel.textColor = .secondaryLabel
        // The task allows at most 2 lines of description.
        descriptionLabel.numberOfLines = 2
        
        priceLabel.font = .preferredFont(forTextStyle: .body)
        // The price always shows fully,controls how much a view resists becoming larger than its content requires.
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let subviews: [UIView] = [productImageView, nameLabel, descriptionLabel, priceLabel] //instead of adding each view separately,put them into an array and uses a for loop.
        for subview in subviews {
            subview.isSkeletonable = true
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        
        // An empty label has no height, so it would show no placeholder.
        nameLabel.text = " "
        descriptionLabel.text = " "
        priceLabel.text = " "
    }
    
    private func setUpConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            // Image: on the left, square, centered vertically.
            productImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            // Price: on the right, centered vertically.
            priceLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Title: between the image and the price, at the top.
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            
            // Description: under the title, with the same left and right edges.
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        descriptionLabel.text = cleanedDescription(product.description)
        // The feed sends the price without a currency sign.
        priceLabel.text = "$" + product.price
    }
    
    // Some descriptions start with spaces and contain the HTML line break <br />.
    private func cleanedDescription(_ description: String) -> String {
        return description
            .replacingOccurrences(of: "<br />", with: " ")
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
