//
//  ReportsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
    
class ReportsViewController: UIViewController {
        
        private var tableView: UITableView!
        fileprivate var tableViewSectionsTitle: [String] = []
        var selected: String!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            self.tableViewSetup()
            self.tableView.delegate = self
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.transparentNavigationBar()
        
        
    }
        
        //MARK: - Aux Methods
        private func tableViewSetup() {
            let tableViewRect = CGRect(x: 0, y: 120, width: width, height: height)
            let tableViewCellNib = UINib(nibName: "ReportsTableViewCell", bundle: nil)
            
            
            self.tableView = UITableView(frame: tableViewRect , style: .plain)
            self.tableView.dataSource = self
            self.tableView.backgroundColor = .clear
            self.tableView.rowHeight = height / 5
            self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "idReportCell")
            self.tableView.clipsToBounds = true
            
            self.view.addSubview(tableView)
        }
        
    }
    
    //MARK: - Extensions
    //MARK: - Table View Data Source
extension ReportsViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        //        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //            return tableViewSectionsTitle[section]
        //        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: ReportsTableViewCell
            
            cell = tableView.dequeueReusableCell(withIdentifier: "idReportCell", for: indexPath as IndexPath) as! ReportsTableViewCell
            cell.backgroundColor = .clear
            cell.titleLabel.text = "Teste"
            cell.descriptionLabel.text = "aibcuabcpiabcoabc"
            
            return cell
        }
    }
    
    //MARK: - Table View Delegate
extension ReportsViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let cell = tableView.cellForRow(at: indexPath) as! ReportsTableViewCell
            
            //            gambi = cell.schoolName.text
            //
            //
            //            dismiss(animated: true, completion: nil)
        }
        
}
