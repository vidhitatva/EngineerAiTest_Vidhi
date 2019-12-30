//
//  PostViewController.swift
//  EngieerAiTest_Vidhi
//
//  Created by MAC105 on 30/12/19.
//  Copyright © 2019 MAC105. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class PostViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet private weak var tableViewPost : UITableView!
    
    //MARK: Variable
    private var arrayHits : [Hits] = []
    private var refreshControl : UIRefreshControl = UIRefreshControl()
    private var isHasMore : Bool = true
    private var page : Int = 0

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Methods
    private func prepareView() {
        self.title = "No post selected."
        self.tableViewPost.addInfiniteScroll { (table) in
            table.finishInfiniteScroll()
            if self.isHasMore{
                self.getPost(pageNumber: self.page + 1)
            }
        }
        self.tableViewPost.refreshControl = refreshControl
        self.tableViewPost.refreshControl?.addTarget(self, action: #selector(refreshPost), for: .valueChanged)
        self.getPost()
        self.showNumberOfPostSelected()
    }
    private func showNumberOfPostSelected() {
        self.tableViewPost.reloadData()
        let selectedPost = self.arrayHits.filter { (hit) -> Bool in
            return hit.isActive
        }
        if selectedPost.count == 0 {
            self.title = "No post selected."
        }else if selectedPost.count == 1{
            self.title = "Number of post selected \(selectedPost.count)."
        }else {
            self.title = "Number of posts selected \(selectedPost.count)."
        }
    }
    private func getPost(pageNumber : Int = 1) {
        PostController.share.getPost(pageNumber) { (allPost) in
            if let allHits = allPost.hits {
                if pageNumber == 1 {
                    self.arrayHits.removeAll()
                }
                self.page = allPost.page!
                self.arrayHits.append(contentsOf: allHits)
                self.tableViewPost.reloadData()
                self.isHasMore = allPost.page! < allPost.nbPages!
                if !self.isHasMore{
                    self.tableViewPost.removeInfiniteScroll()
                }
            }
        }
    }
    @objc private func refreshPost() {
        self.getPost()
    }
}

extension PostViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayHits.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as! PostTableCell
        cell.postHit = self.arrayHits[indexPath.row]
        cell.changeNavigationTitle = { (hit) in
            self.arrayHits[indexPath.row] = hit
            self.showNumberOfPostSelected()
        }
        return cell
    }
}
