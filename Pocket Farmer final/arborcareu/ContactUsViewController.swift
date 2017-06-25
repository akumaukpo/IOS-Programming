//
//  ContactUsViewController.swift
//  arborcareu
//
//  Created by Akuma Ukpo on 16/01/2015.
//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit
import MobileCoreServices
import MessageUI


class ContactUsViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate

{
    
    
    

    @IBOutlet var txtFieldEmail: UITextField!
    
    @IBOutlet var txtFieldSubject: UITextField!
    
    @IBOutlet var txtViewEmailBody: UITextView!
    
    @IBAction func btnTakePicture(sender: AnyObject) {
        
        
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                
                print("Camera capture")
                let imag = UIImagePickerController()
                imag.delegate = self
                imag.sourceType = UIImagePickerControllerSourceType.Camera;
                //imag.mediaTypes = [kUTTypeImage];
                imag.allowsEditing = false
                self.presentViewController(imag, animated: true, completion: nil)
            }
        
        
        
        // here is the code for takePicture
        
        
        
        
        
        
        
    }
    
    @IBAction func btnSendEmail(sender: AnyObject) {
        
        let mailComposeViewController = configureMailComposeViewController()
        
        self.presentViewController(mailComposeViewController,animated:true,completion:nil)
        
        
        
    }
    
    func
        
        
        configureMailComposeViewController()->MFMailComposeViewController
    {
        
        let msg = "From: \(txtFieldEmail.text) \n Message : \(txtViewEmailBody.text)";
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["agdiagnostics@udel.edu"])
        
        mailComposerVC.setSubject(txtFieldSubject.text!)
        
        mailComposerVC.setMessageBody(msg, isHTML: false);
        
        var image = previewImageView.image
        var imageData = UIImageJPEGRepresentation(image!, 1.0)
    
        mailComposerVC.addAttachmentData(imageData!, mimeType: "image/jped", fileName:     "image")
        
        return mailComposerVC
        
        
    }
    
    @IBAction func resign(sender: AnyObject) {
        
        txtViewEmailBody.resignFirstResponder();
        txtFieldEmail.resignFirstResponder();
        txtFieldSubject.resignFirstResponder();
    
    }
    
    func  mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    
            controller.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func btnUploadPicture(sender: AnyObject) {
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
  
        
        
        let selectedImage : UIImage = image
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
        previewImageView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtViewEmailBody.becomeFirstResponder();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
