//
//  NewsListCell.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 24/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

class NewsListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    func updateData(title: String, description: String, comments: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.commentsLabel.text = comments
    }
}
