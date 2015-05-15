//
//  CoursesTableViewController.swift
//  WebService_SE
//
//  Created by Pedro Lopes on 5/15/15.
//  Copyright (c) 2015 Pedro Lopes. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController
{
    
    var session: NSURLSession!
    var courses = [[NSObject:AnyObject]]()
    
    required init!(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
        fetchFeed()
    }
    
    func fetchFeed()
    {
        let requestString = "http://bookapi.bignerdranch.com/courses.json"
        if let url = NSURL(string: requestString)
        {
            let req = NSURLRequest(URL: url)
            let dataTask = session.dataTaskWithRequest(req)
                {
                (data, response, error) in
                
                if data != nil
                {
                    
                    var error: NSError?
                    
                    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [NSObject:AnyObject]
                    {   //transforma json em object
                        if let courseArray: AnyObject = jsonObject["courses"]
                        {   //object em dictionary
                            if let cs = courseArray as? [[NSObject:AnyObject]]
                            {
                                self.courses = cs
                                println("\(self.courses)")
                                
                                //Thread
                                
                                NSOperationQueue.mainQueue().addOperationWithBlock()
                                {
                                    self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                                }
                            }
                            
                        }
                        
                        //teste imprime identado
                        //println("\(jsonObject)")
                        
                    }
                   
                    /*
                    //teste de retorno
                    if let jsonString = NSString (data: data, encoding: NSUTF8StringEncoding){
                        println("\(jsonString)")
                    }
                    */
                
                }
                else
                {
                    println("Error fetching courses: \(error.localizedDescription)")
                }
            }
            
            dataTask.resume()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return courses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! UITableViewCell
        
        let course = courses[indexPath.row]
        
        if let title: AnyObject = course["title"]
        {
            if let titleString = title as? String
            {
                cell.textLabel?.text = titleString
            }
            
        }

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
