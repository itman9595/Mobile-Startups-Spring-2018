//
//  Silver.swift
//  Kitapp2
//
//  Created by Muratbek Bauyrzhan on 4/9/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class Silver: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var bookTableView: UITableView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nothingFoundImageView: UIImageView!
    
    @IBAction func onSearchButtonPressed(_ sender: UIButton) {
        if (searchTextField.text?.characters.count != 0) {
            performAnimation()
            getBooks(bookTitle: searchTextField.text!)
        }
    }
    
    var highlightedIndexPath: IndexPath!
    
    var books: [[String: AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        searchTextField.layer.cornerRadius = 8
        searchButton.layer.cornerRadius = 8
        
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        searchTextField.delegate = self
        
        bookTableView.delegate = self as! UITableViewDelegate
        bookTableView.dataSource = self as! UITableViewDataSource
        
        bookTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getBooks(bookTitle: String) {
        let stringURL = "https://www.googleapis.com/books/v1/volumes?q='\(bookTitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        
        guard let url = NSURL(string: stringURL) else {
            return
        }
        
        let urlRequest = URLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                
                let json = JSON(data)
                
                if let items = json["items"].arrayObject {
                    self.books = items as! [[String: AnyObject]]
                    DispatchQueue.main.async {
                        self.nothingFoundImageView.alpha = 0
                    }
                } else {
                    DispatchQueue.main.async {
                        self.bookTableView.alpha = 0
                        self.nothingFoundImageView.alpha = 1
                    }
                }
                
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
                
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookDetails" {
            let cell = bookTableView.cellForRow(at: highlightedIndexPath) as! BookTableViewCell
            let dest = segue.destination as! BookDetailsViewController
            dest.thumbnail = cell.thumbnail
            dest.bookTitle = cell.bookTitleLabel.text
            dest.bookAuthors = cell.bookAuthors
            dest.bookDescription = cell.bookDescription
        }
    }
    
}

extension Silver: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        textField.layer.shadowRadius = 5
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text?.characters.count != 0) {
            performAnimation()
            getBooks(bookTitle: textField.text!)
        }
        return true
    }
    
    func performAnimation() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.75) {
            self.logoImageView.alpha = 0
            self.searchButton.alpha = 0
            self.searchTextField.frame.origin.y = 44
            self.bookTableView.alpha = 1
        }
    }
    
}

extension Silver: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        highlightedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        performSegue(withIdentifier: "BookDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String: AnyObject] {
            cell.bookTitleLabel.text = volumeInfo["title"] as? String
            cell.bookDescriptionLabel.text = volumeInfo["subtitle"] as? String
            cell.bookPagesCountLabel.text = "Количество страниц: \(volumeInfo["pageCount"] as! Int)"
            cell.bookAuthors = (volumeInfo["authors"] as? [String])!
            cell.bookDescription = volumeInfo["description"] as? String
            if let imageLinks = volumeInfo["imageLinks"] as? [String: AnyObject] {
                if let thumbnail = imageLinks["thumbnail"] as? String {
                    cell.thumbnail = URL(string: thumbnail)
                    cell.bookImageView.sd_setImage(with: URL(string: thumbnail))
                }
            }
        }
        return cell
    }
    
}
