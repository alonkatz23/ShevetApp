//
//  NewsletterCell.swift
//  
//
//  Created by Alon Katz on 1/25/18.
//

import UIKit

class CustomNewsletterCell: UITableViewCell {

    @IBOutlet var newsletterImageView: UIImageView!
    
    @IBOutlet var newsletterLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
