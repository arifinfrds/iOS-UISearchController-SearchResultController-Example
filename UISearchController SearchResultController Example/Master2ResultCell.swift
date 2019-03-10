//
// Created by Arifin Firdaus on 2019-03-10.
// Copyright (c) 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

class Master2ResultCell: UITableViewCell {

    fileprivate let service = DownloadService()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        customsizeCell()
    }

    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func customsizeCell() {
        textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textLabel?.textColor = .darkGray

        detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        detailTextLabel?.textColor = .gray

        let url = "https://images.unsplash.com/photo-1552061210-b20d0df2e9dc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"
        service.downloadImageFromUrl(urlString: url) { data in
            if let data = data, let image = UIImage(data: data) {
                self.imageView?.image = image
            }
        }

    }
}
