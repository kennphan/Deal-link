//
//  ShopsController.swift
//  Deal-link
//
//  Created by kp on 8/09/2014.
//  Copyright (c) 2014 tekkup. All rights reserved.
//

import UIKit

class ShopsController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    @IBOutlet var shopTableView: UITableView!

    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunesFor("Angry Birds");
        
    }

    func searchItunesFor(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        //var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        //var urlPath = "https://itunes.apple.com/search?term=angry&media=software"
        var urlPath = "http://deal-link.herokuapp.com/shops"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        //println("Search iTunes API at URL \(url)")
        
        connection.start()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell") as UITableViewCell!
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary

        //cell.textLabel.text = rowData["trackName"] as String
        cell.textLabel.text = rowData["name"] as String

        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        //var urlString: NSString = rowData["artworkUrl60"] as NSString
        var urlString: NSString = "http://a90.phobos.apple.com/us/r30/Purple4/v4/60/14/b2/6014b21c-ab49-719b-4643-9e7e34f09eba/Icon.png" as NSString
        var imgURL: NSURL = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.imageView.image = UIImage(data: imgData)
        
        // Get the formatted price string for display in the subtitle
        //var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        var formattedPrice: NSString = rowData["userId"] as NSString
        
        cell.detailTextLabel.text = formattedPrice
        
        
        
        
        /*
        cell.textLabel.text = "Row #\(indexPath.row)"
        cell.detailTextLabel.text = "Subtitle #\(indexPath.row)"
        */
        
        return cell
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
        println("Recieved response")
    }
    
    
    
    
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the recieved chunk of data to our data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert it to a string
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
//print(dataAsString)

var testJSONdata = JSONValue(self.data)
print(testJSONdata)
        
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError
        //var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

        var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray // as NSDictionary
        

        self.tableData = jsonResult
        self.shopTableView.reloadData()
        /*
        if jsonResult.count > 0 {
            var results: NSArray = jsonResult["results"] as NSArray
            self.tableData = results
            self.shopTableView.reloadData()
            
        }
        */


        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
