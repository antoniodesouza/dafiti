//
//  ViewController.swift
//  dafiti
//
//  Created by Antonio De Souza on 29/10/15.
//  Copyright © 2015 Antonio De Souza. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet
    weak var tabela: UITableView!
    var items: NSArray = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabela.dataSource = self
        self.tabela.delegate = self
        
        
        
        let apiURL : NSURL = NSURL(string:"https://api.bestbuy.com/v1/products((search=macbook)&manufacturer=apple)?apiKey=aw732yexbxrfqcxdy2cjw94q&sort=name.asc&show=sku,name,salePrice,manufacturer,image,thumbnailImage,longDescription,shortDescription&pageSize=15&page=2&callback=&format=json")!
        
        
        let apijson = NSURLSession.sharedSession().dataTaskWithURL(apiURL, completionHandler: {(data, reponse, error) in
            
            let jsonResults : AnyObject
            
            do {
                jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                self.items = jsonResults["products"] as! NSArray
                self.tabela.reloadData()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        })
        
        self.tabela.reloadData()
        apijson.resume()
        

    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            let cell : ItemLista = self.tabela.dequeueReusableCellWithIdentifier("Cell") as! ItemLista
            
            cell.setobj(self.items[indexPath.row] as! NSDictionary)
            
            return cell
            
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        //self.item = self.items[indexPath.row] as! NSDictionary
        //let next = self.storyboard?.instantiateViewControllerWithIdentifier("DetalheView") as! DetalheView
        //self.presentViewController(next, animated: true, completion: nil)
        
        
        //let view : DetalheView = self.storyboard?.instantiateViewControllerWithIdentifier("DetalheView") as! DetalheView
        //view.modalPresentationStyle = UIModalPresentationStyle.PageSheet
        //view.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        //self.navigationController?.pushViewController(view, animated: true)
        
        
        
        let view : DetalheView = self.storyboard?.instantiateViewControllerWithIdentifier("DetalheView") as! DetalheView
        view.data = self.items[indexPath.row] as! NSDictionary
        self.navigationController?.pushViewController(view, animated: true)
        
        
        
    }
    
    
    
    
}





