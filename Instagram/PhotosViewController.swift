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
    
/*
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init cells as FlixTablViewController to be DataSource and Delegate
        tableView.dataSource = self
        tableView.delegate = self

        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )

        // Initialize a UIView for Network Error   ableView.insertSubview(netErrControl, atIndex: 0)
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)


        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
        completionHandler: { (dataOrNil, response, error) in
        if let data = dataOrNil {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                NSLog("response: \(responseDictionary)")

                // Display HUD right before next request is made
                let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                progressHUD.labelText = "Loading..."
                self.movies = responseDictionary["results"] as! [NSDictionary]
                self.tableView.reloadData()
                progressHUD.hide(true, afterDelay: 0.5)
                self.networkErrorView.hidden = true
            }
        }
    });
    task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {

        // Make network request to fetch latest data

        // Do the following when the network request comes back successfully:
        // Update tableView data source
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
*/
    
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

 //   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   //     let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableCell", forIndexPath: indexPath) as! PhotoTableCell
     //   return cell
    //}

  //  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
  //  }
}


