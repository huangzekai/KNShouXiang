//
//  KNJianKangViewController.swift
//  KNShouXiang
//
//  Created by kenny on 2023/8/25.
//

import UIKit
import JXSegmentedView


class KNJianKangViewController: KNBaseReviewController {
    override func getImageName()->String {
        return "jiankang01"
    }
    override func getTitleArray()->[String] {
        return (1...24).map { String(format: "状态观察 %02d", $0) }
    }
    
    override func getContentArray()->[String] {
        return (1...24).map {
            NSLocalizedString(String(format: "状态观察%02d内容", $0), comment:"")
        }
    }
    
    override func changeImageViewAtIndex(index: Int) {
        let formattedIndex = String(format: "%02d", index+1)
        let imageName = "jiankang\(formattedIndex)"
        imageView.image = UIImage(named: imageName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = CGRect(x: 0, y: 5, width: self.view.bounds.size.width, height: imageView.bounds.size.height)
        
        self.title = "掌色与状态"
    }
}
