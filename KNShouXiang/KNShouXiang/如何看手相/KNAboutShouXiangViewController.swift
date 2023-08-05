//
//  KNAboutShouXiang.swift
//  KNShouXiang
//
//  Created by kenny on 2023/7/31.
//

import Foundation
import JXSegmentedView

class KNAboutShouXiangViewController: KNBaseShouXiangController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "如何看手相"
    }
    
    override func getTitleArray()->[String] {
        let titles = ["关于手相","左手或右手", "准备工作", "三大纹路"]
        return titles
    }
    
    override func getContentArray()->[String] {
        let contentArray = [NSLocalizedString("关于手相", comment: ""),
                            NSLocalizedString("左右手内容", comment: ""),
                            NSLocalizedString("准备工作内容", comment: ""),
                            NSLocalizedString("三大纹路内容", comment: "")]
        return contentArray
    }
}
