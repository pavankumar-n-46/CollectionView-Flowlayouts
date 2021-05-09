//
//  ViewController.swift
//  CollecionViewLayoutToggle
//
//  Created by PAVAN N on 09/05/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        commoninit()
    }
    
    private lazy var currentScrollDirection = UICollectionView.ScrollDirection.horizontal
    
    private let cellImages = ["flame",
                              "drop",
                              "bolt",
                              "hare",
                              "tortoise",
                              "ant",
                              "ladybug",
                              "leaf"]
    
    private let toggleButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.setTitle("Toggle", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.blue, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayoutHorizontal)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.description())
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return collectionView
    }()
    
    private lazy var flowLayoutVertical: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = .init(width: view.bounds.width - 50, height: 80)
        flowLayout.minimumLineSpacing = 15
        return flowLayout
    }()
    
    private let flowLayoutHorizontal: UICollectionViewFlowLayout = {
        let flowLayoutHorizontal = UICollectionViewFlowLayout()
        flowLayoutHorizontal.scrollDirection = .horizontal
        flowLayoutHorizontal.itemSize = .init(width: UIScreen.main.bounds.width * 0.19, height: 140)
        flowLayoutHorizontal.minimumLineSpacing = 25
        flowLayoutHorizontal.minimumInteritemSpacing = 1000
        return flowLayoutHorizontal
    }()

    @objc private func buttonTarget() {
        toggleFlowLayout()
    }
}

private extension ViewController {
    func commoninit() {
        setupUI()
        setHierarchy()
        setupConstraints()
    }
    
    func setupUI() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = flowLayoutHorizontal
        toggleButton.addTarget(self, action: #selector(buttonTarget), for: .touchUpInside)
    }
    
    func setHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(toggleButton)
    }
    
    func setupConstraints() {
        
        let leadingConstraint = NSLayoutConstraint(item: collectionView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self.view,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: 15)
        
        let trailingConstraint = NSLayoutConstraint(item: collectionView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: -15)
        
        let centerYConstraint = NSLayoutConstraint(item: collectionView,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.view,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        let collecionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: 250)
        
        let trailingButtonTop = NSLayoutConstraint(item: toggleButton,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: collectionView,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: 15)
        
        let trailingButtonCenterX = NSLayoutConstraint(item: toggleButton,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: collectionView,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)
        
        view.addConstraints([leadingConstraint,
                             trailingConstraint,
                             centerYConstraint,
                             collecionViewHeight,
                             trailingButtonTop,
                             trailingButtonCenterX])
    }
    
    func toggleFlowLayout(withAnimation animation: Bool = true) {
        switch currentScrollDirection {
        
        case .vertical:
            currentScrollDirection = .horizontal
            collectionView.reloadData()
            collectionView.setCollectionViewLayout(flowLayoutHorizontal, animated: animation)
            
        case .horizontal:
            currentScrollDirection = .vertical
            collectionView.reloadData()
            collectionView.setCollectionViewLayout(flowLayoutVertical, animated: animation)
            
        @unknown default:
            return
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.description(),
                                                      for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }
        if currentScrollDirection == .horizontal {
            cell.configure(direction: .vertical, imageStr: cellImages[indexPath.row])
        } else if currentScrollDirection == .vertical {
            cell.configure(direction: .horizontal, imageStr: cellImages[indexPath.row])
        }
        
        return cell
    }
}
