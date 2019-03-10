//
// Created by Arifin Firdaus on 2019-03-10.
// Copyright (c) 2019 Arifin Firdaus. All rights reserved.
//

import UIKit
import SnapKit

class Master2ViewControlller: UIViewController {

    fileprivate let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()

    fileprivate let cellId = "cellId"

    fileprivate var items = ["Hello world", "Adam", "SnapKit", "The Power of Habit", "Snake", "Heire", "The Popeye", "Adi"]
    fileprivate var foundItems = [String]()

    fileprivate var resultsController: Master2ResultController?
    fileprivate var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCell()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    fileprivate func setupCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    fileprivate func setupNavBar() {
        title = "Master 2"

        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .blue
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        setupSearchBarButtonItem()
    }

    fileprivate func setupSearchBarButtonItem() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItems = [searchItem]
    }

    @objc fileprivate func search() {
        resultsController = Master2ResultController(style: .plain)
        resultsController?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        resultsController?.tableView.delegate = self

        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        present(searchController, animated: true, completion: nil)

        definesPresentationContext = true
    }

    @objc fileprivate func showMaster2() {

    }
}


// MARK: - UITableViewDataSource

extension Master2ViewControlller: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }

}


// MARK: - UITableViewDelegate

extension Master2ViewControlller: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = ""
        if self.searchController.isActive {
            guard let resultController = resultsController else {
                return
            }
            item = resultController.filteredItems[indexPath.row]
            searchController.dismiss(animated: true) {
                self.showDetail(withItem: item)
            }
        } else {
            item = items[indexPath.row]
            showDetail(withItem: item)
        }
    }

    fileprivate func showDetail(withItem item: String) {
        let viewController = DetailViewController(withItem: item)
        navigationController?.pushViewController(viewController, animated: true)
    }

}


// MARK: - UISearchResultsUpdating

extension Master2ViewControlller: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        updateSearchResultsForText(text)
    }

    fileprivate func updateSearchResultsForText(_ text: String) {
        foundItems.removeAll()
        for item in items {
            if item.localizedCaseInsensitiveContains(text) {
                foundItems.append(item)
                self.resultsController?.filteredItems = foundItems
                self.resultsController?.tableView.reloadData()
            }
        }
    }


}