//
// Created by Arifin Firdaus on 2019-03-10.
// Copyright (c) 2019 Arifin Firdaus. All rights reserved.
//

import UIKit

class DownloadService {

    func downloadImageFromUrl(urlString string: String, completion: @escaping ((Data?) -> Void)) {
        let url = URL(string: string)
        URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let _ = error {
                completion(nil)
                return
            }
            if let data = data {
                completion(data)
            }
        }.resume()
    }

}