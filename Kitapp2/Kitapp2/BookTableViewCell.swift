//
//  BookTableViewCell.swift
//  Kitapp2
//
//  Created by Muratbek Bauyrzhan on 4/9/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookDescriptionLabel: UILabel!
    @IBOutlet var bookPagesCountLabel: UILabel!
    var thumbnail: URL?
    var bookAuthors: [String]?
    var bookDescription: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
