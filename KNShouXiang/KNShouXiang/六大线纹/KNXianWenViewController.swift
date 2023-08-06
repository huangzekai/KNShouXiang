//
//  KNXianWenViewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/5.
//

import UIKit
import JXSegmentedView


class KNXianWenViewController: KNBaseReviewController {
    
    private var currentSelectIndex = 0
    private let countArray =  [52,58, 44, 46, 39, 31]
    
    override func getImageName()->String {
        return "xianwen"
    }
    override func getTitleArray()->[String] {
        if currentSelectIndex == 0 {
            return ["六大线纹","生命线『地纹』","智慧线『人纹』", "感情线『天纹』", "命运线『天喜纹』", "婚姻线『爱情线』", "太阳线『成功线』"]
        }
        let titleArray = ["六大线纹", "生命线","智慧线", "感情线", "命运线", "婚姻线", "太阳线"]
        let count = countArray[currentSelectIndex - 1]
        
        var array = [String]()
        for index in 0..<count {
            if index == 0 {
                array.append(titleArray[currentSelectIndex])
            } else {
                array.append("第\(String(index))种")
            }
            
        }
        return array
    }
    
    override func getContentArray()->[String] {
        if currentSelectIndex == 0 {
            let contentArray = [NSLocalizedString("六大线纹内容", comment: ""),
                                NSLocalizedString("5-1-0", comment: ""),
                                NSLocalizedString("5-2-0", comment: ""),
                                NSLocalizedString("5-3-0", comment: ""),
                                NSLocalizedString("5-4-0", comment: ""),
                                NSLocalizedString("5-5-0", comment: ""),
                                NSLocalizedString("5-6-0", comment: "")]
            return contentArray
        }
        let count = countArray[currentSelectIndex - 1]

        var array = [String]()
        for index in 0..<count {
            array.append(NSLocalizedString("5-\(String(currentSelectIndex))-\(String(index))", comment: ""))
        }
        return array
    }
    
    override func changeImageViewAtIndex(index: Int) {
        if currentSelectIndex == 0 {
            imageView.image = UIImage(named: "xianwen")
        } else {
            let formattedIndex = String(format: "%02d", index)
            let imageName = "p5\(currentSelectIndex)\(formattedIndex)"
            imageView.image = UIImage(named: imageName)
        }
    }
    
    @objc func rightBarButtonTapped() {
        print("Right bar button tapped")
        let ctr = KNPicturesViewController()
        ctr.currentSelectIndex = currentSelectIndex
        self.navigationController?.pushViewController(ctr, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "六大线纹"
        
        let width = 240.0
        imageView.frame = CGRect(x: 20, y: 10, width: width, height: width)
        
        bgView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: CGRectGetMaxY(imageView.frame) + 10)
        
        let titleArray = ["各式线纹","生命线", "智慧线", "感情线", "命运线", "婚姻线", "太阳线"]
        var frame = CGRect(x: CGRectGetMaxX(imageView.frame) + 5.0, y: 10, width: view.bounds.size.width - CGRectGetMaxX(imageView.frame) - 20, height: 30)
        for index in 0..<7 {
            let button = UIButton(type: .system)
            button.frame = frame
            button.tintColor = .clear
            button.layer.cornerRadius = button.bounds.size.height / 2
            button.layer.masksToBounds = true
            button.setBackgroundImage(UIImage.from(color: .red), for: .selected)
            button.setBackgroundImage(UIImage.from(color: UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 232/255.0)), for: .normal)
            button.setTitle(titleArray[index], for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.setTitleColor(blackColor, for: .normal)
            button.tag = index + 100
            button.addTarget(self, action: #selector(buttonTagAction(_:)), for: .touchUpInside)
            if index == 0 {
                button.isSelected = true
            }
            
            view.addSubview(button)
            frame.origin.y = CGRectGetMaxY(button.frame) + 5
        }
        
    }
    
    @objc func buttonTagAction(_ sender:UIButton) {
        let selectIndex = sender.tag
        currentSelectIndex = selectIndex - 100
        
        if currentSelectIndex == 0 {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            let image = UIImage(named: "more_picture")?.withRenderingMode(.alwaysOriginal) // 保持图像的原始颜色
            let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped))
            navigationItem.rightBarButtonItem = rightBarButton
        }
        
        for index in 0..<7 {
            let button = view.viewWithTag(100 + index)
            if let button = button as? UIButton {
                if button.tag == selectIndex {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
        if let titleDataSource = segmentedDataSource as? JXSegmentedTitleDataSource {
            titleDataSource.titles = getTitleArray()
        }
        segmentedView.reloadData()
        segmentedView.selectItemAt(index: 0)
    }
}

extension UIImage {
    // 从颜色创建 UIImage
    static func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
