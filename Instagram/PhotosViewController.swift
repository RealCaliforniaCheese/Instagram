//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Che Chao Hsu on 1/21/16.
//  Copyright © 2016 Che Chao Hsu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var grams: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 320
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.grams = responseDictionary["data"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
}


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If movies is not nil, assign to const movies
        if let grams = grams {
            return grams.count
        }
        else {
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableCell", forIndexPath: indexPath) as! PhotoTableCell
        
        let gram = grams![indexPath.row]
        
        //    cell.titleLabel.text = title
        //    cell.overviewLabel.text = overview
        
        // let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let gramsPath = gram.valueForKeyPath("images.low_resolution.url") as? String
        let imageUrl = NSURL(string: gramsPath!)
        cell.photoView.setImageWithURL(imageUrl!)
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}