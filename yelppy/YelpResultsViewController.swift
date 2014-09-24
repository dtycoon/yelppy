//
//  YelpResultsViewController.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/22/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit


class SearchResult {
    
    var name: String!
    var stars: String!
    var numOfReviews: Int!
    var address: String!
    var city: String!
    var state: String!
    var country: String!
    var zipcode: String!
    var categories: [String]! = []
    var imageUrl: String!
    var categoryStr: String!
    var neighborhood: String! }


 class YelpResultsViewController: UIViewController,  UITableViewDelegate,  UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate     {

    @IBOutlet weak var tableView: UITableView!
    var client: YelpClient!
    
    var searchBar:UISearchBar!
    
    let yelpConsumerKey = "x7oE8BaprWwrIKNi2vbGtQ"
    let yelpConsumerSecret = "YhIXGBmZdUwnWVmIy111jwS_HYo"
    let yelpToken = "7vXjwNpUGizQM1cKqvgvhgokCFtj8v5r"
    let yelpTokenSecret = "qJ-5FANUU0d8y_82gqLyg15rjwI"
    
    var yelpDict: [NSDictionary] = []
    var searchActive:Bool = false
    var searchQuery:NSString!
    
    func loadSearchResults(searchValue:String)
    {
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchValue, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            
            self.yelpDict = response["businesses"] as [NSDictionary]
            println("list of businesses = \(self.yelpDict.count)")
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }

    }

    
    @IBAction func onTap(sender: AnyObject) {
    println(" onTap ")
            view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tintColor = UIColor.lightGrayColor()
        tableView.separatorColor = UIColor.darkGrayColor()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 196.0/255.0, green:18.0/255.0, blue:0.0/0.0 , alpha:1.0)
        
        navigationController?.navigationBar.barTintColor =  UIColor(red: 1.0, green:0.0, blue:0.0 , alpha:1.0)
        self.searchBar = UISearchBar(frame:CGRectMake(50, 0, 100, 40))
        self.searchBar!.delegate = self
     //   self.searchBar.
        self.navigationItem.titleView = self.searchBar!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "searchQuery:", name: "yelpSearchQuery", object:nil)
        loadSearchResults("Thai")
    }
    
    
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        println(" searchBar searchText = " + searchText )
        if searchText.utf16Count > 0 {
            self.searchActive = true
        }
        else {
            self.searchActive = false
            self.resignFirstResponder()
            self.view.endEditing(true)
        }
        self.searchQuery = searchText
        self.tableView!.reloadData()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(" searchBar searchBarSearchButtonClicked = "+searchQuery )
        self.searchActive = false
        loadSearchResults(searchQuery)
        self.view.endEditing(true)
         self.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchActive = false
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        if (yelpDict.count == 0)
        {
        return 0;
        }
        else
        {
        return yelpDict.count
        }
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("YelpTableViewCell") as YelpTableViewCell
        var yelpListing = yelpDict[indexPath.row]
        
        
        var reviewCount = yelpListing["review_count"] as Int
        
        if((yelpListing["name"] as? String) != nil)
        {
            cell.businessName.text = yelpListing["name"] as? String
        }
        
        var yelpRatingImage = yelpListing["rating_img_url"] as String
        cell.businessStars.setImageWithURL(NSURL(string: yelpRatingImage))
        var yelpImage = yelpListing["image_url"] as? String
        
        if(yelpImage != nil)
        {
        cell.businessImage.setImageWithURL(NSURL(string: yelpImage!))
        }
        
        
        
        var locationString =  yelpListing["location"] as NSDictionary
        var addString = locationString["display_address"] as NSArray?
        var displayAddress = addString![0] as String
       cell.businessAddress.text = displayAddress
        cell.businessReviews.text = "\(reviewCount) reviews"
       
        let catagories = yelpListing["categories"] as NSArray?
        var allTags: String = ""
        if catagories?.count > 0 {
            allTags += (catagories![0] as NSArray)[0] as NSString
            if catagories!.count > 1 {
                for i in 1...(catagories!.count - 1) {
                    allTags += ", "
                    allTags += (catagories![i] as NSArray)[0] as String
                }
            }
        }
        cell.businessCategory.text = allTags
        
        
       
        
 //       var categoryStr = (yelpListing["categories"] as NSDictionary)[0][0] as String;
        
        //@IBOutlet weak var categoryLabel: UILabel!
        
        return cell
        
    }
    
    
func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
   
    

}
