//
//  ItemLista.swift
//  dafiti
//
//  Created by Antonio De Souza on 29/10/15.
//  Copyright © 2015 Antonio De Souza. All rights reserved.
//

import UIKit

class ItemLista: UITableViewCell {

    
    @IBOutlet
    var img: UIImageView!
    var name: UILabel!
    var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setobj(data:NSDictionary)
    {
        
        name.text? = data["name"] as! String
        value.text? = ( data["salePrice"] as! NSNumber ).stringValue
        
        if let url = NSURL(string: data["thumbnailImage"] as! String) {
            if let data = NSData(contentsOfURL: url){
                img.contentMode = UIViewContentMode.ScaleAspectFit
                img.image = UIImage(data: data)
            }
        }
        
    }
    
}
