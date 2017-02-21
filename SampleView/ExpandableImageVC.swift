//
//  ExpandableImage.swift
//  SampleView
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ExpandableImageVC: UIViewController {
    
    //MARK: properties
    var imageUrl : URL!

    //MARK: IB Outlets
    @IBOutlet weak var expandedImage: UIImageView!
    
   //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewWillLayoutSubviews() {
        
        expandedImage.af_setImage(withURL : imageUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
