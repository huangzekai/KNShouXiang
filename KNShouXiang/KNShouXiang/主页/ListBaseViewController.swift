//
//  ListBaseViewController.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2018/12/26.
//  Copyright © 2018 jiaxin. All rights reserved.
//

import UIKit
import JXSegmentedView

class ListBaseViewController: KNBaseViewController {

    let textView = UITextView()
    var index = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 30)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        view.addSubview(textView)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // 设置行距
        
        let contentArray = [NSLocalizedString("关于手相", comment: ""),
                            NSLocalizedString("左右手内容", comment: ""),
                            NSLocalizedString("准备工作内容", comment: ""),
                            NSLocalizedString("三大纹路内容", comment: "")]

        let content = contentArray[index]
        let attributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content.count))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: content.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: content.count))

        textView.attributedText = attributedString
        
    }
}

extension ListBaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
