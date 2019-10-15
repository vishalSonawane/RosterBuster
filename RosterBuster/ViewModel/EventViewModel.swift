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
    
    var eventDataSource:[(key: String?, value: [Event])]?{ 
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
            self.eventDataSource?.removeAll()
            OperationQueue.main.addOperation {
                Event.deleteAllStoredEvents { (success) in
                    //save events
                    for event in events!{
                        event.save()
                    }
                }
                
            }
            
            let groupedEvents = Dictionary(grouping: events!, by: { $0.date})
            let arr = groupedEvents.sorted { (tuple1, tuple2) -> Bool in
                guard self.dateForSorting(dateString: tuple1.key) != nil,self.dateForSorting(dateString: tuple2.key) != nil else {return false}
                return self.dateForSorting(dateString: tuple1.key)! < self.dateForSorting(dateString: tuple2.key)!
            }
            self.eventDataSource = arr
        }
    }
    func dateForSorting(dateString:String?)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let date1 = dateFormatter.date(from: dateString ?? "")
        return date1
    }
    //In offline mode get saved events
    func getEventsFromDB(){
        self.eventDataSource?.removeAll()
        if let savedEvents = Event.getAllStoredEvents(){
            let groupedEvents = Dictionary(grouping: savedEvents, by: { $0.date})
            let arr = groupedEvents.sorted { (tuple1, tuple2) -> Bool in
                guard self.dateForSorting(dateString: tuple1.key) != nil,self.dateForSorting(dateString: tuple2.key) != nil else {return false}
                return self.dateForSorting(dateString: tuple1.key)! < self.dateForSorting(dateString: tuple2.key)!
            }
            self.eventDataSource = arr
        }else{
            print("No saved events found..")
            self.tableViewReloadCallback?()
        }
    }
    
}
