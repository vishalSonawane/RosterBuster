//
//  AppConstants.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 11/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation

enum EventType:String {
    case flight = "flight"
    case off = "off"
    case layover = "layover"
    case standby = "standby"
    case positioning = "positioning"
    case undifined
}
struct APIEndpoints {
    static let getEvents = "https://www.rosterbuster.aero/wp-content/uploads/dummy-response.json"
}
struct Messages {
    static let loadingEvents = "Geting event details.."
    static let matchCrew  = "Match Crew"
}
struct DutyCodeStrings {
    static let layover = "layover"
    static let off = "off"
    static let standby = "standby"
    static let positioning = "positioning"
    static let flight = "flight"
}
