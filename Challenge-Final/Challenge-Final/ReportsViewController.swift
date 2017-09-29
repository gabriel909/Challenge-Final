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
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = height / 5
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "idReportCell")
        self.tableView.clipsToBounds = true
        
        self.view.addSubview(tableView)
    }
    
    private func getColor(forStatus status: Status) -> UIColor {
        var colorHex: Int
        
        switch status {
            case .andamento:
                colorHex = 0xBBB500
            
            case .resolvido:
                colorHex = 0x008A4E
            
            case .nao_resolvido:
                colorHex = 0xBB0000
        }
        
        return UIColor(rgb: colorHex)
    }
}

//MARK: - Extensions
//MARK: - Table View Data Source
extension ReportsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ReportsTableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idReportCell", for: indexPath as IndexPath) as! ReportsTableViewCell
        cell.backgroundColor = .clear
        cell.titleLabel.text = "Teste"
        cell.descriptionLabel.text = "aibcuabcpiabcoabc"
        cell.selectionStyle = .none
        
        //MARK: - TODO Change color accordingly
        
        let status = (indexPath.row % 2 == 0) ? Status.andamento : Status.nao_resolvido
        
        cell.statusBar.backgroundColor = getColor(forStatus: status)
        
        return cell
    }
}

//MARK: - Table View Delegate
extension ReportsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetailsReport", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsReport" {
            let destVc = segue.destination as! DetailsReportsViewController
            //MARK: - TODO Send the selected aviso
            destVc.report = Denuncia(categoria: .Limpeza, descricao: "idfsnofinsdo", date: "sodifnos", status: .nao_resolvido, images: [], videos: [])
        }
    }
}
