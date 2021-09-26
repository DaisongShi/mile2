//
//  HomeViewController.swift
//  mile2
//
//  Created by Boqian Wen on 2021-04-04.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var SliderCollectionView: UICollectionView!
    
    @IBOutlet weak var PageView: UIPageControl!
    
    var imgArr = [UIImage(named: "dog1"),
                  UIImage(named: "dog2"),
                  UIImage(named: "dog3")]
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    let fileImg = [UIImage(named: "doge"),
                   UIImage(named: "img1"),
                   UIImage(named: "img2"),
                   UIImage(named: "img3")]
    
    let nameLbl = [("Eric"), ("VV"), ("Joseph"), ("Boss")]
    
    let postImg = [UIImage(named: "dog1"),
                   UIImage(named: "dog2"),
                   UIImage(named: "dog3"),
                   UIImage(named: "dog4")]
    
    let postTxt = [("description1"), ("description2"), ("description3"), ("description4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubviewToFront(PageView)
        
        PageView.currentPage = 0
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameLbl.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235;
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        as! HomePageTableViewCell
        cell.postImg.image = self.postImg[indexPath.row]
        cell.postTxt.text = self.postTxt[indexPath.row]
        cell.nameLbl.text = self.nameLbl[indexPath.row]
        cell.fileImg.image = self.fileImg[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func postTapped(_ sender: Any) {

    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomeCollectionViewCell
        cell?.img.image = imgArr[indexPath.row]

        return cell!
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = SliderCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
}
