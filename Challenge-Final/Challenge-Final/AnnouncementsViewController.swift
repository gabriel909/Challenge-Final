//
//  AnnouncementsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class AnnouncementsViewController: UIViewController {
    
    private var tableView: UITableView!
    fileprivate var tableViewDic: [String : [String]] = [:]
    fileprivate var tableViewSectionsTitle: [String] = []
    fileprivate var selectedIndex: Int!
    
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
    
    //MARK: - Aux Methods
    private func tableViewSetup() {
        let tableViewRect = CGRect(x: 0, y: 120, width: width, height: height)
        let tableViewCellNib = UINib(nibName: "AnnouncementsTableViewCell", bundle: nil)
        
        self.tableView = UITableView(frame: tableViewRect , style: .plain)
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = height / 5
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "idAnnouncCell")
        self.tableView.clipsToBounds = true
        
        self.view.addSubview(tableView)
    }
}

//MARK: - Extensions
//MARK: - Table View Data Source
extension AnnouncementsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AnnouncementsTableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idAnnouncCell", for: indexPath as IndexPath) as! AnnouncementsTableViewCell
        cell.backgroundColor = .clear
        cell.titleLabel.text = "Teste"
        cell.descriptionLabel.text = "aibcuabcpiabcoabc"
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - Table View Delegate
extension AnnouncementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetailsAnnoun", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsAnnoun" {
            let destVc = segue.destination as! DetailsAnnouncementsViewController
            //MARK: - TODO Send the selected aviso
            destVc.aviso = Aviso(titulo: "Teste", descricao: "aibcuabcpiabcoabc", data: "", image: "", id: 1)
        }
    }
}
