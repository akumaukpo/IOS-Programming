//
//  ImagePreViewController.swift
//  arborcareu
//

//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

class ImagePreViewController: UIViewController {

 
    var image: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        if(image != nil)
            
        {
            self.imageView.image = image!
        }
     
        

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
