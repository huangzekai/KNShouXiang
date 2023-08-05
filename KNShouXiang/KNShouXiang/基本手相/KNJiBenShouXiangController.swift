//
//  KNJiBenShouXiangController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/5.
//

import Foundation
import JXSegmentedView

class KNJiBenShouXiangController: KNBaseShouXiangController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "基本手相"
    }
    
    override func getTitleArray()->[String] {
        let titles = ["基本手相","手的大小", "手的长短", "手的软硬", "五种手形"]
        return titles
    }
    
    override func getContentArray()->[String] {
        let contentArray = [NSLocalizedString("基本手相内容", comment: ""),
                            NSLocalizedString("手的大小内容", comment: ""),
                            NSLocalizedString("手的长短内容", comment: ""),
                            NSLocalizedString("手的软硬内容", comment: ""),
                            NSLocalizedString("五种手形内容", comment: "")]
        return contentArray
    }
}
