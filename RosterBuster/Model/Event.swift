//
//  Event.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 10/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation
import RealmSwift

class Event:Object,Codable{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var flightnr:String?
    @objc dynamic var date:String?
    @objc dynamic var aircraftType:String?
    @objc dynamic var tail:String?
    @objc dynamic var departure:String?
    @objc dynamic var destination:String?
    @objc dynamic var timeDepart:String?
    @objc dynamic var timeArrive:String?
    @objc dynamic var dutyID:String?
    @objc dynamic var dutyCode:String?
    @objc dynamic var captain:String?
    @objc dynamic var firstOfficer:String?
    @objc dynamic var flightAttendant:String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys:String,CodingKey {
        case flightnr = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case timeDepart = "Time_Depart"
        case timeArrive = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
        
    }
    
    //Save Event object
    func save(){
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(self, update: .all)
            }
        } catch  {
            print("Error while savng events \(error)")
        }
    }
    //Get all saved Event objects
    static func getAllStoredEvents() -> [Event]?{
        do {
            let realm = try Realm()
            return Array(realm.objects(Event.self))
        } catch  {
            print("Error while savng events \(error)")
            return nil
        }
    }
}
