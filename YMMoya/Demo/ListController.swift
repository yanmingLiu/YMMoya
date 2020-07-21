//
//  ListController.swift
//  YMMoya
//
//  Created by ym L on 2020/7/17.
//  Copyright © 2020 ym L. All rights reserved.swiftformat --inferoptions "/path/to/your/code/"
//

import Moya
import UIKit
import HandyJSON
import Moya

class ListController: UITableViewController {
    var list: [Girl] = []
    var page = 1
    let refresh = UIRefreshControl()
    
    // 请求完成的闭包回调  @escaping (Result<Credential, Error>) -> Void
    // (_ result: Result<Moya.Response, MoyaError>) -> Void
    lazy var completionClosure: Completion = { result in
        switch result {
        case let .success(response):
            let list = response.mapArray(Girl.self, designatedPath: "data") as? [Girl] ?? []
            if (self.refresh.isRefreshing) {
                self.refresh.endRefreshing()
                self.list.append(contentsOf: list)
            } else {
                self.list = list
            }
            self.tableView.reloadData()
        case let .failure(erro):
            if erro.errorCode == 401 {
                print("登录失效")
            }
        }
    }
    
    private func loadData() {
        provider.request(.girls(params: ["page": page, "count": 10]), completion: completionClosure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        refresh.tintColor = .systemGray;
        refresh.attributedTitle = NSAttributedString(string: "下拉刷新");
        refresh.addTarget(self, action: #selector(refreshTabView), for: .valueChanged)
        tableView.refreshControl = refresh;

        refresh.beginRefreshing()
        refresh.sendActions(for: .valueChanged)

    }
    
    @objc func refreshTabView() {
        loadData()
    }
    
    @objc func add() {
        page += 1
        loadData()
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
        
        let m = list[indexPath.row]
        cell.textLabel?.text = "\(m.title ?? "") - \(m.desc ?? "")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
