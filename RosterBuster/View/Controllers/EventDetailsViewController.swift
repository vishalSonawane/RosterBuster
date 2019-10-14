//
//  EventDetailsViewController.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 14/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblImg:UILabel!
    @IBOutlet weak var lblFlightNo:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblAircraftType:UILabel!
    @IBOutlet weak var lblTail:UILabel!
    @IBOutlet weak var lblDeparture:UILabel!
    @IBOutlet weak var lblDestination:UILabel!
    @IBOutlet weak var lblDepartureTime:UILabel!
    @IBOutlet weak var lblArrivalTime:UILabel!
    @IBOutlet weak var lblDutyId:UILabel!
    @IBOutlet weak var lblDutyCode:UILabel!
    @IBOutlet weak var lblCaptain:UILabel!
    @IBOutlet weak var lblFirstOfficer:UILabel!
    @IBOutlet weak var lblFlightAttendant:UILabel!
    
    var event:Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        containerView.layer.cornerRadius = 5.0
        lblImg.layer.cornerRadius = lblImg.frame.height / 2
        lblImg.layer.borderColor = UIColor.white.cgColor
        lblImg.layer.borderWidth = 5.0
        lblImg.setIconForEventType(type: EventType(rawValue: event?.dutyCode?.lowercased() ?? "") ?? EventType.undifined)
        lblImg.font = UIFont.fontAwesome(ofSize: 50, style: .solid)
        
        if let flightNo = event?.flightnr,!flightNo.isEmpty{
            lblFlightNo.text = flightNo
        }else{
            lblFlightNo.text = "---"
        }
        if let date = event?.date,!date.isEmpty{
            lblDate.text = date
        }else{
            lblDate.text = "---"
        }
        if let aircraftType = event?.aircraftType,!aircraftType.isEmpty{
            lblAircraftType.text = aircraftType
        }else{
            lblAircraftType.text = "---"
        }
        if let tail = event?.tail,!tail.isEmpty{
            lblTail.text = tail
        }else{
            lblTail.text = "---"
        }
        
        if let date = event?.date,!date.isEmpty{
            lblDate.text = date
        }else{
            lblDate.text = "---"
        }
        if let aircraftType = event?.aircraftType,!aircraftType.isEmpty{
            lblAircraftType.text = aircraftType
        }else{
            lblAircraftType.text = "---"
        }
        if let tail = event?.tail,!tail.isEmpty{
            lblTail.text = tail
        }else{
            lblTail.text = "---"
        }
        
        if let departure = event?.departure,!departure.isEmpty{
            lblDeparture.text = departure
        }else{
            lblDeparture.text = "---"
        }
        if let destination = event?.destination,!destination.isEmpty{
            lblDestination.text = destination
        }else{
            lblDestination.text = "---"
        }
        
        
        if let departureTime = event?.timeDepart,!departureTime.isEmpty{
            lblDepartureTime.text = departureTime
        }else{
            lblDepartureTime.text = "---"
        }
        if let arrival = event?.timeArrive,!arrival.isEmpty{
            lblArrivalTime.text = arrival
        }else{
            lblArrivalTime.text = "---"
        }
        if let dutyId = event?.dutyID,!dutyId.isEmpty{
            lblDutyId.text = dutyId
        }else{
            lblDutyId.text = "---"
        }
        if let dutyCode = event?.dutyCode,!dutyCode.isEmpty{
            lblDutyCode.text = dutyCode
        }else{
            lblDutyCode.text = "---"
        }
        if let captain = event?.captain,!captain.isEmpty{
            lblCaptain.text = captain
        }else{
            lblCaptain.text = "---"
        }
        if let firstOfficer = event?.firstOfficer,!firstOfficer.isEmpty{
            lblFirstOfficer.text = firstOfficer
        }else{
            lblFirstOfficer.text = "---"
        }
        if let flightAttendant = event?.flightAttendant,!flightAttendant.isEmpty{
            lblFlightAttendant.text = flightAttendant
        }else{
            lblFlightAttendant.text = "---"
        }
    }

}
