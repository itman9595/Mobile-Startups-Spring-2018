//
//  Gold.swift
//  Pixabay2
//
//  Created by Muratbek Bauyrzhan on 4/15/18.
//  Copyright © 2018 Quellebis. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class Gold: UIViewController {
    @IBOutlet var imagesButton: UIButton!
    @IBOutlet var videosButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    var images: [Image] = []
    var videos: [Video] = []
    var favourites: [(imageURL: String, mediumVideoURL: String, tags: String)] = []
    var isSearchImages = true
    var currentQuery = ""
    let blueColor = UIColor.init(red: 122/255, green: 137/255, blue: 255/255, alpha: 1)
    var activeCollectionView: UICollectionView!
    
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
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        
        activeCollectionView = collectionView
        
        let showFavouritesBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        showFavouritesBtn.setBackgroundImage(UIImage(named: "favourite"), for: .normal)
        showFavouritesBtn.addTarget(self, action: #selector(Gold.showFavourites), for: .touchUpInside)
        
        let showFavouritesBarBtn = UIBarButtonItem(customView: showFavouritesBtn)
        let showFavouritesBarBtnWidth = showFavouritesBarBtn.customView?.widthAnchor.constraint(equalToConstant: 24)
        showFavouritesBarBtnWidth?.isActive = true
        let showFavouritesBarBtnHeight = showFavouritesBarBtn.customView?.heightAnchor.constraint(equalToConstant: 24)
        showFavouritesBarBtnHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = showFavouritesBarBtn
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let defaults = UserDefaults.standard
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        
    }
    
    func showFavourites() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if (activeCollectionView == collectionView) {
            UIView.animate(withDuration: 0.75, animations: {
                self.favouritesCollectionView.alpha = 1
            }, completion: { (finished) in
                self.favouritesCollectionView.reloadData()
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
                self.navigationItem.searchController?.searchBar.isUserInteractionEnabled = false
                self.activeCollectionView = self.favouritesCollectionView
            })
        } else {
            UIView.animate(withDuration: 0.75, animations: {
                self.favouritesCollectionView.alpha = 0
            }, completion: { (finished) in
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
                self.navigationItem.searchController?.searchBar.isUserInteractionEnabled = true
                self.activeCollectionView = self.collectionView
                if (self.imagesButton.backgroundColor == self.blueColor) {
                    self.isSearchImages = true
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var defaults = UserDefaults.standard
        if let link = defaults.string(forKey: "tags") {
            favourites.append((imageURL: defaults.string(forKey: "imageURL")!, mediumVideoURL: defaults.string(forKey: "mediumVideoURL") ?? "", tags: defaults.string(forKey: "tags") ?? ""))
            let domain = Bundle.main.bundleIdentifier!
            defaults.removePersistentDomain(forName: domain)
            defaults.synchronize()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailsSegue") {
            let vc = segue.destination as! GoldDetailsViewController
            let indexPath = activeCollectionView!.indexPathsForSelectedItems![0]
            
            if (activeCollectionView == collectionView) {
                vc.hideAddFavBtn = false
                if (isSearchImages) {
                    vc.imageURL = self.images[indexPath.row].webformatURL
                    vc.tags = self.images[indexPath.row].tags
                } else {
                    vc.mediumVideoURL = self.videos[indexPath.row].mediumVideoURL
                    vc.imageURL = self.videos[indexPath.row].previewURL
                    vc.tags = self.videos[indexPath.row].tags
                }
            } else {
                vc.hideAddFavBtn = true
                if (isSearchImages) {
                    vc.imageURL = self.favourites[indexPath.row].imageURL
                    vc.tags = self.favourites[indexPath.row].tags
                } else {
                    vc.mediumVideoURL = self.favourites[indexPath.row].mediumVideoURL
                    vc.imageURL = self.favourites[indexPath.row].imageURL
                    vc.tags = self.favourites[indexPath.row].tags
                }
            }
            
            vc.isImage = isSearchImages
        }
    }
    
}

extension Gold: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        
        let trimmedString = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmedString != "") {
            self.currentQuery = trimmedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            getData(query: self.currentQuery)
        }
    }
}

extension Gold: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (activeCollectionView == favouritesCollectionView) {
            return favourites.count
        }
        
        if (isSearchImages) {
            return self.images.count
        }
        
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CustomImageCollectionViewCell
        
        var url: URL
        
        if (activeCollectionView == self.collectionView) {
            if (isSearchImages) {
                url = URL(string: self.images[indexPath.item].previewURL)!
            } else {
                url = URL(string: self.videos[indexPath.item].previewURL)!
            }
        } else {
            let link = favourites[indexPath.row].imageURL
            url = URL(string: link)!
        }
        
        cell.previewImageView.sd_setImage(with: url, completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (activeCollectionView == favouritesCollectionView) {
            if (favourites[indexPath.row].mediumVideoURL.count == 0) { // it is image
                isSearchImages = true
            } else {
                isSearchImages = false
            }
        }
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
}



