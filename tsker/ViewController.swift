//
//  ViewController.swift
//  tsker
//
//  Created by Radu Lemnaru on 06/06/14.
//  Copyright (c) 2014 Radu Lemnaru. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource {
    
    // Define public variables and constants
    
    var textField: UITextField!
    var tableView: UITableView!
    var data: NSMutableData = NSMutableData()
    var tableViewData = String[]()
            
    let customKey = "task"
    let baseURL = "http://tsker-120236.euw1.nitrousbox.com/"
    let tasks = "tasks"
    
    //Define Colours
    
    let lightOrange:UIColor = UIColor(red: 0.966, green: 0.467, blue: 0.224, alpha: 1)
    let medOrange:UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    let darkOrange:UIColor = UIColor(red: 0.796, green: 0.263, blue: 0.106, alpha: 1)
    let green:UIColor = UIColor(red: 0.251, green: 0.831, blue: 0.0494, alpha: 1)
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup text field
        
        self.textField = UITextField(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        self.textField.backgroundColor = lightOrange
        self.textField.font = UIFont(name: "AvenirNext-Regular", size: 25)
        self.textField.textColor = UIColor.whiteColor()
        self.textField.textAlignment = NSTextAlignment.Center
        self.textField.delegate = self
        self.view.addSubview(self.textField)
        
        // Setup table view
        
        self.tableView = UITableView(frame: CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100), style: UITableViewStyle.Plain)
        self.tableView.registerClass(MyTableViewCell.self, forCellReuseIdentifier: "MyCell")
        self.tableView.backgroundColor = darkOrange
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        // Setup Table View Data
        self.loadDataIntoContainer() // Solution needs implementation
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadDataIntoContainer(){
        
        var url:NSURL = NSURL.URLWithString(self.baseURL.stringByAppendingPathComponent(self.tasks))
        //var url:NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk")
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // NSURLConnection version
        // var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        //connection.start()
        
        // NSURLSession version
        var config:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session:NSURLSession = NSURLSession(configuration: config)
        
        var dataTask:NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data: NSData!, response: NSURLResponse! , error:NSError!) in
            if(error == nil){
                var tasks = data
                var responseData : NSDictionary = NSJSONSerialization.JSONObjectWithData(tasks, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                self.parseResponse(responseData)
            }else{
                println(data)
                println(response)
                println(error)
            }
            })
        
        dataTask.resume()
    }
    
    func parseResponse(responseData: NSDictionary) {
        for (key:AnyObject, value:AnyObject) in responseData{
            if key.isEqual(self.customKey){
                println(value as String)
                tableViewData.append(value as String)
                textField.text = ""
                tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.tableViewData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell {
        let myNewCell:MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as MyTableViewCell
        myNewCell.text = self.tableViewData[indexPath.row]
        
        return myNewCell
    }
    
    // Table View Delegate
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        let mySelectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        
        mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        // Colours
        mySelectedCell.tintColor = UIColor.whiteColor()
        mySelectedCell.detailTextLabel.textColor = UIColor.whiteColor()
        mySelectedCell.backgroundColor = green
        
        let myDate:NSDate = NSDate()
        var myDateFormatter:NSDateFormatter = NSDateFormatter()
        myDateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        mySelectedCell.detailTextLabel.text = myDateFormatter.stringFromDate(myDate)
    }
    
    
    // Text Field Delegate
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        if(textField.text != ""){
            tableViewData.append(textField.text)
            textField.text = ""
            self.tableView.reloadData()
            
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // Handle Connection
    
    //    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
    //        println("Connection failed.\(error.localizedDescription)")
    //    }
    //
    //    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
    //        println("Recieved response")
    //    }
    //
    //    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
    //        // Recieved a new request, clear out the data object
    //        self.data = NSMutableData()
    //    }
    //
    //    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
    //        // Append the recieved chunk of data to our data object
    //        self.data.appendData(data)
    //    }
    //
    //    func connectionDidFinishLoading(connection: NSURLConnection!) {
    //        // Request complete, self.data should now hold the resulting info
    //        // Convert it to a string
    //        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
    //
    //        // Convert the retrieved data in to an object through JSON deserialization
    //        var err: NSError
    //        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    //
    //        if jsonResult.count > 0 && jsonResult["results"].count > 0 {
    ////            self.tableViewData = results
    ////            self.tableView.reloadData()
    //        }
    //        
    //    }
    
}
