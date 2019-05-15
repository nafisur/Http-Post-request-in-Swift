//
//  WebServices.swift
//  
//
//  Created by Nafisur Ahmed on 15/05/19.
//  Copyright © 2019 Nafisur Ahmed. All rights reserved.
//

import Foundation

class Webservices {
    
    func userLogin(email: String,password: String, completion: @escaping (_ serverResponse: NSDictionary) -> Void)
    {
        let parameters = ["email": email, "password": password]
        let url = URL(string: loginURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            do {
                //create json object from data
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    completion(jsonData)
                }
                    catch{
                        let error: NSDictionary = ["status":"Error"]
                        completion(error)
                    }
        })
        task.resume()
    
    }//func
    
}//class
