//
//  EventViewModel.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 11/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation

typealias TableViewReloadCallback = ()->()

class EventViewModel {
    
    var tableViewReloadCallback:TableViewReloadCallback?
    
    var eventDataSource:[String?:[Event]]? {
       didSet{
            tableViewReloadCallback?()
        }
    }
   
    
    init() {
        
    }
    func getEvents(){
        APIManager.shared.getEventData { [unowned self] events in
            guard events != nil, !events!.isEmpty else{
                print("No data for events found")
                self.tableViewReloadCallback?()
                return
            }
            //self.events = events
            let groupedEvents = Dictionary(grouping: events!, by: { $0.date})
            self.eventDataSource = groupedEvents
        }
    }
    
}
