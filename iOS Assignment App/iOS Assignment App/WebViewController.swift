//
//  WebViewController.swift
//  iOS Assignment App
//
//  Created by Lyubomir Lichev.
//  Copyright © 2017 Lyubomir Lichev. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string:url!)!))
    }
}
