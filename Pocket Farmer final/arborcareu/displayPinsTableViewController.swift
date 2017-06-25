//
//  displayPinsTableViewController.swift
//  arborcareu
//
//  Created by Akuma Ukpo on 23/01/2015.
//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

var arrayForTable = NSMutableArray()
var arrayWithKeys = NSMutableArray()
var pictureArray = NSMutableArray()


class displayPinsTableViewController: UITableViewController{



override func viewDidLoad() {



super.viewDidLoad()


}



func loadData() -> Void{

var array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary];
    
arrayForTable.removeAllObjects()
arrayWithKeys.removeAllObjects()
pictureArray.removeAllObjects()
    
for(var i = 0; i < array?.count; i++)

{
    //if something exists, we should be able to print it out

    let dic: NSDictionary? = array?[i]

    for (key, value) in dic!

    {

        

    arrayWithKeys.addObject(key)

    let dictionary: NSDictionary = value as! NSDictionary

    for(key1, value1) in dictionary

    {
        let keys = key1 as! String

        if(keys == "treeType")
        
        {
            let val = value1 as! String
        
            arrayForTable.addObject(val)
        
            print("adding..")

        }
        
        if(keys == "picture")
        
        {
            
            
                if let oldImagePath = value1 as? String {
                let oldFullPath = self.documentsPathForFileName(oldImagePath)
                let oldImageData = NSData(contentsOfFile: oldFullPath)
                
                if(oldImageData != nil)
                    
                {
                    
                    let oldImage = UIImage(data: oldImageData!)
                    pictureArray.addObject(oldImage!);
                    
                }
                
                else
                
                {
                    let image = UIImage(named: "tree.jpg");
                    
                    pictureArray.addObject(image!);
 
                    
                }
            
            }
        }


}

}

}
    
self.tableView.reloadData()
    
}


override func viewDidAppear(animated: Bool) {
NSUserDefaults.standardUserDefaults().synchronize();
    self.loadData();
    self.tableView.reloadData();
    

}
    
    
    
    func documentsPathForFileName(name: String) -> String {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(name);
        return fileURL.path!
        
    }


override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

if(segue.identifier == "editItems")

{
    
    let vc = segue.destinationViewController as! NewPinTableViewController;

    let x =  self.tableView.indexPathForSelectedRow as NSIndexPath!;

    let val = arrayWithKeys.objectAtIndex(x.row) as! String

    vc.key = val;

    vc.idx = x.row


    let array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary]




    
let dic: NSDictionary? = array?[x.row]

    for (key, value) in dic!

        {

        var k = key as! String

        let dictionary: NSDictionary = value as! NSDictionary

        for(key1, value1) in dictionary

        {
            let keys = key1 as! String

            if(keys == "treeType")

        {
            vc.type = value1 as? String

        }

        if(keys == "location")
        {
            vc.location = value1 as? String
        }


        if(keys == "description")
        {
            vc.descriptiontext = value1 as? String
        }

        if(keys == "picture")

        {
            vc.image = value1 as? String
        }

    }

    }


    }


    }


override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
// #warning Potentially incomplete method implementation.
// Return the number of sections.
return 1
}


override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return arrayForTable.count
}



override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 


if(arrayForTable.count != 0 )

{
    let val = arrayForTable.objectAtIndex(indexPath.row) as! String
    
    cell.textLabel!.text = val
        
    if(pictureArray.count != 0)
        
    {
        let pic = pictureArray.objectAtIndex(indexPath.row) as? UIImage;
        
       if(pic != nil)
       
       {
            cell.imageView?.image=pic;
        
        }

    }
}
    

return cell
}



//below is the code to delete the pins:

override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

return true
}


override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }

    
    
    
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

if (editingStyle == UITableViewCellEditingStyle.Delete) {

var array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary];
array?.removeAtIndex(indexPath.row);
arrayForTable.removeObjectAtIndex(indexPath.row);

NSUserDefaults.standardUserDefaults().setObject(array, forKey: "data");
    NSUserDefaults.standardUserDefaults().synchronize();
self.tableView.reloadData()

}
}

}





