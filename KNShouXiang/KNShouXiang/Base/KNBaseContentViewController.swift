//
//  ListBaseViewController.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2018/12/26.
//  Copyright © 2018 jiaxin. All rights reserved.
//

import UIKit
import JXSegmentedView

class KNBaseContentViewController: KNBaseViewController {

    let textView = UITextView()
    var showImages = false
    let bgView = UIView()
    var imageArray = [String]()
    var heigh = 0.0
    var content:String = ""
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if showImages {
            textView.frame = CGRect(x: 10, y: heigh + 5.0, width: view.bounds.size.width - 20.0, height: view.bounds.size.height - 35.0 - heigh - 5.0)
        } else {
            textView.frame = CGRect(x: 10, y: 0, width: view.bounds.size.width - 20, height: view.bounds.size.height - 35)
            bgView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showImages {
            let width = (view.bounds.size.width - 30 * 2.0 - 15 * 2) / 3.0
            bgView.frame = CGRect(x: 0, y: 8, width: view.bounds.size.width, height: width * 0.8)
            bgView.backgroundColor = UIColor(hex: "FAFDD6")
            view.addSubview(bgView)
            
            var frame = CGRect(x: 30, y: 8, width: width, height: width * 0.8)
            for imageName in imageArray {
                let image = UIImage(named: imageName)
                let imageview = UIImageView(image: image)
                imageview.frame = frame
                view.addSubview(imageview)
                heigh = CGRectGetMaxY(imageview.frame)
                frame.origin.x = CGRectGetMaxX(frame) + 15
            }
        }
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .black
        textView.isEditable = false
        textView.backgroundColor = .clear

        view.addSubview(textView)
        updateContent()
    }
    
    func updateContent() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // 设置行距
        
        let attributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content.count))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: content.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: content.count))
        
        textView.attributedText = attributedString
    }
}


extension KNBaseContentViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
