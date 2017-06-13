//
//  FourthViewController.swift
//  iOS Assignment App
//
//  Created by Lyubomir Lichev.
//  Copyright © 2017 Lyubomir Lichev. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }

    func fetchArticles()
    {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=4d7a3e2b720d461caeb28e6204517e30")!)
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error != nil
            {
                 print("NO DATA FOUND")
                return
            }
            self.articles = [Article]()
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]]
                {
                    for articleFromJson in articlesFromJson
                    {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String
                        {
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.imageUrl = urlToImage
                            article.url = url
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
            }
            catch let error
            {
                print(error)
            }
        
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.articleTitle.text = self.articles?[indexPath.item].headline
        cell.articleDesc.text = self.articles?[indexPath.item].desc
        cell.articleAuthor.text = self.articles?[indexPath.item].author
        cell.articleImageView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        webVC.url = self.articles?[indexPath.item].url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}





