//
//  CoursesViewController.swift
//  WebService_SE
//
//  Created by Pedro Lopes on 5/15/15.
//  Copyright (c) 2015 Pedro Lopes. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    var session: NSURLSession
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
        fetchFeed()
    }
    
    func fetchFeed(){
        let requestString = "http://bookapi.bignerdranch.com/courses.json"
        if let url = NSURL(string: requestString) {
            let req = NSURLRequest(URL: url)
            let dataTask = session.dataTaskWithRequest(req){
                (data, response, error) in
                
                if data != nil{
                    //doSomething
                    
                    //teste de retorno
                    if let jsonString = NSString (data: data, encoding: NSUTF8StringEncoding){
                        println("\(jsonString)")
                    }
                }
                else {
                    println("Error fetching courses: \(error.localizeDescription)")
                }
            }
            
            dataTask.resume()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
