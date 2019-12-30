//
//  APIEndPoint.swift
//  EngieerAiTest_Vidhi
//
//  Created by MAC105 on 30/12/19.
//  Copyright © 2019 MAC105. All rights reserved.
//

import Foundation

let BASEURL : String = "https://hn.algolia.com/api/"

struct API {
    static func getUserPost(pageNumber : Int) -> String{
        return BASEURL+"v1/search_by_date?tags=story&page=\(pageNumber)"
    }
}
