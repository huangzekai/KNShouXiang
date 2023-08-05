//
//  KNZhangQiuViewController.swift
//  KNShouXiang
//
//  Created by kenny on 2023/8/4.
//

import UIKit
import JXSegmentedView


class KNZhangQiuViewController: KNBaseReviewController {
    override func getImageName()->String {
        return "zhangqiu"
    }
    override func getTitleArray()->[String] {
        return ["八大掌丘","金星丘","木星丘", "土星丘", "太阳丘", "水星丘", "太阴丘", "第一火星丘", "第二火星丘"]
    }
    
    override func getContentArray()->[String] {
        let contentArray = [NSLocalizedString("八大掌丘内容", comment: ""),
                            NSLocalizedString("金星丘内容", comment: ""),
                            NSLocalizedString("木星丘内容", comment: ""),
                            NSLocalizedString("土星丘内容", comment: ""),
                            NSLocalizedString("太阳丘内容", comment: ""),
                            NSLocalizedString("水星丘内容", comment: ""),
                            NSLocalizedString("太阴丘内容", comment: ""),
                            NSLocalizedString("第一火星丘内容", comment: ""),
                            NSLocalizedString("第二火星丘内容", comment: "")]
        return contentArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "八大掌丘"
    }
}
