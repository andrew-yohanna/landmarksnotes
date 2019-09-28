//
//  NotesListTableViewController.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    var viewModel: NotesViewModel!
    var logout: (() -> Void)?
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onNotesFiltered = {
            self.tableView.reloadData()
        }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search notes"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        searchController.searchBar.delegate = self
        definesPresentationContext = true

        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notesToShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
 
        // Configure the cell...
        let landmarkNote = viewModel.notesToShow[indexPath.row]
        cell.textLabel?.text = landmarkNote.note
        cell.detailTextLabel?.text = "By: \(landmarkNote.userName)"
        return cell
    }
}

extension NotesListTableViewController {
    @objc func logoutUser() {
        self.logout?()
    }
}
extension NotesListTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.filterContentForSearchText(searchBar.text!)
    }
}

extension NotesListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterContentForSearchText(searchController.searchBar.text!)
    }
}
