//
//  KNZhangGongViewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/5.
//

import UIKit
import JXSegmentedView


class KNZhangGongViewController: KNBaseReviewController {
    override func getImageName()->String {
        return "bagong"
    }
    override func getTitleArray()->[String] {
        return ["手掌八宫内容","坎宫内容","根宫内容", "震宫内容", "巽宫内容", "离宫内容", "坤宫内容", "兑宫内容", "乾宫内容"]
    }
    
    override func getContentArray()->[String] {
        let contentArray = [NSLocalizedString("手掌八宫内容", comment: ""),
                            NSLocalizedString("坎宫内容", comment: ""),
                            NSLocalizedString("根宫内容", comment: ""),
                            NSLocalizedString("震宫内容", comment: ""),
                            NSLocalizedString("巽宫内容", comment: ""),
                            NSLocalizedString("离宫内容", comment: ""),
                            NSLocalizedString("坤宫内容", comment: ""),
                            NSLocalizedString("兑宫内容", comment: ""),
                            NSLocalizedString("乾宫内容", comment: "")]
        return contentArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "手掌八宫"
    }
}
