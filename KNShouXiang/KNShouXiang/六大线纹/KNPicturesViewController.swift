//
//  KNPicturesViewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/5.
//

import UIKit
import JXPhotoBrowser

class KNPicturesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let titleArray = ["六大线纹", "生命线","智慧线", "感情线", "命运线", "婚姻线", "太阳线"]
    private var countArray =  [52,58, 44, 46, 39, 31]
    var collectionView: UICollectionView!
    var currentSelectIndex = 1
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString(titleArray[currentSelectIndex], comment: "")
        
        if (isBeforeDay()) {
            countArray =  [21,30, 15, 20, 18, 31]
        }
        
        let count = countArray[currentSelectIndex - 1]
        for index in  0..<count {
            let formattedIndex = String(format: "%02d", index)
            let imageName = "p5\(currentSelectIndex)\(formattedIndex)"
            images.append(imageName)
        }
        
        if (isBeforeDay()) {
            for index in  0..<count {
                let formattedIndex = String(format: "out%d", index)
                let imageName = "\(formattedIndex)"
                images.append(imageName)
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
    }
    
    func isBeforeDay()->Bool {
        let currentDate = Date()
        let targetDateComponents = DateComponents(year: 2023, month: 10, day: 5)

        if let targetDate = Calendar.current.date(from: targetDateComponents), currentDate < targetDate {
            print("当前日期在2023年10月5号之前")
            return true

        } else {
            print("当前日期在2023年10月5号之后")
            return false

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(named: images[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 40) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            self.images.count
        }
        browser.cellClassAtIndex = { _ in
            JXPhotoBrowserImageCell.self
        }
        browser.reloadCellAtIndex = { context in
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            let indexPath = IndexPath(item: context.index, section: 0)
            let collectionViewCell = collectionView.cellForItem(at: indexPath)
            browserCell?.imageView.image = UIImage(named: self.images[indexPath.item])
            browserCell?.imageView.contentMode = .scaleAspectFit
            if let rect = collectionViewCell?.convert(collectionViewCell?.bounds ?? .zero, to: nil) {
                browserCell?.imageView.frame = browser.view.convert(rect, from: browser.view)
            }
        }
        browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: { index -> UIView? in
            let indexPath = IndexPath(item: index, section: 0)
            return collectionView.cellForItem(at: indexPath)
        })
        browser.pageIndex = indexPath.item
        browser.show()
    }
}
