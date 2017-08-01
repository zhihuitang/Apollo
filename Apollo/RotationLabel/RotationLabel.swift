//
//  RotationLabel.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-08-01.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class RotationLabel: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var texts: [String] = ["Stockholm", "Sweden"]
    
    @IBInspectable
    var title:String = "test"
    
    @IBInspectable
    var bgColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scrollDirection: UICollectionViewScrollDirection = .vertical {
        willSet {
            
        }
        
        didSet {
            flowLayout.scrollDirection = scrollDirection
            self.collectionView.reloadData()
        }
    }
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let tmp = UICollectionViewFlowLayout()
        tmp.minimumLineSpacing = 0
        tmp.minimumInteritemSpacing = 0
        tmp.scrollDirection = self.scrollDirection
        return tmp
    }()
    
    lazy var collectionView: UICollectionView = {
        let tmp:UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        tmp.translatesAutoresizingMaskIntoConstraints = false
        tmp.delegate = self
        tmp.dataSource = self
        tmp.showsVerticalScrollIndicator = false
        tmp.showsHorizontalScrollIndicator = false
        tmp.isPagingEnabled = true
        return tmp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializationUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializationUI()
        
    }
    
    private func initializationUI(){
        self.addSubview(self.collectionView)
        let views = ["collectionView": self.collectionView] as [String:Any]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        configCollectionView()
    }
    
    private func configCollectionView(){
        self.collectionView.scrollsToTop = false
        self.collectionView.backgroundColor = bgColor
        self.collectionView.register(RotationCell.self, forCellWithReuseIdentifier: rotationReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: rotationReuseIdentifier, for: indexPath) as! RotationCell
        if indexPath.row < texts.count {
            cycleCell.textLabel.text = texts[indexPath.row]
        }
        return cycleCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flowLayout.itemSize = self.frame.size
    }
}
