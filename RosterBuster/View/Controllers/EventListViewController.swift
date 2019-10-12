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
    override func viewDidLoad() {
        super.viewDidLoad()
        eventViewModel.getEvents()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        eventViewModel.tableViewReloadCallback = {[unowned self] in
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }


}

extension EventListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventViewModel.eventDataSource?.keys.count ?? 0
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
    }
}
