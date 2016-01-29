//
//  PhotoTableCell.swift
//  Instagram
//
//  Created by Che Chao Hsu on 1/21/16.
//  Copyright © 2016 Che Chao Hsu. All rights reserved.
//

import UIKit

class PhotoTableCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
