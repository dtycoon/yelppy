//
//  FilterViewController.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/23/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func searchTermDidChange (searchdata:NSDictionary)
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var delegate: FilterViewControllerDelegate!
    var categories: [NSDictionary]  =
    [
        [
        "name":"Price",
        "type":"segmented",
        "list":["$","$$","$$$","$$$$"]
        ],
        [
            "name":"Most Popular",
            "type":"switches",
            "list":["Offering a Deal","Open Now","Hot & New","Delivery"]
        ],
        [
            "name":"Distance",
            "type":"expandable",
            "list":["Auto","2 blocks","6 blocks","1 mile","5 miles"]
        ],
        [
            "name":"Sort By",
            "type":"expandable",
            "list":["Best Match","Distance","Rating","Most Reviewed"]
        ],
        [
            "name":"Categories",
            "type":"switches",
            "list":["Active Live","Arts & Entertainment","Automotive","Beauty & Spas","Bicycles", "Education","Event Planning & Services"]
        ]
    ]
    
    
    
    var mostPopularStates: [Bool] = [false, false, false, false]
    var priceStates: [Int] = [0]
    var distanceStates: [Bool] = [true, false, false, false, false]
    var sortByStates: [Bool] = [true, false, false, false]
    var categoriesStates: [Bool] = [false, false, false, false, false, false, false];
    var sortByExpanded: Bool = false
    var distanceExpanded: Bool = false
    var categoriesExpanded: Bool = false
    var mostPopularExpanded: Bool = false
    
    var categoryCodes: [String] = ["active", "arts", "auto", "beautysvc", "bicycles", "education", "eventservices"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self
        self.tableView.rowHeight = 90
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Price";
        } else if (section == 1) {
            return "Most Popular";
        } else if (section == 2){
            return "Distance";
        } else if (section == 3){
            return "Sort By";
        } else{
            return "Categories";
        }

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var sectionName = self.categories[section]["name"] as? String
        if (sectionName == "Price")
        {
            println(" numberOfRowsInSection Price count = 1)")
            return 1
        }
        else if (sectionName == "Categories")
        {
            println("numberOfRowsInSection Categories categoriesExpanded =\(self.categoriesExpanded)")
           if(!self.categoriesExpanded){
                println(" numberOfRowsInSection Categories count = 1")
                return 1;
            } else {
            var count = (self.categories[section]["list"] as NSArray).count
            println(" numberOfRowsInSection Categories count = \(count)")
                return (self.categories[section]["list"] as NSArray).count
            }
        }
        else if (sectionName == "Distance")
        {
            println("numberOfRowsInSection Distance distanceExpanded =\(self.distanceExpanded)")

            if(!self.distanceExpanded){
                println(" numberOfRowsInSection Distance count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                println(" numberOfRowsInSection Distance count = \(count)")
                return (self.categories[section]["list"] as NSArray).count
            }
        }
        else if (sectionName == "Sort By")
        {
            println("numberOfRowsInSection Sort By distanceExpanded =\(self.sortByExpanded)")
            
            if(!self.sortByExpanded){
                println(" numberOfRowsInSection Sort By count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                println(" numberOfRowsInSection Sort By count = \(count)")
                return (self.categories[section]["list"] as NSArray).count
            }
        }
        else if (sectionName == "Most Popular")
        {
            println("numberOfRowsInSection Most Popular mostPopularExpanded =\(self.mostPopularExpanded)")
            
            if(!self.mostPopularExpanded){
                println(" numberOfRowsInSection Sort By count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                println(" numberOfRowsInSectionMost Popular count = \(count)")
                return (self.categories[section]["list"] as NSArray).count
            }
        }

        else
        {
          println("ELse block numberOfRowsInSection ")
            var count = (self.categories[section]["list"] as NSArray).count
            println(" numberOfRowsInSectionMost ELSE count = \(count)")
        return (self.categories[section]["list"] as NSArray).count
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var sectionName = self.categories[indexPath.section]["name"] as? String
        
        if (sectionName == "Price" ) {
            var cell = tableView.dequeueReusableCellWithIdentifier("PriceViewCell") as PriceViewCell
            return cell;
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterViewCell") as FilterViewCell
         
            var list = self.categories[indexPath.section]["list"] as NSArray
            cell.filterLabel.text =  list[indexPath.row] as? String
            
            if((self.categories[indexPath.section]["name"] as? String) == "Most Popular"){
                cell.filterSwitch.on = self.mostPopularStates[indexPath.row]
            } else if((self.categories[indexPath.section]["name"] as? String) == "Distance"){
                cell.filterSwitch.on = self.distanceStates[indexPath.row]
            }
            if((self.categories[indexPath.section]["name"] as? String) == "Sort By"){
                cell.filterSwitch.on = self.sortByStates[indexPath.row]
                
            }
            else {
                cell.filterSwitch.on = self.categoriesStates[indexPath.row]
                
            }
            return cell;
        }
        
    }
    


    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        
        var sectionName = self.categories[indexPath.section]["name"] as? String
        
        if( sectionName == "Distance"){
            println("didSelectRowAtIndexPath Distance self.distanceExpanded =\(self.distanceExpanded)")
      
            self.distanceExpanded = !self.distanceExpanded
            
            
        } else if(sectionName == "Sort By"){
            println("didSelectRowAtIndexPath Distance sortByExpanded =\(self.sortByExpanded)")
            self.sortByExpanded = !self.sortByExpanded;
      //      self.sortByStates[indexPath.row] = true;
            
        } else if (sectionName == "Most Popular") {
            println("didSelectRowAtIndexPath Distance self.mostPopularExpanded =\(self.mostPopularExpanded)")
            self.mostPopularExpanded = !self.mostPopularExpanded;
        } else if (sectionName == "Categories") {
            println("didSelectRowAtIndexPath Distance self.categoriesExpanded =\(self.categoriesExpanded)")
            self.categoriesExpanded = !self.categoriesExpanded;
        }
        
        println(" row selected = \(indexPath.row) section selected = \(indexPath.section)")
        self.tableView.reloadData()
        
        
        
    }

    @IBAction func onValueChanged(sender: UISwitch) {
        var cell = sender.superview?.superview? as FilterViewCell
        var cellIndexPath = self.tableView.indexPathForCell(cell)
        var section = (cellIndexPath?.section)!
        var row =  (cellIndexPath?.row)!
       if (section == 1) {
            self.mostPopularStates[row] = !(self.mostPopularStates[row])
        } else if (section == 2) {
            self.distanceStates[row] = !(self.distanceStates[row])
        } else if (section == 3) {
            self.sortByStates[row] = !(self.sortByStates[row])
        }else if (section == 4) {
            self.categoriesStates[row] = !(self.categoriesStates[row])
        }
        self.tableView.reloadData()
    }
    @IBAction func onTapBack(sender: UIButton) {
        println("onTapBack received")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
  func saveFilters()
  {
   // let catagories = categoryCodes["categories"] as NSArray?
    var allTags: String = ""
    for var index = 0; index < self.categoryCodes.count; ++index {
        if( categoriesStates[index] == true)
        {
            if(allTags != "")
            {
            allTags += ", "
            }
            allTags += categoryCodes[index]
        }
    }
    var filterData:NSDictionary!
    if(allTags != "")
    {
        filterData.setValue(allTags, forKey:"category_filter")
       // filterdata nsert("category_filter", allTags)
    }
}
}
