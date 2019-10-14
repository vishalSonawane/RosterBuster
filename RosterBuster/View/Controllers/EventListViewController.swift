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
    private var finishedLoadingInitialTableCells = false
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
                Utilities.showLoader(message: "Geting event details..")
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !finishedLoadingInitialTableCells {
            finishedLoadingInitialTableCells = true
        }
            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: 50)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show details vc
    }
}
