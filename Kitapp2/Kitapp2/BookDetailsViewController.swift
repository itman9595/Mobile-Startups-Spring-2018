//
//  BookDetailsViewController.swift
//  Kitapp2
//
//  Created by Muratbek Bauyrzhan on 4/9/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import SDWebImage

class BookDetailsViewController: UIViewController {

    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookAuthorsLabel: UILabel!
    @IBOutlet var bookDescriptionTextView: UITextView!
    var thumbnail: URL?
    var bookTitle: String?
    var bookAuthors: [String]?
    var authors: String?
    var bookDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bookImageView.sd_setImage(with: thumbnail)
        bookTitleLabel.text = bookTitle
        authors = ""
        for case let author in
            bookAuthors! {
            if author == bookAuthors?.last {
                authors?.append(author)
            } else {
                authors?.append(author + ", ")
            }
        }
        bookAuthorsLabel.text = authors
        bookAuthorsLabel.sizeToFit()
        bookDescriptionTextView.text = bookDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
