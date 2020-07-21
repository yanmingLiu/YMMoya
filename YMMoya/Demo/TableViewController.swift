//
//  TableViewController.swift
//  YMMoya
//
//  Created by ym L on 2020/7/17.
//  Copyright © 2020 ym L. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var list = [
        [
            "vc": "ListController",
            "name": "列表"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "moya - handyJson"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = list[indexPath.row]["name"]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vcName = list[indexPath.row]["vc"] else { return }
        
        // 1.获取命名空间
        guard let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return
        }
        // 2.获取Class
        let vcCls: AnyClass? = NSClassFromString(name + "." + vcName)
        guard let tyleCls = vcCls as? UIViewController.Type else {
            return
        }
        // 3.创建vc
        let vc = tyleCls.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
