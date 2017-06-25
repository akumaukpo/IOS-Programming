//
//  DisplayMapPinsTable.swift
//  arborcareu
//
//  Created by Akuma Okbu on 23/02/2015.
//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit
import MapKit

class DisplayMapPinsTable: UITableViewController, MKMapViewDelegate{

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary];
        
        let coordinatesArray = NSMutableArray()
        let titleArray = NSMutableArray()
        let descriptionArray = NSMutableArray()
       
        
        self.mapView.delegate = self
        
        
        for(var i = 0; i < array?.count; i++)
            
        {
            print("the value of i is \(i)");
           
            let dic: NSDictionary? = array?[i]
            
            for (key, value) in dic!
                
            {
                
                var k = key as? String
                
                
                let dictionary: NSDictionary = value as! NSDictionary
                
                for(key1, value1) in dictionary
                    
                {
                    let keys = key1 as! String
                    
                    
                    if(keys == "treeType")
                   
                    {
                        let val = value1 as! String
                
                        titleArray.addObject(val)
                        
                        print("value is \(val)")
                    }
                    
                    
                    if(keys == "location")
                        
                    {
                        let val = value1 as! NSString
                        
                        coordinatesArray.addObject(val);
                    }
                    
                    if(keys == "description")
                    
                    {
                        let val  = value1 as! NSString
                        
                        descriptionArray.addObject(val)
                    }
                }
            }
        }
        
        
        
        
        let annoations = NSMutableArray();
        
        print("coordinates count is \(coordinatesArray.count)")
        
        for var i = 0; i < coordinatesArray.count; i++
            
        {
            
            let value = coordinatesArray.objectAtIndex(i) as? NSString
            
            
            if(value != nil)
            {
                var values = value!.componentsSeparatedByString(" ")
                
                
                let latt = values[0] as NSString
                let longg = values[1] as NSString
                
                
                
                print("the lat is \(latt) and long is \(longg)")
                
                
                let coordinates = CLLocationCoordinate2D(latitude: latt.doubleValue, longitude: longg.doubleValue)
                
                if(i==0)
                    
                {
                    let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(10 , 10)
                    
                    let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(coordinates, theSpan)
                    
                    self.mapView.setRegion(theRegion, animated: true)
                }
                
                
                
                let tit = titleArray.objectAtIndex(i) as? String
                let des = descriptionArray.objectAtIndex(i) as? String
                
                let annotation = MKPointAnnotation();
                
                annotation.coordinate = coordinates
                annotation.subtitle = des;
        
                if tit != nil
                    
                {
                    annotation.title = tit;
                    
                }
                
                annoations.insertObject(annotation, atIndex: i)
                
            }
            
        }
        
        print("the coun tis \(annoations.count)");
        
        self.mapView.addAnnotations(annoations as AnyObject as! [MKAnnotation]);

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class pins: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

