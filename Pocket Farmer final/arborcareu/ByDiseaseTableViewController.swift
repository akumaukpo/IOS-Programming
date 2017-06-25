//
//  ByDiseaseTableViewController.swift
//  arborcareu
//

//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

class ByDiseaseTableViewController: UITableViewController {

    
    var receivedDiseases :NSMutableArray?
    var scothDiseases  = NSMutableArray()
    var diseaseInfo = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scothDiseases.addObject("Drought Injury");
        scothDiseases.addObject("Fall Drop");
        scothDiseases.addObject("Frost Injury");
        scothDiseases.addObject("Winter Injury");
        scothDiseases.addObject("Cyclaneusma (=Naemacyclus) needlecast");
        scothDiseases.addObject("Pine needle rust");
        scothDiseases.addObject("Ploioderma needlecast");
        scothDiseases.addObject("Brown Spot Needle Blight");
        scothDiseases.addObject("Lophodermium Needlecast");
        scothDiseases.addObject("Phytophthora Root Rot");

      
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }



    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       
        return 1;
    }
    
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(receivedDiseases != nil){
            return receivedDiseases!.count;
        }
            
        else{
                return self.scothDiseases.count;
        }
        
   
    }

    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 

        if(receivedDiseases != nil)
        {
        cell.textLabel!.text = self.receivedDiseases!.objectAtIndex(indexPath.row)as? String
        }
        else
        
        {
            cell.textLabel!.text = self.scothDiseases.objectAtIndex(indexPath.row) as? String
        }
        
        return cell
    }
    
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        
        if(cell != nil)
        
        {
        diseaseInfo = cell!.textLabel!.text!
        }
        
        self.performSegueWithIdentifier("showDiseaseInfo", sender: self)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    
    
    {
        
        if(segue.identifier == "showDiseaseInfo")
        {
            
            let displayDisease = segue.destinationViewController as! DiseaseViewController
            
            displayDisease.diseasename = self.diseaseInfo;
        }
        
        
    }
    



}
