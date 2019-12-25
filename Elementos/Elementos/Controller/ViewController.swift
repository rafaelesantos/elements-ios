//
//  ViewController.swift
//  Elementos
//
//  Created by Rafael Escaleira on 24/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicador: UIActivityIndicatorView!
    
    var elements: [ElementsCodable] = []
    var value: [ElementsCodable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search anything"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        FirebaseObserve.elements { (value) in
             
            self.elements = value
            self.value = value
            self.tableView.reloadData()
            self.activityIndicador.stopAnimating()
        }
    }
    
    // MARK: Actions
    
    @objc private func wikiButtonAction(_ sender: UIButton) {
        
        guard let url = URL(string: self.elements[sender.tag].source ?? "") else { return }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height / 3)
        guard let popoverController = controller.popoverPresentationController else { return }
        popoverController.sourceView = sender
        popoverController.sourceRect = sender.bounds
        popoverController.permittedArrowDirections = .any
        popoverController.delegate = self
        
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: Update Search

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text == "" {
            
            self.elements = self.value
            self.tableView.reloadData()
            return
        }
        
        else {
            
            let searchText = searchController.searchBar.text!
            
            self.elements = self.value.filter({ (element) -> Bool in
                
                return (element.name?.lowercased().contains(searchText.lowercased()) ?? false) || (element.category?.lowercased().contains(searchText.lowercased()) ?? false) || (element.discovered_by?.lowercased().contains(searchText.lowercased()) ?? false) || (element.summary?.lowercased().contains(searchText.lowercased()) ?? false) || (element.symbol?.lowercased().contains(searchText.lowercased()) ?? false) || String(format: "%.3f", element.atomic_mass ?? 0).replacingOccurrences(of: ".", with: ",").contains(searchText.replacingOccurrences(of: ".", with: ",")) || String(format: "%d", element.number ?? 0).contains(searchText)
            })
            
            self.tableView.reloadData()
        }
    }
}

// MARK: Table View Configure

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = self.elements.count == 0 ? .none : .singleLine
        return self.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementsTableViewCell", for: indexPath) as? ElementsTableViewCell else { return UITableViewCell() }
        
        let item = self.elements[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.categoryLabel.text = item.category?.uppercased()
        cell.nameLabel.text = item.name?.lowercased().capitalized
        cell.discoveredByLabel.text = item.discovered_by?.lowercased().capitalized ?? " "
        cell.summaryLabel.text = item.summary
        cell.symbolLabel.text = item.symbol?.lowercased().capitalized
        cell.atomicMassLabel.text = String(format: "%.3f", item.atomic_mass ?? 0).replacingOccurrences(of: ".", with: ",")
        cell.atomicNumberLabel.text = "\(item.number ?? 0)"
        
        cell.categoryLabel.textColor = UIColor.hexStringToUIColor(hex: item.color ?? UIColor(named: "elements")!.toHexString)
        cell.symbolLabel.backgroundColor = cell.categoryLabel.textColor
        
        cell.showMoreButton.tag = indexPath.row
        cell.showMoreButton.addTarget(self, action: #selector(self.wikiButtonAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let item = self.elements[indexPath.row]
        
        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            
            UIView.animate(withDuration: 0.2, animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (_) in
                
                guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MoreInfoViewController") as? MoreInfoViewController else { return }
                controller.element = item
                self.navigationController?.navigationBar.tintColor = UIColor.hexStringToUIColor(hex: item.color ?? UIColor(named: "elements")!.toHexString)
                DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
            }
        }
    }
}

// MARK: Table View Cell Configure

public class ElementsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var atomicMassLabel: UILabel!
    @IBOutlet weak var atomicNumberLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
}
