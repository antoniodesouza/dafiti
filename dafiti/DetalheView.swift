//
//  DetalheView.swift
//  dafiti
//
//  Created by Antonio De Souza on 30/10/15.
//  Copyright © 2015 Antonio De Souza. All rights reserved.
//

import UIKit

class DetalheView: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var img: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var value: UILabel!
    @IBOutlet var longdescription: UITextView!
    @IBOutlet var scrollView : UIScrollView!
    
    
    var data : NSDictionary!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
        //scrollView.contentSize = self.view.bounds.size
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        //scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        

        self.navigationController?.setToolbarHidden(false, animated: false)
        self.name.text? = self.data["name"] as! String
        self.value.text? = ( data["salePrice"] as! NSNumber ).stringValue
        self.longdescription.text? = self.data["longDescription"] as! String
        
        let imgurl : String = ( self.data["image"] as! String ).stringByReplacingOccurrencesOfString("_sc", withString: "_sa")
        
        if let url = NSURL(string: imgurl) {
            if let data = NSData(contentsOfURL: url){
                self.img.contentMode = UIViewContentMode.ScaleAspectFit
                self.img.image = UIImage(data: data)
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
