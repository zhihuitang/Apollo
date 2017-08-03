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
    
    var totalItems: Int {
        get {
            return texts.count
        }
    }
    
    var texts: [String] = ["Stockholm", "Sweden", "Shanghai", "BeiJing", "London", "Shenzhen"]

    @IBInspectable
    var bgColor: UIColor = .white { didSet {
        self.collectionView.backgroundColor = bgColor
        setNeedsDisplay() } }
    
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
    
    var timer: Timer?
    
    @IBInspectable
    var cycleTime: Double = 2.0 {
        didSet {
            invalidateTimer()
            setupTimer()
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializationUI()
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializationUI()
        startTimer()
    }
    
    deinit {
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            invalidateTimer()
        }
    }
    private func initializationUI(){
        self.addSubview(self.collectionView)
        let views = ["collectionView": self.collectionView] as [String:Any]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        configCollectionView()
    }
    
    private func startTimer(){
        invalidateTimer()
        setupTimer()
    }
    
    private func setupTimer(){
        let automaticMethod = #selector(automaticScroll)
        timer = Timer.scheduledTimer(timeInterval: cycleTime, target: self, selector: automaticMethod, userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func automaticScroll(){
        let curIndex = getCurrentIndex()
        let tarIndex = curIndex + 1 > totalItems - 1 ? 0 : curIndex + 1
        //print("targetIndex: \(tarIndex)")
        scrolltoItem(index: tarIndex)
        /*
        if tarIndex >= totalItems {
            tarIndex = (Int)(self.totalItems / 2)
            scrolltoItem(index: tarIndex)
        }*/
    }
    
    private func scrolltoItem(index: Int, animated: Bool = true) {
        let scrollPosition: UICollectionViewScrollPosition = scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: scrollPosition, animated: animated)
    }
    
    private func getCurrentIndex() -> Int {
        var index = 0
        if self.scrollDirection == .horizontal {
            index = (Int)(self.collectionView.contentOffset.x / self.flowLayout.itemSize.width + 0.5)
        } else {
            index = (Int)(self.collectionView.contentOffset.y / self.flowLayout.itemSize.height + 0.5)
        }
        //print("currentIndex: \(index)")
        return max(index, 0)
    }
    
    private func invalidateTimer()
    {
        self.timer?.invalidate()
        self.timer = nil;
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
