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
    
    override func getImageName()->String {
        return "xianwen"
    }
    override func getTitleArray()->[String] {
        if currentSelectIndex == 0 {
            return ["六大线纹","生命线『地纹』","智慧线『人纹』", "感情线『天纹』", "命运线『天喜纹』", "婚姻线『爱情线』", "太阳线『成功线』"]
        }
        if currentSelectIndex == 1 {
            var array = [String]()
            for index in 0..<52 {
                if index == 0 {
                    array.append("生命线")
                } else {
                    array.append("第\(String(index))种")
                }
                
            }
            return array
        }
        return []
    }
    
    override func getContentArray()->[String] {
        if currentSelectIndex == 0 {
            let contentArray = [NSLocalizedString("六大线纹内容", comment: ""),
                                NSLocalizedString("5-1-0", comment: ""),
                                NSLocalizedString("智慧线内容", comment: ""),
                                NSLocalizedString("感情线内容", comment: ""),
                                NSLocalizedString("命运线内容", comment: ""),
                                NSLocalizedString("婚姻线内容", comment: ""),
                                NSLocalizedString("太阳线内容", comment: "")]
            return contentArray
        }
        if currentSelectIndex == 1 {
            var array = [String]()
            for index in 0..<52 {
                array.append(NSLocalizedString("5-1-\(String(index))", comment: ""))
            }
            return array
        }
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "六大线纹"
        
        let width = 240.0
        imageView.frame = CGRect(x: 20, y: 15, width: width, height: width)
        
        let titleArray = ["各式线纹","生命线", "智慧线", "感情线", "命运线", "婚姻线", "太阳线"]
        var frame = CGRect(x: CGRectGetMaxX(imageView.frame) + 5.0, y: 10, width: view.bounds.size.width - CGRectGetMaxX(imageView.frame) - 20, height: 30)
        for index in 0..<7 {
            let button = UIButton(type: .system)
            button.frame = frame
            button.tintColor = .clear
            button.layer.cornerRadius = button.bounds.size.height / 2
            button.layer.masksToBounds = true
            button.setBackgroundImage(UIImage.from(color: .red), for: .selected)
            button.setBackgroundImage(UIImage.from(color: grayColor), for: .normal)
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
