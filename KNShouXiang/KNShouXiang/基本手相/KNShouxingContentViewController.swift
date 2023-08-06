//
//  KNShouxingContentViewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/6.
//

import UIKit
import JXSegmentedView

class KNShouxingContentViewController: KNBaseViewController {

    let textView = UITextView()
    var imageArray = ["p241","p242", "p243", "p244", "p245"]
    var heigh = 0.0
    var content:String = ""
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 10, y: heigh + 5.0, width: view.bounds.size.width - 20.0, height: view.bounds.size.height - 35.0 - heigh - 5.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleArray = ["方形手","圆锥手", "原始手", "哲学手", "精神手"]
        let width = (view.bounds.size.width - 5 * 4 - 20) / 5
        var frame = CGRect(x: 10, y: 10, width: width, height: 30)
        for index in 0..<titleArray.count {
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
            frame.origin.x = CGRectGetMaxX(button.frame) + 5
        }
        
        let bgview = UIView(frame: CGRect(x: 0, y: 45, width: view.bounds.size.width, height: width * 1.25))
        bgview.backgroundColor = UIColor(hex: "FAFDD6")
        view.addSubview(bgview)
        
        frame = CGRect(x: 10.0, y: 45, width: width, height: width * 1.25)
        for index in 0..<imageArray.count {
            let imageName = imageArray[index]
            let image = UIImage(named: imageName)
            let imageview = UIImageView(image: image)
            imageview.isHidden = index != 0
            imageview.tag = index + 1000
            imageview.frame = frame
            view.addSubview(imageview)
            heigh = CGRectGetMaxY(imageview.frame)
            frame.origin.x = CGRectGetMaxX(frame) + 5
        }
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .black
        textView.isEditable = false
        textView.backgroundColor = .clear

        view.addSubview(textView)
        updateContent()
    }
    
    @objc func buttonTagAction(_ sender:UIButton) {
        let selectIndex = sender.tag
        
        let contentArray = ["方形手内容", "圆锥形内容", "原始手内容", "哲学手内容", "精神手内容"];
        content = NSLocalizedString(contentArray[selectIndex - 100], comment: "")
        updateContent()
        
        for index in 0..<5 {
            let button = view.viewWithTag(100 + index)
            if let button = button as? UIButton {
                if button.tag == selectIndex {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
            
            let imageview = view.viewWithTag(1000 + index)
            if let imageview = imageview as? UIImageView {
                if imageview.tag == selectIndex - 100 + 1000 {
                    imageview.isHidden = false
                } else {
                    imageview.isHidden = true
                }
            }
            
        }
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


extension KNShouxingContentViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
