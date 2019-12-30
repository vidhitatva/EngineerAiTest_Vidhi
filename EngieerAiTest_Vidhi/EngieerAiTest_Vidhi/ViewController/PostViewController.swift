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
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPost()
        // Do any additional setup after loading the view.
    }
    
    private func prepareView() {
        self.title = "No post selected."
        self.tableViewPost.addInfiniteScroll { (table) in
            table.finishInfiniteScroll()
        }
        self.tableViewPost.refreshControl = refreshControl
        self.tableViewPost.refreshControl?.addTarget(self, action: #selector(refreshPost), for: .valueChanged)
    }
    
    //MARK: Methods
    private func getPost(pageNumber : Int = 1) {
        PostController.share.getPost(pageNumber) { (allPost) in
            if let allHits = allPost.hits {
                if pageNumber == 1 {
                    self.arrayHits.removeAll()
                }
                self.arrayHits.append(contentsOf: allHits)
                self.tableViewPost.reloadData()
            }
        }
    }
    
    @objc private func refreshPost() {
        self.getPost()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell", for: indexPath) as! PostTableCell
        cell.postHit = self.arrayHits[indexPath.row]
        return cell
    }
}
