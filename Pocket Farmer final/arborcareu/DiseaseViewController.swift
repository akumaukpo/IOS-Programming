//
//  DiseaseViewController.swift
//  arborcareu
//

//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

class DiseaseViewController: UIViewController {

    
    @IBOutlet var webview: UIWebView!
    
    var diseasename:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.webview.scalesPageToFit = true;
        
        
        
        if(diseasename != nil )
        
        {
            
            var url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(diseasename, ofType: "pdf")!)
            
            var request = NSURLRequest(URL: url)
                var jsCommand = "document.body.style.zoom = 1.5;"
                self.webview.stringByEvaluatingJavaScriptFromString(jsCommand);
           self.webview.loadRequest(request)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
