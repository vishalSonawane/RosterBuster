//
//  APIManager.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 10/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation

 class APIManager{
    //create singletone object
    static let shared = APIManager()
    
    private init(){}
    
    func getEventData(_ completeion:@escaping ([Event]?)->()){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: URL(string: APIEndpoints.getEvents)!) { (data, response, error) in
            guard error == nil else{
                print("Error in fetching event data: \(String(describing: error))")
                completeion(nil)
                return
            }
            if let data = data{
                do{
                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completeion(events)
                }catch{
                    print("Failed to convert Event objects")
                    completeion(nil)
                }
            }
        }.resume()
    }
}
