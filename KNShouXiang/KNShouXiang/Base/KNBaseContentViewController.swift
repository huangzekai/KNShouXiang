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
    var content:String = ""
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 10, y: 0, width: view.bounds.size.width - 20, height: view.bounds.size.height - 35)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
