//
//  NewPinTableViewController.swift
//  arborcareu
//
//  Created by Akuma Ukpo on 22/01/2015.
//  Copyright (c) 2015 OEIP . All rights reserved.






import UIKit
import CoreLocation
import MobileCoreServices
import MapKit


class NewPinTableViewController: UITableViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate, CLLocationManagerDelegate {

let locationManager = CLLocationManager()

var type :String?
var location: String?
var descriptiontext: String?
var image: String?
var key: String?
var idx: Int?


    @IBAction func openInMaps(sender: AnyObject) {
        
        
        let data = self.txtViewLocationData.text;
        
        var values = data.componentsSeparatedByString(" ");
        
        let latt = values[0];
        let longg = values[1];
        
        print("\(latt) and \(longg) are the lats and longs");
        
        self.openMapWithCoordinates(longg, theLat: latt);
        
    }
  
    
@IBOutlet var previewImageView: UIImageView!




@IBOutlet var txtTreeType: UITextField!



@IBAction func getLocationButton(sender: AnyObject) {
    
    self.setupLoc();
    
    
}
    
    func setupLoc()
{
    locationManager.delegate=self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()
    
    locationManager.startUpdatingLocation()
    
}


func  locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    self.txtViewLocationData.text = ("\(locValue.latitude) \(locValue.longitude)")
  
    locationManager.stopUpdatingLocation();
    
    //Code for getting the adress:
    
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
//            
//            if (error != nil) {
//                
//                println("Reverse geocoder failed with error \(error.localizedDescription)")
//                return
//            }
//            
//            if placemarks.count > 0 {
//                let pm = placemarks[0] as CLPlacemark
//                
//                
//                
//                self.displayLocationInfo(pm)
//                
//            
//                
//            } else {
//                println("Problem with the data received from geocoder")
//            }
//        })
}





func displayLocationInfo(placemark: CLPlacemark) {
    
   
    
        locationManager.stopUpdatingLocation()

        self.txtViewLocationData.text = "\(placemark.locality), \(placemark.postalCode), \(placemark.administrativeArea), \(placemark.country)"
    
    
    
    
    
}



func  locationManager(manager: CLLocationManager, didFailWithError error: NSError)


{
    print("Error while updating your location \(error.description)");
    
   
}




func documentsPathForFileName(name: String) -> String {
    
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let fileURL = documentsURL.URLByAppendingPathComponent(name);
    return fileURL.path!;
}
    

@IBAction func saveButton(sender: AnyObject) {
    
 
    self.saveData();
    
    
}
    
 func saveData() -> Void
    {
    var array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary]
    
    
    let date = NSDate()
    
    
    var saveDictionary =
    
    ["treeType": "", "location":"", "description":"", "picture":""]
    
    var loc = self.txtViewLocationData.text as NSString
    saveDictionary["location"] = loc as String;
    
    saveDictionary["description"] = self.txtViewDescription.text
    
    saveDictionary["treeType"] = self.txtTreeType.text as String?;
    
    let imageData = UIImageJPEGRepresentation(self.previewImageView.image!, 1) //save the image to directory and get its url and save this to the dictionary
    
    var relativePath = ""
    
    
    if(key != nil)
    
    {
    relativePath = "image_\(key!)).jpg"
    }
    
    else
    
    {
    relativePath = "image_\(date.description)).jpg"
    
    }
    
    
    if(imageData != nil)
    
    {
    
    let path = self.documentsPathForFileName(relativePath)
    
    
    
    imageData!.writeToFile(path, atomically: true)
    
    }
    
    
    
    
    saveDictionary["picture"] = relativePath
    
    
    
    
    if(key != nil)
    
    {
    print("we are here");
    
    let finalDictionary:NSDictionary = [key!: saveDictionary]
    
    if(idx != nil)
    
    {
    array?.removeAtIndex(idx!);
    array?.insert(finalDictionary, atIndex: idx!)
    NSUserDefaults.standardUserDefaults().setObject(array, forKey: "data")
    NSUserDefaults.standardUserDefaults().synchronize();
    
    }
    
    
    }
    
    
    else
    
    {
    
    
    
    
    var key = date.description
    
    let finalDictionary:NSDictionary = [key: saveDictionary]
    
    array?.insert(finalDictionary, atIndex: array!.count)
    
    NSUserDefaults.standardUserDefaults().setObject(array, forKey: "data")
    
    NSUserDefaults.standardUserDefaults().synchronize()
    
    
    
    }
    
    

    }


@IBOutlet var txtViewLocationData: UITextView!

    
    
@IBOutlet var txtViewDescription: UITextView!


override func viewDidLoad() {
    
    
    super.viewDidLoad()
    
    
    let array: [NSDictionary]? = NSUserDefaults.standardUserDefaults().objectForKey("data") as? [NSDictionary]
    
    
    if(array == nil)
        
    {
        print("nil array")
        //if nothing is saved then initialize it by saving a blank array
        
        let save: [NSDictionary] = []
        
        NSUserDefaults.standardUserDefaults().setObject(save, forKey: "data")
        NSUserDefaults.standardUserDefaults().synchronize();
        
    }
    
    
    
    

    if(descriptiontext != nil){
        self.txtViewDescription.text = descriptiontext!
        
        
    }
    
    
    if(location != nil){
        self.txtViewLocationData.text = location!;
        
    }
    
    
    if(type != nil){
        self.txtTreeType.text = type!;
    }
    
    if(image != nil){
        
        let possibleOldImagePath = image
        if let oldImagePath = possibleOldImagePath {
            let oldFullPath = self.documentsPathForFileName(oldImagePath)
            let oldImageData = NSData(contentsOfFile: oldFullPath)
            
            if(oldImageData != nil){
                
            let oldImage = UIImage(data: oldImageData!)
            self.previewImageView.image = oldImage
            
            }
    }
    

//    for(var i = 0; i < array?.count; i++)
//        
//    {
//        
//        var dic: NSDictionary? = array?[i]
//        
//        for (key, value) in dic!
//        
//        {
//            print(" the key is \(key), with value \(value)")
//            
//            
//            var dictionary: NSDictionary = value as NSDictionary
//            
//            for(key1, value1) in dictionary
//            
//            {
//                
//                
//                print("the key is \(key1), with value \(value1)")
//            }
//            
//        }
//    
//    }
//  
        
 }
    
}


    
//below we open the maps app with the lattitude and longitude and display on the map:
    
func openMapWithCoordinates(theLon:NSString, theLat:NSString){
    

    let longi = theLon.doubleValue
    let lat = theLat.doubleValue;
    
    let regionDistance:CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(lat, longi);
    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
    let options = [
        MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
        MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = self.txtTreeType.text;
    mapItem.openInMapsWithLaunchOptions(options)

    }


@IBAction func takePictureButton(sender: AnyObject) {
    
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
        print("Camera capture")
        let imag = UIImagePickerController()
        imag.delegate = self
        imag.sourceType = UIImagePickerControllerSourceType.Camera;
        //imag.mediaTypes = [kUTTypeImage];
        imag.allowsEditing = false
        self.presentViewController(imag, animated: true, completion: nil)
    }
    
}

    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    


    
    
    let selectedImage : UIImage = image
    previewImageView.image=selectedImage
    self.dismissViewControllerAnimated(true, completion: nil)
}


    override func viewDidDisappear(animated: Bool) {
        
     
        }


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}
