//
//  EventListViewController.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 10/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    var eventViewModel = EventViewModel()
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "EventListCell"
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(refreshEvents),for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        handleInternetConnectivity()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        eventViewModel.tableViewReloadCallback = {[unowned self] in
            OperationQueue.main.addOperation {
                Utilities.hideLoader()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
    }
    func handleInternetConnectivity(){
        OperationQueue.main.addOperation {
            NetworkManager.isReachable(completed: { [unowned self] status in
                Utilities.showLoader(message: Messages.loadingEvents)
                self.eventViewModel.getEvents()
            })
            NetworkManager.isUnreachable(completed:  { [unowned self] status in
                self.eventViewModel.getEventsFromDB()
            })
        }
        
    }
    @objc func refreshEvents(){
        NetworkManager.isReachable { [unowned self] _ in
            self.eventViewModel.getEvents()
        }
        
    }
}

extension EventListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventViewModel.eventDataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard eventViewModel.eventDataSource != nil else {
            return 0
        }
        return Array(eventViewModel.eventDataSource!)[section].value.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(eventViewModel.eventDataSource!)[section].key
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventListCell
        let event = Array(eventViewModel.eventDataSource!)[indexPath.section].value[indexPath.row]
        cell.setup(event: event)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show details vc
        let selectedEvent =  Array(eventViewModel.eventDataSource!)[indexPath.section].value[indexPath.row]
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        detailsVC.event = selectedEvent
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
}
