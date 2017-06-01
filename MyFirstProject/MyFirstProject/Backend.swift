//
//  Backend.swift
//  MyFirstProject
//
//  Created by Siripong Sae-Zhang on 5/31/2560 BE.
//  Copyright © 2560 IndyZaLab. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

extension FeedViewController {
    func loadNews() {
        Alamofire.request("http://54.255.202.131/request/public/news?random=\(NSDate().timeIntervalSince1970)", method: .get, parameters:nil)
            .responseArray { (response: DataResponse<[News]>) in
                if response.result.isSuccess {
                    if let result = response.result.value {
                        self.newsArray = result
                    }
                    self.tableView.reloadData()
                }
        }
    }
}

extension FeedDetailViewController {
    func loadNewsDetail() {
        guard let id = self.news?.id else { return }
        Alamofire.request("http://54.255.202.131/request/public/news_content?random=\(NSDate().timeIntervalSince1970)", method: .get, parameters:["id":id])
            .responseObject { (response: DataResponse<NewsDetail>) in
                if response.result.isSuccess {
                    if let result = response.result.value {
                        self.news?.newsDetail = result
                        self.updateUIByNewsDetail()
                    }
                }
        }
    }
}




