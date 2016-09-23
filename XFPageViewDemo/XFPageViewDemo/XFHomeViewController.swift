//
//  XFHomeViewController.swift
//  XFPageViewDemo
//
//  Created by xiaofans on 16/9/23.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class XFHomeViewController: UIViewController {
    
    // MARK:- 懒加载
    fileprivate lazy var pageTitleView: XFPageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["热门", "社会", "科技", "旅游"]
        let titleView = XFPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView: XFPageContentView = {[weak self] in
        // 1. 确定内容 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: contentH)
        // 2. 确定所有控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = XFPageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI 界面
        setUpUI()
    }

}


// MARK:- 设置 UI
extension XFHomeViewController {
    fileprivate func setUpUI() {
        // 0. 不允许系统调整 scrollview 内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 添加 titleview
        view.addSubview(pageTitleView)
        
        // 2. 添加 contentview
        view.addSubview(pageContentView)
    }
}

// MARK:- pageTitleViewDelegate
extension XFHomeViewController: XFPageTitleViewDelegate {
    func pageTitleView(pageTitleView: XFPageTitleView, didSelectedIndex index: Int) {
        pageContentView.scrollToIndex(index: index)
    }
}

// MARK:- pageContentViewDelegate
extension XFHomeViewController: XFPageContentViewDelegate {
    func pageContentView(pageContentView: XFPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgerss(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}




















