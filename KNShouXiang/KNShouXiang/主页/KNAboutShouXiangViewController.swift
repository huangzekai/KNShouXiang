//
//  KNAboutShouXiang.swift
//  KNShouXiang
//
//  Created by kenny on 2023/7/31.
//

import Foundation
import JXSegmentedView

class KNAboutShouXiangViewController: KNBaseViewController  {
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "如何看手相"
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        let titles = ["关于手相","左手或右手", "准备工作", "三大纹路"]
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
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

        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }

}

extension KNAboutShouXiangViewController: JXSegmentedViewDelegate {
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

extension KNAboutShouXiangViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let controller = ListBaseViewController()
        controller.index = index
        return controller
    }
}
