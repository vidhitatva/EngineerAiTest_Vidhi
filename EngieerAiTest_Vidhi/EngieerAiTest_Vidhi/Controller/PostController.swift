//
//  PostController.swift
//  EngieerAiTest_Vidhi
//
//  Created by MAC105 on 30/12/19.
//  Copyright © 2019 MAC105. All rights reserved.
//

import Foundation

final class PostController {
    static let share : PostController = PostController()
    
    func getPost(_ page : Int,completion:@escaping(_ post : Post) -> Void) {
        RequestManager.share.requestWithGet(API.getUserPost(pageNumber: page)) { (status, result, message) in
            if status {
                let allPost = try? JSONDecoder().decode(Post.self, from: result)
                if let listPost = allPost {
                    completion(listPost)
                }
            }
        }
    }
}
