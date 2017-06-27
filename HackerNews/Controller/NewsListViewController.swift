//
//  ViewController.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 06/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import UIKit
import DateToolsSwift

class NewsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {state in
            state.articles
        }
        
        store.dispatch(fetchTopStories)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell") as! NewsListCell
        let article = self.articles[indexPath.row]
        cell.updateData(title: article.title, description: "\(article.score) points by \(article.author) \(article.publishedAt.timeAgoSinceNow)", comments: "\(article.comments.count) comments")
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {}

extension NewsListViewController: StoreSubscriber {
    
    func newState(state: [Article]) {
        self.articles = state
        self.tableView.reloadData()
    }
}

