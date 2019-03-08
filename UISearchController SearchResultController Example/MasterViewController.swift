//
//  ViewController.swift
//  UISearchController SearchResultController Example
//
//  Created by Arifin Firdaus on 3/8/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit
import SnapKit

class MasterViewController: UIViewController {
    
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
    
    fileprivate let cellId = "cellId"
    
    fileprivate let items = ["Hello world", "Adam", "SnapKit", "The Power of Habit", "Snake", "Heire", "The Popeye", "Adi"]
    fileprivate var foundItems = [String]()
    
    fileprivate var resultsController: UITableViewController?
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
        title = "Master"
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .blue
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        setupSearchBarButtonItem()
    }
    
    fileprivate func setupSearchBarButtonItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc fileprivate func search() {
        resultsController = UITableViewController(style: .plain)
        resultsController?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        resultsController?.tableView.dataSource = self
        resultsController?.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        present(searchController, animated: true, completion: nil)
        
        definesPresentationContext = true
    }
}


// MARK: - UITableViewDataSource

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView
            ? items.count
            : foundItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            let item = items[indexPath.row]
            cell.textLabel?.text = item
            return cell
        }
        else {
            if foundItems.isEmpty {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            let item = foundItems[indexPath.row]
            cell.textLabel?.text = item
            return cell
        }
    }
    
}


// MARK: - UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = ""
        if self.searchController.isActive {
            item = foundItems[indexPath.row]
            searchController.dismiss(animated: true) {
                self.showDetail(withItem: item)
            }
        } else {
            item = items[indexPath.row]
        }
        showDetail(withItem: item)
    }
    
    fileprivate func showDetail(withItem item: String) {
        let viewController = DetailViewController(withItem: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


// MARK: - UISearchResultsUpdating

extension MasterViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        updateSearchResultsForText(text)
    }
    
    fileprivate func updateSearchResultsForText(_ text: String) {
        foundItems.removeAll()
        for item in items {
            if item.localizedCaseInsensitiveContains(text) {
                foundItems.append(item)
                self.resultsController?.tableView.reloadData()
            }
        }
    }
    
    
}

