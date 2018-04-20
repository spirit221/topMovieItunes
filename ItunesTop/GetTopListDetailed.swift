//
//  GetTopListDetailed.swift
//  ItunesTop
//
//  Created by Sergey Gusev on 07.04.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class GetTopListDetailed {
    let searchUrl = "https://itunes.apple.com/lookup?id="
    typealias DictionaryJSON = [String:Any]
    var movies: [Films] = []
    func download(id: String, finished: @escaping ((String)->Void)){
        guard let jsonURL = URL(string: searchUrl + id) else {
            print("error in name")
            return
        }
        Alamofire.request(jsonURL).responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonStart = response.result.value as? DictionaryJSON,
                    let jsonMid = jsonStart["results"] as? [DictionaryJSON] else { return }
                let description = jsonMid[0]["longDescription"] as? String ?? "No Description"
                finished(description)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
