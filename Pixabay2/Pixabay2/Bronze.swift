//
//  Bronze.swift
//  Pixabay2
//
//  Created by Muratbek Bauyrzhan on 4/15/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class Bronze: UIViewController {
    @IBOutlet var imagesButton: UIButton!
    @IBOutlet var videosButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var images: [Image] = []
    var videos: [Video] = []
    var isSearchImages = true
    var currentQuery = ""
    let blueColor = UIColor.init(red: 122/255, green: 137/255, blue: 255/255, alpha: 1)
    
    @IBAction func onImagesButtonClicked(_ sender: UIButton) {
        isSearchImages = true
        imagesButton.backgroundColor = blueColor
        imagesButton.setTitleColor(UIColor.white, for: .normal)
        
        videosButton.backgroundColor = UIColor.white
        videosButton.setTitleColor(blueColor, for: .normal)
        
        if (currentQuery != "") {
            getData(query: currentQuery)
            
        }
    }
    
    @IBAction func onVideosButtonClicked(_ sender: UIButton) {
        isSearchImages = false
        videosButton.backgroundColor = blueColor
        videosButton.setTitleColor(UIColor.white, for: .normal)
        
        imagesButton.backgroundColor = UIColor.white
        imagesButton.setTitleColor(blueColor, for: .normal)
        
        if (currentQuery != "") {
            getData(query: currentQuery)
            
        }
    }
    
    func getData(query: String) {
        self.images = []
        self.videos = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        if (isSearchImages) {
            searchImages(query: query)
        } else {
            searchVideos(query: query)
        }
        
    }
    
    func searchVideos(query: String) {
        let url = URL(string: "https://pixabay.com/api/videos/?key=8803359-95f5c074846330b203e19eb57&q=\(query)&pretty=true")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print("error", error)
            } else {
                let json = JSON(data)
                if let hits = json["hits"].arrayObject {
                    for hit in hits {
                        let hit = JSON(hit);
                        let previewURL = "https://i.vimeocdn.com/video/\(hit["picture_id"].string!)_640x360.jpg"
                        let mediumVideoURL = hit["videos"]["medium"]["url"].string!
                        let tags = hit["tags"].string!
                        
                        let video = Video(previewURL: previewURL, mediumVideoURL: mediumVideoURL, tags: tags)
                        
                        self.videos.append(video)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            }
            }.resume()
    }
    
    func searchImages(query: String) {
        let url = URL(string: "https://pixabay.com/api/?key=8803359-95f5c074846330b203e19eb57&q=\(query)&image_type=photo&pretty=true")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print("error", error)
            } else {
                let json = JSON(data)
                if let hits = json["hits"].arrayObject {
                    for hit in hits {
                        let hit = JSON(hit);
                        let previewURL = hit["previewURL"].string!
                        let webformatURL = hit["webformatURL"].string!
                        let tags = hit["tags"].string!
                        
                        let image = Image(previewURL: previewURL, webformatURL: webformatURL, tags: tags)
                        
                        self.images.append(image)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagesButton.layer.borderColor = blueColor.cgColor
        imagesButton.layer.borderWidth = 1
        
        videosButton.layer.borderColor = blueColor.cgColor
        videosButton.layer.borderWidth = 1
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailsSegue") {
            let vc = segue.destination as! BronzeDetailsViewController
            let indexPath = self.collectionView!.indexPathsForSelectedItems![0]
            
            if (isSearchImages) {
                let imageURL = self.images[indexPath.row].webformatURL
                vc.imageURL = imageURL
                
                let tags = self.images[indexPath.row].tags
                vc.tags = tags
            } else {
                let mediumVideoURL = self.videos[indexPath.row].mediumVideoURL
                vc.mediumVideoURL = mediumVideoURL
                
                let imageURL = self.videos[indexPath.row].previewURL
                vc.imageURL = imageURL
                
                let tags = self.videos[indexPath.row].tags
                vc.tags = tags
            }
            
            vc.isImage = isSearchImages
        }
    }
    
}

extension Bronze: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        
        let trimmedString = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmedString != "") {
            self.currentQuery = trimmedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            getData(query: self.currentQuery)
        }
    }
}

extension Bronze: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isSearchImages) {
            return self.images.count
        }
        
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CustomImageCollectionViewCell
        
        var url: URL
        if (isSearchImages) {
            url = URL(string: self.images[indexPath.item].previewURL)!
        } else {
            url = URL(string: self.videos[indexPath.item].previewURL)!
        }
        
        cell.previewImageView.sd_setImage(with: url, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
}

