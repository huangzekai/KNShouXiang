//
//  KNBaseReviewController.swift
//  KNShouXiang
//
//  Created by kennykhuang on 2023/8/5.
//

import UIKit
import JXSegmentedView
import JXPhotoBrowser


class KNBaseReviewController: KNBaseViewController {
    
    lazy var imageView:UIImageView! = {
        let name = getImageName()
        let baseImageView = UIImageView(image: UIImage(named: name))
        baseImageView.contentMode = .scaleAspectFit
        baseImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTap))
        baseImageView.addGestureRecognizer(gesture)
        return baseImageView
    }()
    
    @objc func imageViewDidTap() {
        let browser = JXPhotoBrowser()

        browser.numberOfItems = {
            1
        }
        browser.cellClassAtIndex = { _ in
            JXPhotoBrowserImageCell.self
        }
        browser.reloadCellAtIndex = { context in
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            
            browserCell?.imageView.image = self.imageView.image
        }
        browser.transitionAnimator = JXPhotoBrowserSmoothZoomAnimator(transitionViewAndFrame: { (index, destinationView) -> JXPhotoBrowserSmoothZoomAnimator.TransitionViewAndFrame? in
            
            let image = self.imageView.image
            let transitionView = UIImageView(image: image)
            transitionView.contentMode = self.imageView.contentMode
            transitionView.clipsToBounds = true
            let thumbnailFrame = self.imageView.convert(self.imageView.bounds, to: destinationView)
            return (transitionView, thumbnailFrame)
        })
        browser.pageIndicator = JXPhotoBrowserNumberPageIndicator()
        browser.pageIndex = 0
        browser.show()
    }
    
    public var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    func getImageName()->String {
        return ""
    }
    
    func getTitleArray()->[String] {
        return []
    }
    
    func getContentArray()->[String] {
        return []
    }
    
    lazy var bgView:UIView! = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = 200.0
        let x = (view.bounds.size.width - width) / 2
        imageView.frame = CGRect(x: x, y: 10, width: width, height: width)
        
        bgView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: CGRectGetMaxY(imageView.frame) + 10)
        view.addSubview(bgView)
        view.addSubview(imageView)

        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        let titles = getTitleArray()
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
        segmentedView.backgroundColor = .white
        segmentedView.layer.borderWidth = 0.5
        segmentedView.layer.borderColor = grayColor.cgColor
        
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

        segmentedView.frame = CGRect(x: 0, y: CGRectGetMaxY(imageView.frame) + 10, width: view.bounds.size.width, height: 45)
        listContainerView.frame = CGRect(x: 0, y: CGRectGetMaxY(segmentedView.frame), width: view.bounds.size.width, height: view.bounds.size.height - CGRectGetMaxY(segmentedView.frame))
    }
    func changeImageViewAtIndex(index:Int) {
        
    }
}


extension KNBaseReviewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
            changeImageViewAtIndex(index: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        changeImageViewAtIndex(index: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        changeImageViewAtIndex(index: index)
    }
}

extension KNBaseReviewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let contentArray = getContentArray()
        if index < contentArray.count {
            changeImageViewAtIndex(index: index)
            let controller = KNBaseContentViewController()
            controller.content = contentArray[index]
            return controller
        }
        return KNBaseContentViewController()
    }
}
