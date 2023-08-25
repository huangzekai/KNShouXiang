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
        return ["肝病","初期肝癌","中期肝癌", "胆石症", "糖尿病", "风湿病", "脑神经受损", "长期神痛经", "妇科疾病", "子宫肌肿瘤", "小儿麻痹", "自杀未逐", "大麻烟中毒", "心脏病", "高血压", "脑溢血", "肾病", "膀胱炎", "肠病", "十二指肠溃疡", "上呼吸道炎", "哮喘", "慢性支气管炎", "肺结核"]
    }
    
    override func getContentArray()->[String] {
        let contentArray = [
                        NSLocalizedString("肝病内容", comment:""),
                        NSLocalizedString("初期肝癌内容", comment:""),
                        NSLocalizedString("中期肝癌内容", comment:""),
                        NSLocalizedString("胆石症内容", comment:""),
                        NSLocalizedString("糖尿病内容", comment:""),
                        NSLocalizedString("风湿病内容", comment:""),
                        NSLocalizedString("脑神经受损内容", comment:""),
                        NSLocalizedString("长期神痛经内容", comment:""),
                        NSLocalizedString("妇科疾病内容", comment:""),
                        NSLocalizedString("子宫肌肿瘤内容", comment:""),
                        NSLocalizedString("小儿麻痹内容", comment:""),
                        NSLocalizedString("自杀未逐内容", comment:""),
                        NSLocalizedString("大麻烟中毒内容", comment:""),
                        NSLocalizedString("心脏病内容", comment:""),
                        NSLocalizedString("高血压内容", comment:""),
                        NSLocalizedString("脑溢血内容", comment:""),
                        NSLocalizedString("肾病内容", comment:""),
                        NSLocalizedString("膀胱炎内容", comment:""),
                        NSLocalizedString("肠病内容", comment:""),
                        NSLocalizedString("十二指肠溃疡内容", comment:""),
                        NSLocalizedString("上呼吸道炎内容", comment:""),
                        NSLocalizedString("哮喘内容", comment:""),
                        NSLocalizedString("慢性支气管炎内容", comment:""),
                        NSLocalizedString("肺结核内容", comment:"")
                        ]
        return contentArray
    }
    
    override func changeImageViewAtIndex(index: Int) {
        let formattedIndex = String(format: "%02d", index+1)
        let imageName = "jiankang\(formattedIndex)"
        imageView.image = UIImage(named: imageName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = CGRect(x: 0, y: 5, width: self.view.bounds.size.width, height: imageView.bounds.size.height)
        
        self.title = "观手知健康"
    }
}
