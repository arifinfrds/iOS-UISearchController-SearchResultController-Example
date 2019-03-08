//
//  DetailViewController.swift
//  UISearchController SearchResultController Example
//
//  Created by Arifin Firdaus on 3/8/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    fileprivate var item: String?
    
    init(withItem item: String) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = item
    }
    


}
