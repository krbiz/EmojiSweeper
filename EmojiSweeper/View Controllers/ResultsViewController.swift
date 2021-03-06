//
//  ResultsTableViewController.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 08.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    let resultsViewCellIdentifier = "ResultCell"
    let resultCellNibName = "ResultCell"
    
    var results = [UserResult]()
    var levels = [Level]()
    
    var isTopResultsOnly = true {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Setup methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resultCell = UINib(nibName: resultCellNibName, bundle: nil)
        tableView.register(resultCell, forCellReuseIdentifier: resultsViewCellIdentifier)
        tableView.tableFooterView =
            UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        
        setupDataSource()
        
        localize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let text = String(format: "%@: %d", NSLocalizedString("Total wins", comment: ""), results.count)
        totalWinsLabel.text = text
        navigationItem.rightBarButtonItem?.isEnabled = results.count == 0 ? false : true
    }
    
    func localize() {
        segmentedControl.setTitle(NSLocalizedString("Top results", comment: ""), forSegmentAt: 0)
        segmentedControl.setTitle(NSLocalizedString("All results", comment: ""), forSegmentAt: 1)
    }
    
    // MARK: - IBActions
    
    @IBAction func actionBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionFilterResults(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isTopResultsOnly = true
        } else {
            isTopResultsOnly = false
        }
    }
    
    @IBAction func actionClearResult(_ sender: UIBarButtonItem) {
        let message = NSLocalizedString("Are you sure you want to delete the history?", comment: "")
        let deleteButtonTitle = NSLocalizedString("Delete", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: deleteButtonTitle, style: .destructive) { _ in
            self.removeAllData()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: -
    
    deinit {
        print("deinit of \(type(of: self))")
    }
    
}
    

// MARK: - UITableViewDataSource
    
extension ResultsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        levels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let levelSection = levels[section]
        let quantitySection = quantity(forLevel: levelSection)
        return isTopResultsOnly ? min(quantitySection, 3) : quantitySection
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let levelSectionIndex = levels[section].rawValue
        let description = Level(rawValue: levelSectionIndex)?.description
        return description
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resultsViewCellIdentifier,
                                                 for: indexPath) as! ResultCell

        let cellResult = result(forIndexPath: indexPath)
        
        cell.timeLabel.text = cellResult.timeString
        cell.dateLabel.text = cellResult.dateString
        cell.bestTimeLabel.isHidden = indexPath.row == 0 ? false : true
        
        return cell
    }

}

// MARK: - UITableViewDelegate

extension ResultsViewController {
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.contentView.backgroundColor = .bgGrayColor
        headerView.textLabel?.textColor = .white
        headerView.textLabel?.textAlignment = .center
    }
    
}
