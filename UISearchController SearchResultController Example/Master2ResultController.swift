//
// Created by Arifin Firdaus on 2019-03-10.
// Copyright (c) 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

/* For customizing cell, need to create custom table result controller and it's cell to avoid bloated code */
class Master2ResultController: UITableViewController {

    fileprivate let cellId = "Master2ResultControllerCellId"

    var filteredItems = [String]();

    override init(style: UITableView.Style) {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        setupTableView()
    }

    fileprivate func setupCell() {
        tableView.register(Master2ResultCell.self, forCellReuseIdentifier: cellId)
    }

    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Master2ResultCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! Master2ResultCell
        let item = filteredItems[indexPath.row]
        cell.textLabel?.text = item
        cell.detailTextLabel?.text = "\(item) by arifinfrds"
        return cell
    }
}
