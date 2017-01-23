//
//  MyProfileViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-23.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

// MARK:- 列表标题
let kMeSubScribe   = "我的订阅"
let kMePlayHistory = "播放历史"

let kMeHasBuy      = "我的已购"
let kMeWallet      = "我的钱包"

let kMeLXFStore    = "喜马拉雅商城"
let kMeStoreOrder  = "我的商城订单"
let kMeCoupon      = "我的优惠券"
let kMeGameenter   = "游戏中心"
let kMeSmartDevice = "智能硬件设备"

let kMeFreeTrafic  = "免流量服务"
let kMeFeedBack    = "意见反馈"
let kMeSetting     = "设置"
// 免流量服务 链接
let kFreeTraficURL = "http://hybrid.ximalaya.com/api/telecom/index?app=iting&device=iPhone&impl=com.gemd.iting&telephone=%28null%29&version=5.4.27"


let headerViewH: CGFloat = 288



class MyProfileViewController: BaseViewController {

    override var name: String {
        return "My profile"
    }
    
    
    // MARK:- 普通属性
    var lightFlag: Bool = true
    
    // MARK:- 懒加载属性
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: self.view.height - 49), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.hexInt(0xf3f3f3)
        self.view.addSubview(tableView)
        return tableView
        }()
    
    /// 列表标题数组
    lazy var titleArray:[[String]] = {
        return [[kMeSubScribe, kMePlayHistory],
                [kMeHasBuy, kMeWallet],
                [kMeLXFStore, kMeStoreOrder, kMeCoupon, kMeGameenter, kMeSmartDevice],
                [kMeFreeTrafic, kMeFeedBack, kMeSetting]]
    }()
    
    /// 列表图标数组
    lazy var imageArray:[[String]] = {
        return [["me_setting_favAlbum", "me_setting_playhis"],
                ["me_setting_boughttracks", "me_setting_account"],
                ["me_setting_store", "me_setting_myorder", "me_setting_coupon", "me_setting_game", "me_setting_device"],
                ["me_setting_union", "me_setting_feedback", "me_setting_setting"]]
    }()
    
    /// 头部视图
    lazy var headerView: MyProfileHeaderView = {
        let view = MyProfileHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: headerViewH))
        return view
    }()
    
    /// 状态栏
    lazy var statusBackView: UIView = { [unowned self] in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 20))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
        return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        automaticallyAdjustsScrollViewInsets = false
        /// 初始化
        setupView()
    }
    
    private func setupView() {
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: headerViewH))
        tableView.addSubview(headerView)
    }
}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: 数据源
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subTitleArr = titleArray[section]
        return subTitleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subTextArr = titleArray[indexPath.section]
        let imgArr = imageArray[indexPath.section]
        
        let cellID = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = subTextArr[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textColor = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 1.0)
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        cell?.imageView?.image = UIImage(named: imgArr[indexPath.row])
        
        return cell!
    }
    
    // MARK: 代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let title = cell?.textLabel?.text else {return}
        if title == kMeFreeTrafic { // 免流量服务
            jump2FreeTraficService()
        } else if title == kMeSetting { // 设置
            jump2Setting()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    private func jump2FreeTraficService() {
        /*
        guard let webVc = SVWebViewController(address: kFreeTraficURL) else {return}
        webVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webVc, animated: true)
        */
    }
    // MARK: 设置
    private func jump2Setting() {
        /*
        let settingVc = LXFSettingViewController()
        settingVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingVc, animated: true)
        */
    }
}
