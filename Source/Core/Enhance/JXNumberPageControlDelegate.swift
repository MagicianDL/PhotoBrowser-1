//
//  JXNumberPageControlDelegate.swift
//  JXPhotoBrowser
//
//  Created by JiongXing on 2018/10/15.
//

import Foundation

/// 实现了以 数字型 为页码指示器的 Delegate.
open class JXNumberPageControlDelegate: JXPhotoBrowserBaseDelegate {
    
    /// 字体
    open var font = UIFont.systemFont(ofSize: 17)
    
    /// 字颜色
    open var textColor = UIColor.white
    
    /// 可指定中心点Y坐标。默认值：iPhoneX为40，非iPhoneX为20
    open var centerY: CGFloat = {
        if #available(iOS 11.0, *) {
            return 40
        }
        return 20
    }()
    
    /// 数字页码指示
    open lazy var pageControl: UILabel = {
        let view = UILabel()
        view.font = font
        view.textColor = textColor
        return view
    }()
    
    public override func photoBrowser(_ browser: JXPhotoBrowser, pageIndexDidChanged pageIndex: Int) {
        super.photoBrowser(browser, pageIndexDidChanged: pageIndex)
        layout()
    }
    
    public override func photoBrowserViewDidLayoutSubviews(_ browser: JXPhotoBrowser) {
        super.photoBrowserViewDidLayoutSubviews(browser)
        layout()
    }
    
    public override func photoBrowser(_ browser: JXPhotoBrowser, viewDidAppear animated: Bool) {
        super.photoBrowser(browser, viewDidAppear: animated)
        // 页面出来后，再显示页码指示器
        // 多于一张图才添加到视图
        let totalPages = browser.itemsCount
        if totalPages > 1 {
            browser.view.addSubview(pageControl)
        }
    }
    
    public override func photoBrowserDidReloadData(_ browser: JXPhotoBrowser) {
        layout()
    }
    
    //
    // MARK: - Private
    //
    
    private func layout() {
        guard let browser = self.browser else {
            return
        }
        guard let superView = pageControl.superview else { return }
        let totalPages = browser.itemsCount
        pageControl.text = "\(browser.pageIndex + 1) / \(totalPages)"
        pageControl.sizeToFit()
        pageControl.center = CGPoint(x: superView.bounds.width / 2,
                                     y: centerY)
        pageControl.isHidden = totalPages <= 1
    }
}
