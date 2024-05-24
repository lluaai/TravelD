//
//  CustomCollectionViewCell.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 08.04.2024.
//
import UIKit


class CustomCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CustomCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = { // Add titleLabel
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
//        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleLabel) // Add titleLabel
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8), // Adjust the top anchor of titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust the leading anchor of titleLabel
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Adjust the trailing anchor of titleLabel
            
        ])
    }
}
