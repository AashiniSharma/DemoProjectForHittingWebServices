//
//  DemoProjectForHittingServicesVC.swift
//  SampleView
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class DemoProjectForHittingServicesVC: UIViewController {
    //MARK: properties
    var animalImagesArray = [ImageInfo]()
    var searchActive : Bool = false


    //MARK: IB OUtlets
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!

    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registering collection view cell
        let xib = UINib(nibName: "AnimalImagesClass", bundle: nil)
        mainCollectionView.register(xib, forCellWithReuseIdentifier: "AnimalImagesClassID")
        
        
        //setting delegates and datasources
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        self.searchBarOutlet.delegate = self
       
        //fetching images from web controller class
        fetchData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    
    func fetchData(){
        
            let query = searchBarOutlet.text

            WebController().fetchDataFromPixabay(withQuery: query!, success: { (images : [ImageInfo]) in
            
            self.animalImagesArray = images
            self.mainCollectionView.reloadData()
            
        }) { (error : Error) in
            
            
        }
    }
    
}


//MARK: collection view and search bar delagates nad datasources
extension DemoProjectForHittingServicesVC : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    //for fetching queries in search bar
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
                fetchData()
     
    }
    
     //returning number of items
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return animalImagesArray.count
        
    }
    
    //returning cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalImagesClassID", for: indexPath) as? AnimalImagesClass else { fatalError ("CELL NOT FOUND") }
        
        
        if let url = URL(string: animalImagesArray[indexPath.row].previewURL) {
            
            cell.animalImagesOutlet.af_setImage(withURL : url)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let expandedImagePage = self.storyboard?.instantiateViewController(withIdentifier: "ExpandableImageVCID") as? ExpandableImageVC else { return }
        
       expandedImagePage.imageUrl = URL(string: animalImagesArray[indexPath.row].webformatURL)
        
                self.navigationController!.pushViewController(expandedImagePage, animated: false)
    }
    
    //returning cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
  
  
}



