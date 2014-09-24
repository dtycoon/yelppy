//
//  ViewController.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/21/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var categoryTableView: UITableView!
    
    @IBOutlet weak var sortTableView: UITableView!
    
    @IBOutlet weak var dealsTableView: UITableView!
    
    @IBOutlet weak var distanceTableView: UITableView!
    
    var sectionNames = [
    "Category", "Sort by", "Radius", "Offering Deals"]
    
    var sectionsEnabled: [String:Bool] = ["Category":0, "Sort by":0, "Radius":0, "Offering Deals":0]
    
    var categoryList: [[String:String]]
    = [
        
        ["category":"Top", "value":"Active Life"],
        ["category":"Active Life", "value":"ATV Rentals/Tours"],
        ["category":"Active Life", "value":"Amateur Sports Teams"],
        ["category":"Top", "value":"Automotive"],
        ["category":"Automotive", "value": "Aircraft Dealers"],
        ["category":"Automotive", "value": "Auto Customization"],
        ["category":"Top", "value":"Beauty & Spas"],
        ["category":"Beauty & Spas", "value":"Barbers"],
        ["category":"Beauty & Spas", "value":"Cosmetics & Beauty Supply"]
        
    ]
    
/*    var categoryList: [[String:String, String]]
    = [
        [category:"Top", name:["Active Life", term: "active"],
        [category:"Active Life", name:"ATV Rentals/Tours", term: "atvrentals"],
        [category:"Active Life", name:"Amateur Sports Teams", term: "amateursportsteams"],
        [category:"Active Life", name:"Amateur Sports Teams", term: "amateursportsteams"],
        [category:"Active Life", name:"Amateur Sports Teams", term: "amateursportsteams"],
        [category:"Active Life", name:"Amateur Sports Teams", term: "amateursportsteams"],
        [category:"Active Life", name:"Amateur Sports Teams", term: "amateursportsteams"]
    ] */

/*    var sortList : [String]
    = [
        "category":"Best matched", "value": "0",
        "category":"Distance": 1,
        "category":"Highest Rated": 2
      ] */

    var sortList : [String]
    = [ "Best matched" , "Distance", "Highest Rated"]
    
    var radiusList : [String:Int]
    = [
        "Best matched": 0,
        "2 blocks": 160,
        "6 blocks": 500,
        "1 mile": 1610,
        "5 miles": 8050
    ]
    
    var deals : [String:Bool]
    = ["deals": false]
    
  /*  var radiusListExpanded: [Int: Bool]! = [Int:Bool]()
    
    var isExpanded: [Int: Bool]! = [Int:Bool]() */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        sortTableView.delegate = self
        sortTableView.dataSource = self
        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        distanceTableView.delegate = self
        distanceTableView.dataSource = self
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        dealsTableView.rowHeight = UITableViewAutomaticDimension
        distanceTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch (tableView)
            {
        case dealsTableView:
            println(" numberOfRowsInSection dealsTableView count = \(deals.count)")
            return deals.count
         case sortTableView:
            var rows = ((sectionsEnabled["Sort by"] == 0) ? 1: sortList.count )
            println(" numberOfRowsInSection sortTableView count = \(rows)")
            return rows
        case distanceTableView:
            var rows =  ((sectionsEnabled["Radius"] == 0) ? 1: radiusList.count )
            println(" numberOfRowsInSection distanceTableView count = \(rows)")
            return rows
        case categoryTableView:
            var rows =   ((sectionsEnabled["Category"] == 0) ? 1: categoryList.count )
            println(" numberOfRowsInSection categoryTableView count = \(rows)")
            return rows
        default:
                return 0
            }

    }
   
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x:0,y:0, width:320, height:10))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        let headerLabel = UILabel (frame:CGRect(x:10,y:0, width:320, height:10))
        
        switch (tableView)
            {
        case dealsTableView:
            headerLabel.text = "deals" //sectionNames[section]
            break
        case sortTableView:
            headerLabel.text = "sort" // sectionNames[section]
            break
        case distanceTableView:
            headerLabel.text = "distance" //sectionNames[section]
            break
        case categoryTableView:
            headerLabel.text = "mycategory" //sectionNames[section]
            break
        default:
            headerLabel.text = "DEFAULT"

        }
        headerView.addSubview(headerLabel)
        return headerView;

    }
    
 /*   func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerView = UIView(frame: CGRect(x:0,y:0, width:320, height:20))
        footerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return footerView;

    } */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch (tableView)
            {
        case dealsTableView:
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
            cell.filterName.text = deals.keys.array[indexPath.row]
            return cell
        case sortTableView:
            var cell = tableView.dequeueReusableCellWithIdentifier("SortViewCell") as SortViewCell
            cell.sortLabel.text = sortList[indexPath.row]
            return cell
        case distanceTableView:
            var cell = tableView.dequeueReusableCellWithIdentifier("RadiusViewCell") as RadiusViewCell
            cell.radiusLabel.text = radiusList.keys.array[indexPath.row]
            return cell

        case categoryTableView:
            var cell = tableView.dequeueReusableCellWithIdentifier("SelectionViewCell") as SelectionViewCell
            cell.filterLabel.text = categoryList[indexPath.row]["category"]
            return cell

        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
            cell.filterName.text = sectionNames[3]
            println("default called on cellForRowAtIndexPath. Should not happen")
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
   
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
   
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch (tableView)
            {
        case sortTableView:
            if (sectionsEnabled["Sort by"] == 0)
            {
                sectionsEnabled["Sort by"] = 1
            }
            else
            {
                sectionsEnabled["Sort by"] = 0
            }
        case distanceTableView:
            if (sectionsEnabled["Radius"] == 0)
            {
                sectionsEnabled["Radius"] = 1
            }
            else
            {
                sectionsEnabled["Radius"] = 0
            }
        case categoryTableView:
            if (sectionsEnabled["Category"] == 0)
            {
                sectionsEnabled["Category"] = 1
            }
            else
            {
                sectionsEnabled["Category"] = 0
            }
        default:
            println("default called on didSelectRowAtIndexPath. doing nothing")
        }
        tableView.reloadData()
    }


}

