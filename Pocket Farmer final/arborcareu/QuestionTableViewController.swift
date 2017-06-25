//
//  QuestionTableViewController.swift
//  arborcareu
//
//  Created by Akuma Ukpo on on 31/01/2015.
//  Copyright (c) 2015 OEIP . All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {


var scothDiseases:NSMutableArray = [""];
var dougDiseases: NSMutableArray = [""];
var trueFirDiseases: NSMutableArray = [""];
var whitePineDiseases: NSMutableArray = [""];
var spruceDiseases: NSMutableArray = [""];
var additionalDiseases:NSMutableArray = [""];
    
var whereOnPlantArray:NSMutableArray = [""];
var whereInAreaArray:NSMutableArray = [""];
    
    
    
var selectedImage = "";

var whichTree = "";
var selectedIndexPath = NSMutableArray()
var reloadData = false;



@IBAction func filter(sender: AnyObject) {
    
    self.filterPressed();
    
    
    
}
    
    func filterPressed()->Void{
        reloadData = true;
        
        self.tableView.reloadData()
        
        if( whichTree == "Scotch Pine"){
            
            self.handleScotchWhereOnPlant();
            self.handleScotchWhereInArea();
            self.scothDiseases.addObjectsFromArray(self.additionalDiseases as [AnyObject]);
            self.removeDuplicates(self.scothDiseases);
        }
            
        else if (whichTree == "Douglas Fir"){
            
            self.handleDougWhereOnPlant();
            self.handleDougWhereInArea();
            self.dougDiseases.addObjectsFromArray(self.additionalDiseases as [AnyObject]);
            self.removeDuplicates(self.dougDiseases);
            
        }
            
        else if (whichTree == "True Fir"){
            self.handleTrueFirWhereOnPlant();
            self.handleTrueFirWhereInArea();
            self.trueFirDiseases.addObjectsFromArray(self.additionalDiseases as [AnyObject]);
            self.removeDuplicates(self.trueFirDiseases);
        }
            
        else if (whichTree == "White Pine"){
            self.handleWhitePineWhereOnPlant();
            self.handleWhitePineWhereInArea();
            self.whitePineDiseases.addObjectsFromArray(self.additionalDiseases as [AnyObject]);
            self.removeDuplicates(self.whitePineDiseases);
            
        }
            
        else{
            self.spruceHandleWhereOnPlant();
            self.spruceHandWhereInArea();
            self.whitePineDiseases.addObjectsFromArray(self.additionalDiseases as [AnyObject]);
            self.removeDuplicates(self.spruceDiseases);
            
        }
        
        
        self.performSegueWithIdentifier("showDiseaseViewController", sender: self)
    }


var treeDictionary:NSDictionary?

@IBOutlet var datePicker: UIDatePicker!


override func viewDidAppear(animated: Bool) {
    
    self.setup();
    
    
    
}


//MARK: helper functions

func removeDuplicates(array: NSMutableArray) -> Void{
   
    var filter = Dictionary<String,Int>()
    
    var len = array.count
    
    for var index = 0; index < len ;++index {
        
        let value: String = array[index] as! String
        
        if (filter[value] != nil) {
            
            array.removeObjectAtIndex(index--)
            len--
        }
        
        else{
            filter[value] = 1
        }
    }
    
}


func getIntDate() -> Int {
    
    let date = self.datePicker.date;
    let dateformat = NSDateFormatter()
    
    dateformat.dateFormat = "M"
    
    var dats = NSString()
    
    dats = dateformat.stringFromDate(date);
    let d = dats.integerValue;
    
    return d;
}

// MARK: input validation for tress.

func spruceHandleWhereOnPlant() -> Void{

let d = getIntDate();
    
    for var i = 0; i<self.whereOnPlantArray.count; i++ {
        
        let whereOnPlant  = self.whereOnPlantArray.objectAtIndex(i) as! String

    
    
            if(whereOnPlant == "Roots"){
                spruceDiseases.addObject("Phytophthora Root Rot")
                
            }

        if(whereOnPlant == "Top of the tree")
        {
            spruceDiseases.addObject("Drought Injury")
            if(9 <= d && d <= 11) //sep-nov
            {
                spruceDiseases.addObject("Fall Needle Drop");
                
            }
            
            if( 4 <= d && d <= 6) //apr - june
            {
             
                spruceDiseases.addObject("Winter Injury")
            }
        }

        if (whereOnPlant == "Bottom (Lower Branches)")
        {
            if( 7 <= d && d <= 8 || d <= 3 && d <= 5 || d <= 9 && d <= 12 ) //jul - aug, late fall and early spring
            {
                spruceDiseases.addObject("Rhizosphaera Needlecast")
                
            
            }


        }

        if(whereOnPlant == "Throughout")
        {
            spruceDiseases.addObject("Phytophthora Root Rot")
            
            if(8 <= d && d<=11)
            {
                spruceDiseases.addObject("Rhizosphaera Needlecast")
            }
            
            if( 4 <= d && d <= 6)
            {
                spruceDiseases.addObject("Winter Injury")
            }
            
            if( 5 <= d && d <= 6)
            {
                spruceDiseases.addObject("Frost Injury")
            }
            
        }
    }
}


func spruceHandWhereInArea() -> Void

{
    let d = getIntDate();
    
    for var i = 0; i < self.whereInAreaArray.count; i++ {
    
    let whereInArea = self.whereInAreaArray.objectAtIndex(i) as! String;
    if(whereInArea == "Tip of branches (new needles)")
    {
        spruceDiseases.addObject("Drought Injury")
        
        
        if(3 <= d && d <= 5 || 9 <= d && d <= 12 ) //early spring and late fall
        {
        spruceDiseases.addObject("Rhizosphaera Needlecast")
        }
        
        if( 5 <= d && d <= 6) //may june
        {
            spruceDiseases.addObject("Frost Injury")
            
        }
    }
    if(whereInArea == "On back portion of needles")
    {
        if ( 7 <= d && d <= 8) //july to august
        
        {
         spruceDiseases.addObject("Rhizosphaera Needlecast")
        }
        
        if( 9 <= d && d <= 11) //sep-nov
        {
            spruceDiseases.addObject("Fall Needle Drop")
        }
        
        if( 8 <= d && d <= 10)
        {
            spruceDiseases.addObject("Frost Injury")
            
        }
        
        
    }
    
    if(whereInArea == "On the young stem")
    {
        //na
    }
    if(whereInArea == "On the old stem")
    {
        //na
    }
    
    if(whereInArea == "Throughout")
    {
        spruceDiseases.addObject("Phytophthora Root Rot")
        
        if(4 <= d && d <= 6)
        {
            spruceDiseases.addObject("Winter Injury")
        }
    }
    
    
   
    }
}

    

//    Spring is from March to May
//    Summer is from June to August
//    Fall is from September to December
//    


func handleTrueFirWhereOnPlant()-> Void

{
    
    let d = getIntDate();
    
    for var i = 0; i<self.whereOnPlantArray.count; i++ {
        
    let whereOnPlant  = self.whereOnPlantArray.objectAtIndex(i) as! String

    
    if(whereOnPlant == "Roots")
    {
        trueFirDiseases.addObject("Phytophthora Root Rot")
        
    }
    
    
    if(whereOnPlant == "Top of the tree")
    {
        trueFirDiseases.addObject("Drought Injury");
    
        
        if(9 <= d && d <= 11)
        {
            trueFirDiseases.addObject("Fall Drop")
        }
        
        if( 4 <= d && d<=6)
        
        {
            trueFirDiseases.addObject("Winter Injury")
            
        }
        
        
    }
    
    if (whereOnPlant == "Bottom (Lower Branches)")
    {
        //no diseases
    }
    
    if (whereOnPlant == "All over the tree")
    
    {
        
        trueFirDiseases.addObject("Phytophthora Root Rot")
        trueFirDiseases.addObject("Rhizosphaera Needle Blight")
        if( 4 <= d && d<=6)
            
        {
            trueFirDiseases.addObject("Winter Injury")
            
        }
        
        if( 5 <= d && d <= 6)
        {
            trueFirDiseases.addObject("Frost Injury")
        }
        
    }
    
}
}


func handleTrueFirWhereInArea() -> Void{
    let d = getIntDate();
    for var i = 0; i < self.whereInAreaArray.count; i++ {
        
    let whereInArea = self.whereInAreaArray.objectAtIndex(i) as! String;
        
    if(whereInArea == "Tip of branches (new needles)"){
        trueFirDiseases.addObject("Drought Injury")
        
            if( 5 <= d && d <= 6){
                trueFirDiseases.addObject("Frost Injury")
        }
    }
    
    if (whereInArea == "On back portion of needles"){
        if( 9 <= d && d <= 11){
            trueFirDiseases.addObject("Fall Needle Drop")
            }
        
        if(8 <= d && d <= 10){
            trueFirDiseases.addObject("Frost Injury")
        }
    }
        
    if(whereInArea == "On the young stem"){
        
    }
    
    if(whereInArea == "On the old stem"){
        
    }
    
    if(whereInArea == "Throughout"){
        
        trueFirDiseases.addObject("Phytophthora Root Rot")
        trueFirDiseases.addObject("Rhizosphaera Needle Blight")
        
        if( 4 <= d && d<=6){
            trueFirDiseases.addObject("Winter Injury")
        }
    }
}

}
    
func handleWhitePineWhereOnPlant() -> Void{

    let d = getIntDate();
    
    for var i = 0; i<self.whereOnPlantArray.count; i++ {
        
        let whereOnPlant  = self.whereOnPlantArray.objectAtIndex(i) as! String

    if(whereOnPlant == "Root"){
        whitePineDiseases.addObject("Phytophthora Root Rot")
    }
        
    else if (whereOnPlant == "Top of the tree"){
        whitePineDiseases.addObject("Drought Injury")
        
        if(9 <= d && d <= 11){ //sep-nov
                whitePineDiseases.addObject("Fall Needle Drop")
                
        }
        if( 4 <= d && d <= 6){ //april - june
        
            whitePineDiseases.addObject("Winter Injury");
        }
        
    }
        
    else if (whereOnPlant == "Bottom (Lower Branches)" ){
        
       if(8 <= d && d <= 10 || 7 <= d && d <= 8 || 5 <= d  && d <= 7){
        
        // aug-oct, july-aug, may-july
        
            whitePineDiseases.addObject("Brown Spot Needle Blight")
        }
        
        if( 3 <= d && d <= 4 || 5 <= d && d <= 6 || 6 <= d && d <= 7){
            
            //march-apr, may-june, june-july
            
            whitePineDiseases.addObject("Lophodermium Needlecast")
        }
        
    }
    
    else{
        whitePineDiseases.addObject("Phytophthora Root Rot")
        
        if(5 <= d && d <= 6) //may-june
        {
            whitePineDiseases.addObject("Lophodermium Needlecast")
        }
        
        if( 4 <= d && d <= 6) //april- june
        {
            whitePineDiseases.addObject("Winter Injury")
            
        }
        
        if( 5 <= d && d <= 6) //may-june
        
        {
            whitePineDiseases.addObject("Frost Injury")
            
        }
    
    }
    
}
    
}

func handleWhitePineWhereInArea() -> Void{
    
    let d = getIntDate();
    for var i = 0; i < self.whereInAreaArray.count; i++ {
        
    let whereInArea = self.whereInAreaArray.objectAtIndex(i) as! String;
    if(whereInArea == "Tip of branches (new needles)"){
        whitePineDiseases.addObject("Drought Injury");
        
        if(5 <= d && d <= 6) //may-june
            {
                whitePineDiseases.addObject("Frost Injury");
        }
        
    }
    
    
    if(whereInArea == "On back portion of needles"){
        if(6 <= d && d <= 7){
                whitePineDiseases.addObject("Lophodermium Needlecast")
        }
        
        if(5 <= d && d <= 7){
            //may-july
            whitePineDiseases.addObject("Brown Spot Needle Blight")
            
        }
        
        if(9 <= d && d <= 11){
            //sep-nov
            whitePineDiseases.addObject("Fall Needle Drop")
            
        }
        if(9 <= d && d <= 11){
            //sep-nov
            whitePineDiseases.addObject("Fall Needle Drop")
            }
        
        if( 8 <= d && d <= 10){
            //aug-oct
            whitePineDiseases.addObject("Frost Injury")
        }
    }
    
    
    if(whereInArea == "On the young stem"){
        //na
    }
    if(whereInArea == "On the old stem"){
            //na
    }
        
    if(whereInArea == "Throughout"){
        
        whitePineDiseases.addObject("Phytophthora Root Rot")
       
        if(5 <= d && d <= 6 || 3 <= d && d <= 4 ){
            
            //may-june, // marc-april
            whitePineDiseases.addObject("Lophodermium Needlecast")
        }
        
        if(8 <= d && d <= 10 || 7 <= d && d <= 8 ){
            
            //august-oct, july-august
            whitePineDiseases.addObject("Brown Spot Needle Blight")
        }
        
        if(4 <= d && d <= 6 ){
            
            //april-june
            whitePineDiseases.addObject("Winter Injury")
        }
    }
}

    }


func handleDougWhereOnPlant() -> Void{
    let d = getIntDate();
    
    for var i = 0; i<self.whereOnPlantArray.count; i++ {
        
        let whereOnPlant  = self.whereOnPlantArray.objectAtIndex(i) as! String

   if(whereOnPlant == "Roots"){
    
    
    dougDiseases.addObject("Phytophthora Root Rot");
    
    
    }
    
    if(whereOnPlant == "Top of the tree"){
        
        if(9 <= d && d <= 11){
            //september - November
            
            dougDiseases.addObject("Drought Injury");
            dougDiseases.addObject("Fall Needle Drop");
            
        }
            
         if( 4 <= d && d <= 6){
            //april - june
            dougDiseases.addObject("Winter Injury");
        }


    }
    
    
    if( whereOnPlant == "Bottom (Lower Branches)"){
        
        if(10 <= d && d <= 11){
            //October-Nov
            
            dougDiseases.addObject("Rhabdocline Needlecast")
            

        }
        
            
        if (7 <= d && d <= 8 || 9 <= d && d <= 11 || 3 <= d && d <= 5){
            //spring and fall and july and august
            dougDiseases.addObject("Swiss Needlecast");
        }
        
    
    }
    
    if( whereOnPlant == "All over the tree"){
        dougDiseases.addObject("Phytophthora Root Rot")

        if (9 <= d && d <= 11 || 3 <= d && d <= 5){
            //spring and fall
            dougDiseases.addObject("Swiss Needlecast");
        }
        
        if (4 <= d && d <= 6){
            dougDiseases.addObject("Winter Injury")
            
        }
            
         if (5 <= d && d <= 6){
            dougDiseases.addObject("Frost Injury");
        }
        
    
    }
}
}

    
func handleDougWhereInArea() -> Void{
    let d = getIntDate();
    
    for var i = 0; i < self.whereInAreaArray.count; i++ {
        
        let whereInArea = self.whereInAreaArray.objectAtIndex(i) as! String;
        if(whereInArea == "Tip of branches (new needles)"){
            
            dougDiseases.addObject("Drought Injury");
            
            if(10 <= d && d <= 11 || 1 <= d && d <= 2){
                // late summer and jan-feb
                
                dougDiseases.addObject("Rhabdocline Needlecast");
                
            }
            
            if(5 <= d && d <= 6){
                //may june
                
                dougDiseases.addObject("Frost Injury");

            }
            
        }
    
    if (whereInArea == "On back portion of needles"){
        
        if(4 <= d &&  d <= 6  ){
            dougDiseases.addObject("Rhabdocline Needle Cast")
            
        }
        
        if(7 <= d && d <= 8){
            //july to august
            dougDiseases.addObject("Swiss Needlecast")
            
        }
        
        if( 9 <= d && d <= 11){
            //september - nov
            dougDiseases.addObject("Fall Needle Drop");
            
        }
        
        if(8 <= d && d <= 10){
            /// aug-oct
            
            dougDiseases.addObject("Frost Injury");
            
        }
        
        if(whereInArea == "Throughout"){
            dougDiseases.addObject("Phytophthora Root Rot")
            
            if (9 <= d && d <= 11 || 3 <= d && d <= 5){
                dougDiseases.addObject("Swiss Needlecast")
                
            }
            
            if(4 <= d && d <= 6){
                dougDiseases.addObject("Winter Injury");
            }
        }
    }
    
    }
}



func handleScotchWhereOnPlant()->Void{
    
        let d = getIntDate();
    
        for var i = 0; i < self.whereOnPlantArray.count; i++ {
        
            let whereOnPlant  = self.whereOnPlantArray.objectAtIndex(i) as! String

            if(whereOnPlant == "Roots"){
                
                scothDiseases.addObject("Phytophthora Root Rot");
                
    
        
            }
    
            
            if(whereOnPlant == "Top of the tree"){
                scothDiseases.addObject("Drought Injury");
                
                if(9 <= d && d <= 11){
                    scothDiseases.addObject("Fall Needle Drop");
                }
                
                if( 4 <= d && d <= 6){
                    scothDiseases.addObject("Winter Injury");
                }
            }
            
            
            if(whereOnPlant == "Bottom (Lower Branches)"){
                
                if(8 <= d && d <= 10 || 7 <= d && d <= 8 || 5 <= d && d <= 7){
                    scothDiseases.addObject("Brown Spot Needle Blight");
                }
                
                
                if( 3 <= d && d <= 4 || 5 <= d && d <= 6 || 6 <= d && d <= 7 ){
                    scothDiseases.addObject("Lophodermium Needlecast");
                }
                
                if( 5 <= d && d <= 6 || 7 <= d && d <= 8 || 8 <= d && d <= 9){
                    scothDiseases.addObject("Pine Needle Rust");
                }
                
                if( 9 <= d && d <= 11 || 3 <= d && d <= 8){
                    scothDiseases.addObject("Ploioderma needlecast");
                }
                
            }
            
            if(whereOnPlant == "All over the tree"){
                scothDiseases.addObject("Phytophthora Root Rot");
                
                if(d == 9 || 10 <= d && d <= 12 || 1 <= d && d <= 5){
                    scothDiseases.addObject("Cyclaneusma (=Naemacyclus) needlecast");
                    
                }
                
                if(5 <= d && d <= 6){
                    scothDiseases.addObject("LophodermiumNeedlecast");
                }
                
                if(4 <= d && d <= 6){
                    scothDiseases.addObject("Winter Injury");
                }
                
                if(5 <= d && d <= 6){
                    scothDiseases.addObject("Frost Injury");
                }
                
                
            }
        }
    
}


func handleScotchWhereInArea() ->Void{
    
    let d = self.getIntDate();
    
    for var i = 0 ; i < self.whereInAreaArray.count; i++ {
        
        let whereInArea = self.whereInAreaArray.objectAtIndex(i) as! String;
        
        if(whereInArea == "Throughout"){
            
            scothDiseases.addObject("Phytophthora Root Rot")
            
            if( 5 <= d && d <= 6 || 3 <= d && d <= 4){
                scothDiseases.addObject("Lophodermium Needlecast");
            }
            
            if( 5 <= d && d <= 6 || 7 <= d && d <= 8 || 8 <= d && d <= 9 ){
                scothDiseases.addObject("Pine Needle Rust");
                
            }

            if( 8 <= d && d <= 10 || 7 <= d && d <= 8){
                scothDiseases.addObject("Brown Spot Needle Blight");
            }
            
            if(4 <= d && d <= 6){
                scothDiseases.addObject("Winter Injury");
            }
            
            
        }
            
         if(whereInArea == "On the old stem "){
            //na
           
        }
            
         if(whereInArea == "On the young stem"){
            //na
        }
            
        if(whereInArea == "On back portion of needles"){
      
            
            if(6 <= d && d <= 7){
                scothDiseases.addObject("Lophodermium Needlecast");
            }
            
            if(5 <= d && d <= 7){
                scothDiseases.addObject("Brown Spot Needle Blight");
            }
            
            if(d == 9 || 10 <= d && d <= 12 || 1 <= d && d <= 5){
                scothDiseases.addObject("Cyclaneusma (=Naemacyclus) needlecast");
                
            }
            
            if(9 <= d && d <= 1){
                scothDiseases.addObject("Fall Needle Drop");
            }
            
            if(8 <= d && d <= 10){
                scothDiseases.addObject("Frost Injury");
            }
            
          
            
        }
            
        if(whereInArea == "Tip of branches (new needles)"){
            
            scothDiseases.addObject("Drought Injury");
            
            if(5 <= d && d <= 6){
                scothDiseases.addObject("Frost Injury");
            }
            
          
            
        }
    
    }
    
}




override func viewDidLoad() {
    
    super.viewDidLoad()


    let alert = UIAlertController(title: "Questionnaire", message: "You will now be directed to a questionnaire that will attempt to diagnose your plant disease based on your choices. Please select answers accordingly for a more accurate result", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    
    self.presentViewController(alert, animated: true, completion: nil);
    self.additionalDiseases.removeAllObjects();
    let date = NSDate();
    self.datePicker.setDate(date, animated: true);
    
}



func setup()-> Void {
    
    scothDiseases.removeAllObjects();
    dougDiseases.removeAllObjects();
    whitePineDiseases.removeAllObjects();
    spruceDiseases.removeAllObjects();
    trueFirDiseases.removeAllObjects();
    //additionalDiseases.removeAllObjects();
 



}




override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    

    
  let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    
    if(reloadData){
       cell.tintColor = UIColor.greenColor()
    }
    
    
    cell.imageView!.userInteractionEnabled = true;
    cell.imageView!.tag = indexPath.row;
    
    let tapGesture = UITapGestureRecognizer(target: self, action: "performsegue:")
    tapGesture.numberOfTapsRequired = 1;
    
    cell.imageView!.addGestureRecognizer(tapGesture)
    
    if(self.selectedIndexPath.containsObject(indexPath)){
    
        
          cell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    
    return cell
}







func performsegue(sender:UIGestureRecognizer)->Void{
    
    let v = sender.view as! UIImageView
    var location = CGPoint()
    
    let viewCenterRelativeToTableview = tableView.convertPoint(CGPointMake(CGRectGetMidX(v.bounds), CGRectGetMidY(v.bounds)), fromView:v)
    
    let index = self.tableView.indexPathForRowAtPoint(viewCenterRelativeToTableview) as NSIndexPath!

    
    
    if(index.section==3){
        selectedImage = "\(index.section)\(index.row).jpg"

    }
        
    else{
        selectedImage = "\(index.section)\(index.row).png"
    }
    
       self.performSegueWithIdentifier("showImage", sender: self)
    
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}



override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){


let cell = self.tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!


if(cell.accessoryType == UITableViewCellAccessoryType.Checkmark){
    
    cell.accessoryType = UITableViewCellAccessoryType.None;
    
}

else{
     cell.accessoryType = UITableViewCellAccessoryType.Checkmark
}


if(self.selectedIndexPath.containsObject(indexPath)){
    print("the indexpath is \(indexPath.description)")
    self.selectedIndexPath.removeObject(indexPath)

}

else{
    print("the indexpath is \(indexPath.description)")
    self.selectedIndexPath.addObject(indexPath);
    print("just added")
}


if(indexPath.section==0){

    if(whichTree == cell.textLabel!.text!){
        whichTree = "";
    }
    else{
        whichTree = cell.textLabel!.text!;
    }
            print("the tree is \(whichTree)");
}

if(indexPath.section==2 ){
    
    if(whereOnPlantArray.containsObject(cell.textLabel!.text!)){
        whereOnPlantArray.removeObject(cell.textLabel!.text!);
    }
    else{
        whereOnPlantArray.addObject(cell.textLabel!.text!);
    }
    
}


if(indexPath.section == 3){
    
    if(whereInAreaArray.containsObject(cell.textLabel!.text!)){
        whereInAreaArray.removeObject(cell.textLabel!.text!);
    }
        
    else{
        whereInAreaArray.addObject(cell.textLabel!.text!);
    }
}
    
//for additional disease as shown by the last question:
    
    if(indexPath.section == 5){
        
        

        switch(indexPath.row){
            
            case 0:
                print("selecting");
                
                
                if(self.additionalDiseases.containsObject("Brown Spot Needle Blight")){
                    self.additionalDiseases.removeObject("Brown Spot Needle Blight");
                    print("removing");
                }
                    
                else{
                    print("adding");
                    self.additionalDiseases.addObject("Brown Spot Needle Blight");
                  
                }
            
            case 1:
                
                if(self.additionalDiseases.containsObject("Cyclaneusma (=Naemacyclus) needlecast")){
                    self.additionalDiseases.removeObject("Cyclaneusma (=Naemacyclus) needlecast");
                }
                else
                {
            
                self.additionalDiseases.addObject("Cyclaneusma (=Naemacyclus) needlecast");
                }
            
            case 2:
            
                if(self.additionalDiseases.containsObject("Drought Injury")){
                    self.additionalDiseases.removeObject("Drought Injury");
                }
                else{
                self.additionalDiseases.addObject("Drought Injury");
            }
            
            case 3:
                
                if(self.additionalDiseases.containsObject("Fall Needle Drop")){
                    self.additionalDiseases.removeObject("Fall Needle Drop");
                }
                else{
                self.additionalDiseases.addObject("Fall Needle Drop");
            }
            case 4:
                
                if(self.additionalDiseases.containsObject("Frost Injury")){
                    self.additionalDiseases.removeObject("Frost Injury");
                }
                else{
                self.additionalDiseases.addObject("Frost Injury");
            }
           
            case 5:
                
                if(self.additionalDiseases.containsObject("Pine Needle")){
                    self.additionalDiseases.removeObject("Pine Needle")
                }
                else{
                    
                    self.additionalDiseases.addObject("Pine Needle");
            }
            
            case 6:
            
                if(self.additionalDiseases.containsObject("Pine needle rust")){
                    self.additionalDiseases.removeObject("Pine needle rust")
                }
                else{
                    
                    self.additionalDiseases.addObject("Pine needle rust");
            }
            
            case 7:
                if(self.additionalDiseases.containsObject("Phytophthora Root Rot")){
                    self.additionalDiseases.removeObject("Phytophthora Root Rot")
                }
                else{
                    
                    self.additionalDiseases.addObject("Phytophthora Root Rot");
                }
        
            
            default:
                
                print("nothing");
        }
    }
    
    if(indexPath.section==6){
        
        self.filterPressed()
    }


}


 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if(segue.identifier == "showDiseaseViewController"){
        
        
        let vc = segue.destinationViewController as! ByDiseaseTableViewController
        
        if(whichTree == "Scotch Pine"){
        
            vc.receivedDiseases = self.scothDiseases
        }
        if(whichTree == "Douglas Fir"){
            vc.receivedDiseases = self.dougDiseases;
        }
        if(whichTree == "True Fir"){
            vc.receivedDiseases = self.trueFirDiseases;
        }
        if(whichTree == "Blue Spruce"){
            vc.receivedDiseases = self.spruceDiseases;
        }
        if (whichTree == "White Pine"){
            vc.receivedDiseases = self.whitePineDiseases;
        }
    }
    
    if(segue.identifier == "showImage"){
        print("selected image is \(selectedImage)")
        let vc = segue.destinationViewController as! ImagePreViewController
        vc.image = UIImage(named:selectedImage)
    }
    
}

}
