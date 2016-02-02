//
//  PhotosDetailViewController.swift
//  Instagram
//
//  Created by Che Chao Hsu on 1/30/16.
//  Copyright © 2016 Che Chao Hsu. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {

    @IBOutlet weak var PhotoDetailImageView: UIImageView!
    
    var gram = NSDictionary!()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup ater loading the view.
        let gramsPath = gram.valueForKeyPath("images.standard_resolution.url") as? String
        let imageUrl = NSURL(string: gramsPath!)
        PhotoDetailImageView.setImageWithURL(imageUrl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
