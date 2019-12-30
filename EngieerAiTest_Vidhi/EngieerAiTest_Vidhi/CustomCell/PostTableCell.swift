//
//  PostTableCell.swift
//  EngieerAiTest_Vidhi
//
//  Created by MAC105 on 30/12/19.
//  Copyright © 2019 MAC105. All rights reserved.
//

import UIKit

final class PostTableCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet private weak var labelPostTitle: UILabel!
    @IBOutlet weak var labelPostDate: UILabel!
    @IBOutlet weak var switchPostActiveInactive: UISwitch!
    var changeNavigationTitle :((Hits) -> Void)?
   
    //MARK: Varible
    var postHit : Hits! {
        didSet {
            if let hit = self.postHit {
                if let title = hit.title {
                    self.labelPostTitle.text = title
                }
                if let createDate = hit.created_at  {
                    let formate = DateFormatter()
                    formate.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
                    formate.timeZone = TimeZone.current
                    if let creDate = formate.date(from: createDate) {
                        formate.dateFormat = "E, d MMM yyyy hh:mm:ss a"
                        self.labelPostDate.text = formate.string(from: creDate)
                    }
                }
                self.switchPostActiveInactive.isOn = hit.isActive
            }
        }
    }

    //MARK: Methods
    @IBAction func switchActiveDeactivePost(_ sender: Any) {
        self.postHit.isActive = !self.postHit.isActive
        self.changeNavigationTitle?(self.postHit)
    }
}
