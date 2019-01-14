//
//  Refreshable.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/29.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

enum YBRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

/* ============================ OutputRefreshProtocol ================================ */
// viewModel 中 output使用
protocol OutputRefreshProtocol {
     // 告诉外界tableView当前刷新状态
    var refreshStatus: Variable<YBRefreshStatus> {get}
}

extension OutputRefreshProtocol {
    
    func autoSetRefreshHeaderStatus(header: MJRefreshHeader?, footer: MJRefreshFooter?) -> Disposable {
        
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                 footer?.beginRefreshing()
            case .endFooterRefresh:
                 footer?.endRefreshing()
            case .noMoreData:
                 footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
         })
        }
    }

/* ============================ Refreshable ================================ */
// 需要使用 MJExtension 的控制器使用

protocol Refreshable {
    
}
extension Refreshable where Self : UIViewController {
    
    func initRefreshHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader {
        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { action() })
        return scrollView.mj_header
    }
    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter {
        scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { action() })
        return scrollView.mj_footer
    }
    
}

extension Refreshable where Self : UIScrollView {
    
    func initRefreshHeader(_ action: @escaping () -> Void) -> MJRefreshHeader {
        mj_header = MJRefreshNormalHeader(refreshingBlock: {action()})
        return mj_header
    }
    
    func initRefreshFooter(_ action: @escaping () -> Void) -> MJRefreshFooter {
        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {action()})
        return mj_footer
    }
    
}






