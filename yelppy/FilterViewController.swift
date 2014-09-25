//
//  FilterViewController.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/23/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func searchTermDidChange (searchdata:NSMutableDictionary)
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var filterData:NSMutableDictionary!
    
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
            //           "list":["Offering a Deal","Open Now","Hot & New","Delivery"]
            "list":["Offering a Deal"]
        ],
        [
            "name":"Distance",
            "type":"expandable",
            "list":["Auto","2 blocks","6 blocks","1 mile","5 miles", "See more"]
        ],
        [
            "name":"Sort By",
            "type":"expandable",
            //   "list":["Best Match","Distance","Rating","Most Reviewed"]
            "list":["Best Match","Distance","Rating", "See more"]
        ],
        [
            "name":"Categories",
            "type":"switches",
            "list":["Active Live","Arts & Entertainment","Automotive","Beauty & Spas","Bicycles", "Education","Event Planning & Services", "See more"]
        ]
    ]
    
    
    
    //   var mostPopularStates: [Bool] = [false, false, false, false]
    var mostPopularStates: [Bool] = [false]
    var priceStates: [Int] = [0]
    var distanceStates: [Bool] = [true, false, false, false, false, false]
    // var sortByStates: [Bool] = [true, false, false, false]
    var sortByStates: [Bool] = [true, false, false, false]
    var categoriesStates: [Bool] = [false, false, false, false, false, false, false, false];
    var sortByExpanded: Bool = false
    var distanceExpanded: Bool = false
    var categoriesExpanded: Bool = false
    var mostPopularExpanded: Bool = false
    
    var sortByCodes: [Int] = [0, 1, 2, -1]
    var categoryCodes: [String] = ["active", "arts", "auto", "beautysvc", "bicycles", "education", "eventservices", "see-more"]
    var distanceCodes: [Int] = [-1, 250, 750, 1610, 8050, -1]
    var mostPopularCodes: [String] = ["deals_filter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self
        self.tableView.rowHeight = 90
        populateFilterFromResults()
    }
    
    
    func populateFilterFromResults()
    {
        populateCategoryFilter(self.categoryCodes, searchCurrentState: self.categoriesStates, searchKey: "category_filter")
        self.populateMostPopularFilters(self.mostPopularCodes, searchCurrentState: self.mostPopularStates, searchKey: "deals_filter")
        self.populateDistancOrSortFilters(self.distanceCodes, searchCurrentState: self.distanceStates, searchKey: "radius_filter")
        self.populateDistancOrSortFilters(self.sortByCodes, searchCurrentState: self.sortByStates, searchKey: "sort")
        
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
            //          println(" numberOfRowsInSection Price count = 1)")
            return 1
        }
        else if (sectionName == "Categories")
        {
            //         println("numberOfRowsInSection Categories categoriesExpanded =\(self.categoriesExpanded)")
            if(!self.categoriesExpanded){
                //             println(" numberOfRowsInSection Categories count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                //         println(" numberOfRowsInSection Categories count = \(count)")
                return (self.categories[section]["list"] as NSArray).count - 1
            }
        }
        else if (sectionName == "Distance")
        {
            //         println("numberOfRowsInSection Distance distanceExpanded =\(self.distanceExpanded)")
            
            if(!self.distanceExpanded){
                //           println(" numberOfRowsInSection Distance count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                //           println(" numberOfRowsInSection Distance count = \(count)")
                return (self.categories[section]["list"] as NSArray).count - 1
            }
        }
        else if (sectionName == "Sort By")
        {
            //           println("numberOfRowsInSection Sort By distanceExpanded =\(self.sortByExpanded)")
            
            if(!self.sortByExpanded){
                //             println(" numberOfRowsInSection Sort By count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                //              println(" numberOfRowsInSection Sort By count = \(count)")
                return (self.categories[section]["list"] as NSArray).count - 1
            }
        }
        else if (sectionName == "Most Popular")
        {
            //          println("numberOfRowsInSection Most Popular mostPopularExpanded =\(self.mostPopularExpanded)")
            
            if(!self.mostPopularExpanded){
                //              println(" numberOfRowsInSection Sort By count = 1")
                return 1;
            } else {
                var count = (self.categories[section]["list"] as NSArray).count
                //             println(" numberOfRowsInSectionMost Popular count = \(count)")
                return (self.categories[section]["list"] as NSArray).count
            }
        }
            
        else
        {
            //       println("ELse block numberOfRowsInSection ")
            var count = (self.categories[section]["list"] as NSArray).count
            //         println(" numberOfRowsInSectionMost ELSE count = \(count)")
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
                println(" before cellForRowAtIndexPath setting self.mostPopularStates[indexPath.row]  = \(self.mostPopularStates[indexPath.row]) and cell.filterSwitch.on = \(cell.filterSwitch.on)")
                cell.filterSwitch.on = self.mostPopularStates[indexPath.row]
                println(" after cellForRowAtIndexPath setting self.mostPopularStates[indexPath.row]  = \(self.mostPopularStates[indexPath.row]) and cell.filterSwitch.on = \(cell.filterSwitch.on)")
                
            } else if((self.categories[indexPath.section]["name"] as? String) == "Distance"){
                if(self.distanceExpanded)
                {
                cell.filterSwitch.on = self.distanceStates[indexPath.row]
                cell.filterSwitch.hidden = false
                }
                else
                {
                    cell.filterLabel.text = list[list.count - 1] as? String
                    cell.filterSwitch.hidden = true
                }
            } else if((self.categories[indexPath.section]["name"] as? String) == "Sort By"){
                if(self.sortByExpanded)
                {
                cell.filterSwitch.on = self.sortByStates[indexPath.row]
                cell.filterSwitch.hidden = false
                }
                else
                {
                    cell.filterLabel.text = list[list.count - 1] as? String
                    cell.filterSwitch.hidden = true
                }
                
            } else {
                if(self.categoriesExpanded)
                {
                cell.filterSwitch.on = self.categoriesStates[indexPath.row]
                cell.filterSwitch.hidden = false
                }
                else
                {
                    cell.filterLabel.text = list[list.count - 1] as? String
                    cell.filterSwitch.hidden = true
                }

                
            }
            return cell;
        }
        
    }
    
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        var sectionName = self.categories[indexPath.section]["name"] as? String
        
        if (sectionName == "Distance"){
            //      println("didSelectRowAtIndexPath Distance self.distanceExpanded =\(self.distanceExpanded)")
            
            self.distanceExpanded = !self.distanceExpanded
            
            
        } else if(sectionName == "Sort By"){
            //      println("didSelectRowAtIndexPath Distance sortByExpanded =\(self.sortByExpanded)")
            self.sortByExpanded = !self.sortByExpanded;
            //      self.sortByStates[indexPath.row] = true;
            
        } else if (sectionName == "Most Popular") {
            //         println("didSelectRowAtIndexPath Distance self.mostPopularExpanded =\(self.mostPopularExpanded)")
            self.mostPopularExpanded = !self.mostPopularExpanded;
        } else if (sectionName == "Categories") {
            //         println("didSelectRowAtIndexPath Distance self.categoriesExpanded =\(self.categoriesExpanded)")
            self.categoriesExpanded = !self.categoriesExpanded;
        }
        
        //       println(" row selected = \(indexPath.row) section selected = \(indexPath.section)")
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
            for var index = 0; index < self.distanceStates.count; ++index
            {
                if(row != index && self.distanceStates[index] as Bool != false)
                {
                    self.distanceStates[index] = false
                }
            }
        } else if (section == 3) {
            self.sortByStates[row] = !(self.sortByStates[row])
            for var index = 0; index < self.sortByStates.count; ++index
            {
                if(row != index && self.sortByStates[index] as Bool != false)
                {
                    self.sortByStates[index] = false
                }
            }
        }else if (section == 4) {
            self.categoriesStates[row] = !(self.categoriesStates[row])
        }
        self.tableView.reloadData()
    }
    @IBAction func onTapBack(sender: UIButton) {
        println("onTapBack received")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onTapSearch(sender: UIButton) {
        saveCategoryFilter(self.categoryCodes, searchCurrentState: self.categoriesStates, searchKey: "category_filter")
        saveMostPopularFilters(self.mostPopularCodes, searchCurrentState: self.mostPopularStates, searchKey: "deals_filter")
        saveDistanceOrSortFilters(self.distanceCodes, searchCurrentState: self.distanceStates, searchKey: "radius_filter")
        saveDistanceOrSortFilters(self.sortByCodes, searchCurrentState: self.sortByStates, searchKey: "sort")
        
        delegate!.searchTermDidChange(filterData)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func saveCategoryFilter(searchCodes:NSArray, searchCurrentState:NSArray, searchKey:String)
    {
        // let catagories = categoryCodes["categories"] as NSArray?
        var allTags: String = ""
        for var index = 0; index < searchCodes.count; ++index {
            if( searchCurrentState[index] as Bool == true)
            {
                if(allTags != "")
                {
                    allTags += ","
                }
                allTags += searchCodes[index] as String
            }
        }
        
        if(allTags != "")
        {
            self.filterData.setValue(allTags, forKey:searchKey)
            // filterdata nsert("category_filter", allTags)
        }
        else
        {
            if(self.filterData.objectForKey(searchKey) != nil )
            {
                self.filterData.removeObjectForKey(searchKey)
            }
        }
        
        
    }
    
    func saveMostPopularFilters(searchCodes:NSArray, searchCurrentState:NSArray, searchKey:String)
    {
        for var index = 0; index < searchCurrentState.count; ++index {
            if( (searchCurrentState[index] as Bool == true)
                && (searchCodes[index] as String == searchKey))
            {
                self.filterData.setValue(searchCurrentState[index] as Bool, forKey:searchKey)
                return
            }
            if(self.filterData.objectForKey(searchKey) != nil )
            {
                self.filterData.removeObjectForKey(searchKey)
            }
        }
    }
    
    func saveDistanceOrSortFilters(searchCodes:NSArray,searchCurrentState:NSArray, searchKey:String)
    {
        for var index = 0; index < searchCodes.count; ++index {
            if( searchCurrentState[index] as Bool == true && searchCodes[index] as Int != -1)
            {
                self.filterData.setValue(searchCodes[index] as Int, forKey:searchKey)
                return
            }
            if(self.filterData.objectForKey(searchKey) != nil )
            {
                self.filterData.removeObjectForKey(searchKey)
            }
        }
    }
    
    func populateDistancOrSortFilters(searchCurrentCodes:NSArray, searchCurrentState:[Bool], searchKey:String)
    {
        if(self.filterData.objectForKey(searchKey) != nil )
        {
            var codeSaved = self.filterData.objectForKey(searchKey) as Int
            for var index = 0; index < searchCurrentCodes.count; ++index {
                if( searchCurrentCodes[index] as Int == codeSaved)
                {
                    if(searchKey == "sort")
                    {
                        self.sortByStates[index] = true
                        for var others = 0; others < searchCurrentCodes.count; ++others {
                            if(others != index)
                            {
                                self.sortByStates[others] = false
                            }
                        }
                    }
                    else if(searchKey == "radius_filter")
                    {
                        self.distanceStates[index] = true
                        for var others = 0; others < searchCurrentCodes.count; ++others {
                            if(others != index)
                            {
                                self.distanceStates[others] = false
                            }
                        }
                    }
                    return
                }
                
            }
        }
    }
    
    func populateMostPopularFilters(searchCurrentCodes:NSArray, searchCurrentState:[Bool], searchKey:String)
    {
        if(self.filterData.objectForKey(searchKey) != nil )
        {
            var codeSaved = self.filterData.objectForKey(searchKey) as Bool
            for var index = 0; index < searchCurrentCodes.count; ++index {
                if( searchCurrentCodes[index] as String == searchKey)
                {
                    self.mostPopularStates[index] = codeSaved
                }
                
            }
        }
    }
    
    func populateCategoryFilter(searchCodes:NSArray, searchCurrentState:NSArray, searchKey:String)
    {
        // let catagories = categoryCodes["categories"] as NSArray?
        //componentsSeparatedByString
        if(self.filterData.objectForKey(searchKey) != nil )
        {
            var code = self.filterData.objectForKey(searchKey) as NSString
            var codesArray = code.componentsSeparatedByString(",")
            
            for var index = 0; index < codesArray.count; ++index {
                for var searchIndex = 0; searchIndex < searchCodes.count; ++searchIndex {
                    if(codesArray[index] as String == searchCodes[searchIndex] as String)
                    {
                        self.categoriesStates[searchIndex] = true
                        break
                    }
                }
            }
        }
    }
    
}
