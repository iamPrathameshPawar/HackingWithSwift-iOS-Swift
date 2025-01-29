//
//  ViewController.swift
//  Project4
//
//  Created by Prathamesh Pawar on 6/25/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {


    @IBOutlet weak var web_view: WKWebView!
    
    var progressView: UIProgressView!
    
    
    ///WKWebView :  Class provided by WebKit framework that allows you to embed web content (such as web pages) in your app.
    ///This line just declares the variable webView which will be of type 'WKWebView'
//    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        ///This line initialise the earlier created variable webView with new object of a class WKWebView( )
        ///and :- creates the actual object that can be used.
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        web_view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: web_view, action: #selector(web_view.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton,spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        web_view.addObserver(self, forKeyPath: #keyPath(web_view.estimatedProgress), options: .new, context: nil)
        
        web_view.navigationDelegate = self
        let url = URL(string: "https://www.apple.com")!
        web_view.load(URLRequest(url: url))
        web_view.allowsBackForwardNavigationGestures = true
        
        
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "docs.swift.org", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
//        let url = URL(string: "https://" + action.title!)!
        
        guard let title = action.title, let url = URL(string: "https://" + title) else {
            print("Invalid URL..!")
            return
        }
        web_view.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func obser
}

