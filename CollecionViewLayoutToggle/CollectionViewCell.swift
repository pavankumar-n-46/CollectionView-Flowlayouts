//
//  CollectionViewCell.swift
//  CollecionViewLayoutToggle
//
//  Created by PAVAN N on 09/05/21.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    private lazy var verticalConstraint: [NSLayoutConstraint] = {
        
        let imageHeight = imageView.heightAnchor.constraint(equalToConstant: 100)
        let imageWidth = imageView.widthAnchor.constraint(equalToConstant: 100)
        
        let imageTopConstraint = NSLayoutConstraint(item: imageView,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: contentView,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: 0)
        
        let imageViewCenterX = NSLayoutConstraint(item: imageView,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerX,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let companyLabelTop = NSLayoutConstraint(item: companyNameLabel,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: imageView,
                                                 attribute: .bottom,
                                                 multiplier: 1,
                                                 constant: 6)
        
        let companyLabelWidth = NSLayoutConstraint(item: companyNameLabel,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .width,
                                                   multiplier: 1,
                                                   constant: 0)
        
        let constraint = [imageHeight,
                          imageWidth,
                          imageTopConstraint,
                          imageViewCenterX,
                          companyLabelTop,
                          companyLabelWidth]
        
        return constraint
    }()

    private lazy var horizontalConstraint: [NSLayoutConstraint] = {
        
        let imageViewHeight = imageView.heightAnchor.constraint(equalToConstant: 50)
        let imageViewWidth = imageView.widthAnchor.constraint(equalToConstant: 50)
        
        let imageViewLeading = NSLayoutConstraint(item: imageView,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .leading,
                                                  multiplier: 1,
                                                  constant: 15)
        
        let imageViewCenterY = NSLayoutConstraint(item: imageView,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)

        let companyNameLeading = NSLayoutConstraint(item: companyNameLabel,
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: imageView,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: 0)
        
        let companyNameCenterY = NSLayoutConstraint(item: companyNameLabel,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: imageView,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        
        let companyNameTrailing = NSLayoutConstraint(item: companyNameLabel,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: contentView,
                                                     attribute: .trailing,
                                                     multiplier: 1,
                                                     constant: 0)
     
        let constraint = [imageViewHeight,
                          imageViewWidth,
                          imageViewLeading,
                          imageViewCenterY,
                          companyNameLeading,
                          companyNameCenterY,
                          companyNameTrailing]
        
        return constraint
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 9
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        guard let layout = newLayout.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        updateCellConstraints(forDirection: layout.scrollDirection)
    }

}

private extension CollectionViewCell {
    func commonInit() {
        setHeirarchy()
    }

    func setHeirarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(companyNameLabel)
    }

    func updateCellConstraints(forDirection scrollDirection: UICollectionView.ScrollDirection) {
        switch scrollDirection {
        case .vertical:
            companyNameLabel.textAlignment = .center
            contentView.addConstraints(verticalConstraint)
            contentView.removeConstraints(horizontalConstraint)
        case .horizontal:
            companyNameLabel.textAlignment = .center
            contentView.addConstraints(horizontalConstraint)
            contentView.removeConstraints(verticalConstraint)
        @unknown default:
            return
        }
    }
}


extension CollectionViewCell {
    func configure(direction: UICollectionView.ScrollDirection, imageStr: String) {
        self.imageView.image = UIImage(systemName: imageStr,
                                       withConfiguration: UIImage.SymbolConfiguration(scale: .default))
        self.companyNameLabel.text = imageStr
        updateCellConstraints(forDirection: direction)
    }
}

