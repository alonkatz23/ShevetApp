//
//  CustomArticleCell.swift
//  Shevet Hamifratz
//
//  Created by Alon Katz on 1/25/18.
//  Copyright © 2018 Shevet Hamifratz. All rights reserved.
//

import UIKit

class CustomArticleCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
