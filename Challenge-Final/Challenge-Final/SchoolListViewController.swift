//
//  SchoolListViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 18/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//


import UIKit
import Foundation

class SchoolListViewController: UIViewController {
    fileprivate var tableView: UITableView!
    fileprivate var tableViewDic: [String : [String]] = [:]
    fileprivate var tableViewSectionsTitle: [String] = []
    fileprivate var arrayEscolas: [Escola]!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    var selected: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableViewSetup()
        self.getSchoolArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Aux Methods
    private func tableViewSetup() {
        let tableViewRect = CGRect(x: 0, y: 0, width: width, height: height)
        let tableViewCellNib = UINib(nibName: "SchoolsTableViewCell", bundle: nil)
        
        self.tableView = UITableView(frame: tableViewRect , style: .plain)
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.sectionIndexColor = .clear
        self.tableView.rowHeight = height / 8.4
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "idNormalCell")
        self.tableView.clipsToBounds = true
        
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        self.tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    private func getSchoolArray() {
        sharedDAO.getEscolas(completion: { arrayEscolas in
            self.arrayEscolas = arrayEscolas

            DispatchQueue.main.async {
                self.populateDic(self.arrayEscolas)
            }
        })
    }
    
    fileprivate func populateDic(_ arrayDic: [Escola]) {
        var array: [String] = []
        
        for escola in arrayDic {
            array.append(escola.nomeEscola)
        }
        
        var result = [String : [String]]()
        let characters = Array(Set(array.flatMap({ $0.characters.first }))).sorted()
        
        for character in characters.map({ String($0) }) {
            result[character] = array.filter({ $0.hasPrefix(character) })
        }
        
        self.tableViewDic = result
        self.tableViewSectionsTitle = Array(self.tableViewDic.keys).sorted()
        self.tableView.reloadData()
    }
    
    fileprivate func findSchool(withName name: String) -> [Escola] {
        var filteredSchool: [Escola] = []
     
        filteredSchool = arrayEscolas.filter( { (escola : Escola) -> Bool in
            return escola.nomeEscola.lowercased().contains(name.lowercased())
        })
        
        return filteredSchool
    }
}

//MARK: - Extensions
//MARK: - Table View Data Source
extension SchoolListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDic.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSectionsTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = tableViewSectionsTitle[section]
        
        return tableViewDic[index]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SchoolsTableViewCell
        let index = tableViewSectionsTitle[indexPath.section]
        let cellName = tableViewDic[index]?[indexPath.row]
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idNormalCell", for: indexPath as IndexPath) as! SchoolsTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.schoolName.text = cellName
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//
//        headerView.backgroundColor = .clear
//        headerView.layer.zPosition = -10
//
//        return headerView
//    }
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

//MARK: - Table View Delegate
extension SchoolListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SchoolsTableViewCell
        gambi = self.findSchool(withName: cell.schoolName.text!).first

        dismiss(animated: true, completion: nil)
    }
}

extension SchoolListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if !searchBarIsEmpty() {
            let arraySearch = findSchool(withName: searchBar.text!)
            self.populateDic(arraySearch)
            
        } else {
            populateDic(arrayEscolas)
            
        }
    }
}

extension SchoolListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty() {
            let arraySearch = findSchool(withName: searchController.searchBar.text!)
            self.populateDic(arraySearch)
            
        } else {
            populateDic(arrayEscolas)
            
        }
    }
}
