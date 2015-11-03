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
    var tabela: UITableView!
    var items: NSArray = []
    var refreshControl: UIRefreshControl?

    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self,
            action: "handleRefresh:",
            forControlEvents: .ValueChanged)
        
        
        
        
        self.tabela.addSubview(refreshControl!)
        self.CarregarJSON()
        

    }
    
    
    
    
    func CarregarJSON()
    {
    
        
        
        let apiURL : NSURL = NSURL(string:"https://api.bestbuy.com/v1/products((search=macbook)&manufacturer=apple)?apiKey=aw732yexbxrfqcxdy2cjw94q&sort=name.asc&show=sku,name,salePrice,manufacturer,image,thumbnailImage,longDescription,shortDescription&pageSize=15&page=2&callback=&format=json")!
        
        
        let apijson = NSURLSession.sharedSession().dataTaskWithURL(apiURL, completionHandler: {(data, reponse, error) in
            
            let jsonResults : AnyObject
            
            do {
                jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                self.items = jsonResults["products"] as! NSArray                
                //self.tabela.reloadData()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tabela.reloadData()
                    
                });
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        })
        
        apijson.resume()
        
    }

    
    func handleRefresh(paramSender: AnyObject){
        
        //self.tabela.reloadData();
        self.refreshControl!.endRefreshing()
        
        /*
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(popTime,
            dispatch_get_main_queue(), {
                
                self.allTimes.append(NSDate())
                self.refreshControl!.endRefreshing()
                let indexPathOfNewRow = NSIndexPath(forRow: self.allTimes.count - 1,
                    inSection: 0)
                
                self.tableView!.insertRowsAtIndexPaths([indexPathOfNewRow],
                    withRowAnimation: .Automatic)
                
        })

        */
        
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





