//
//  KNZhangQiuViewController.swift
//  KNShouXiang
//
//  Created by kenny on 2023/8/4.
//

import UIKit
import JXSegmentedView


class KNZhangQiuViewController: KNBaseViewController {
    lazy var imageView:UIImageView! = {
        let zhangqiuImageView = UIImageView(image: UIImage(named: "zhangqiu"))
        zhangqiuImageView.contentMode = .scaleAspectFit
        return zhangqiuImageView
    }()
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "八大掌丘"
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 100, y: 15, width: 150, height: 150)
        
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        let titles = ["金星丘","木星丘", "土星丘", "太阳丘", "水星丘", "太阴丘", "第一火星丘", "第二火星丘"]
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        indicator.backgroundColor = .white
        segmentedView.indicators = [indicator]
        
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: 165, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: CGRectGetMaxY(segmentedView.frame), width: view.bounds.size.width, height: view.bounds.size.height - CGRectGetMaxY(segmentedView.frame))
    }
    
}


extension KNZhangQiuViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension KNZhangQiuViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let contentArray = [NSLocalizedString("关于手相", comment: ""),
                            NSLocalizedString("左右手内容", comment: ""),
                            NSLocalizedString("准备工作内容", comment: ""),
                            NSLocalizedString("三大纹路内容", comment: ""),
                            NSLocalizedString("关于手相", comment: ""),
                            NSLocalizedString("左右手内容", comment: ""),
                            NSLocalizedString("准备工作内容", comment: ""),
                            NSLocalizedString("准备工作内容", comment: "")]
        let controller = KNBaseContentViewController()
        controller.content = contentArray[index]
        return controller
    }
}
