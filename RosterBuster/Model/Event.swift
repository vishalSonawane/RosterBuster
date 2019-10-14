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
    
    var sourceToDestinationText:String{
        guard departure != nil, destination != nil else {
            return "-"
        }
        switch dutyCode?.lowercased() {
        case "flight":
             return "\(departure!) - \(destination!)"
        default:
            return dutyCode?.capitalized ?? "-"
        }
       
    }
    var matchCrewText:String{
       return dutyCode?.lowercased() == "standby" ? "Match Crew" : ""
    }
    var layoverLocationText:String{
        switch dutyCode?.lowercased() {
        case "flight":
            return  ""
        default:
            return destination ?? ""
        }
    }
    var timeText:String{
        guard timeArrive != nil,timeDepart != nil,!timeArrive!.isEmpty,!timeDepart!.isEmpty else {
            return ""
        }
        func getTimeString(dutyCode:String) -> String{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dutyCode == "layover" ? "HH:mm" : "HH:mm:ss"
            let time2 = dateFormatter.date(from: timeArrive!)
            let time1 = dateFormatter.date(from: timeDepart!)
            guard time1 != nil,time2 != nil else {
                return ""
            }
            if dutyCode == "layover"{
                let newDate = time1!.addingTimeInterval(time2!.timeIntervalSince1970)
                let hoursAndMinutes = dateFormatter.string(from: newDate)
                return "\(hoursAndMinutes) hours"
            }else{
                dateFormatter.dateFormat = "HH:mm"
                let t1 = dateFormatter.string(from: time1!)
                let t2 = dateFormatter.string(from: time2!)
                return "\(t1) - \(t2)"
            }
            
        }
        switch dutyCode?.lowercased() {
        case "layover":return getTimeString(dutyCode: "layover")
        case "standby":return getTimeString(dutyCode: "standby")
        default:
            return "\(timeDepart ?? "") - \(timeArrive ?? "")"
        }
    }
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
