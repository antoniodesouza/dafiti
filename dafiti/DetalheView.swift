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
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var viewdetalhe: UIView!
    
    
    
    var data : NSDictionary!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text? = self.data["name"] as! String
        self.value.text? = ( data["salePrice"] as! NSNumber ).stringValue
        self.longdescription.text? = self.data["longDescription"] as! String
        
        
        self.viewdetalhe.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height * 1.5 )
        
        
        self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        self.scrollView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        
        
        
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
