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
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    var selected: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableViewSetup()
        self.populateDic()
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
        
        self.tableView.delegate = self
        
        self.view.addSubview(tableView)
    }
    
    private func populateDic() {
        var array: [String] = []
        
        sharedDAO.getEscolas(completion: { arrayEscolas in
            self.arrayEscolas = arrayEscolas
            
            for escola in arrayEscolas {
                array.append(escola.nomeEscola)
            }
            
            var result = [String : [String]]()
            
            let characters = Array(Set(array.flatMap({ $0.characters.first }))).sorted()
            
            for character in characters.map({ String($0) }) {
                result[character] = array.filter({ $0.hasPrefix(character) })
            }
            
            self.tableViewDic = result
            self.tableViewSectionsTitle = Array(self.tableViewDic.keys).sorted()

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    fileprivate func findSchool(withName name: String) -> Escola? {
        for escola in arrayEscolas {
            if escola.nomeEscola == name {
                return escola
            }
        }
        
        return nil
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
}

//MARK: - Table View Delegate
extension SchoolListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SchoolsTableViewCell
        
        gambi = self.findSchool(withName: cell.schoolName.text!)

        dismiss(animated: true, completion: nil)
    }
}
