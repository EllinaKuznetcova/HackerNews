//
//  Comment.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

class Comment {
    var id: Int = 0
    var text: String = ""
    var author: String = ""
    var publishAt: Date = Date()
    var replies: [Comment] = []
}
