//
//  ContentsTVC.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/17/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class ContentsTVC: UITableViewController {

    let viewModel = ContentsTVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableCell", for: indexPath)

        cell.textLabel?.text = viewModel.contents[indexPath.row]
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contentDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ContentDetailsVC") as? ContentDetailsVC {
            contentDetailsVC.viewModel.viewStateTitle = viewModel.contents[indexPath.row]
            showDetailViewController(contentDetailsVC, sender: self)
        }
    }
}
