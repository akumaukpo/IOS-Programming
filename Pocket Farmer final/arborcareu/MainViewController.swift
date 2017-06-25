//
//  MainViewController.swift
//  arborcareu
//

//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar;
        let image = UIImage(named: "navLogo.png");
        
        nav?.setBackgroundImage(image,forBarMetrics: UIBarMetrics.Default)
        nav?.tintColor = UIColor.whiteColor();
        
//
//        // 2
//        //
//        nav?.barStyle = UIBarStyle.Default;
//        nav?.tintColor = UIColor.yellowColor();
//                // 3
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .ScaleAspectFill
//        // 4
//        let image = UIImage(named: "navLogo.png")
//        imageView.image = image
//        // 5
//        navigationItem.titleView = imageView
        
     
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
