//
//  CountryCell.swift
//  CountryLookup
//
//  Created by Sadiya Syeda on 3/13/25.
//

import UIKit

class CountryCell: UITableViewCell {
    static let reuseIdentifier = "CountryCell"
    
    let nameRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        
        // Configure container view for card effect
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Labels
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameRegionLabel.numberOfLines = 1
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        
        codeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        codeLabel.textAlignment = .right
        codeLabel.adjustsFontForContentSizeCategory = true
        
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .body)
        capitalLabel.textColor = .secondaryLabel
        capitalLabel.adjustsFontForContentSizeCategory = true
        
        let stackView = UIStackView(arrangedSubviews: [nameRegionLabel, codeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        let mainStack = UIStackView(arrangedSubviews: [stackView, capitalLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 5
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStack)
        
        // Constraints
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            mainStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with country: Country) {
        nameRegionLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}
