//
//  ReportsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {
    @IBOutlet weak var newBtnOutlet: UIButton!
    @IBAction func buttonPressed(_ sender: Any) {
        print("btn pressed")
    }
    
    private var tableView: UITableView!
    fileprivate var tableViewSectionsTitle: [String] = []
    fileprivate var selectedIndex: Int!
    fileprivate var arrayDenuncias: [Denuncia] = []
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSetup()
        self.getReportsArray()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.transparentNavigationBar()
        
//        self.tableViewSetup()
//        self.getReportsArray()
    }
    
    //MARK: - Aux Methods
    private func tableViewSetup() {
        let tableViewRect = CGRect(x: 0, y: height / 4.73, width: width, height: height / 1.46)
        let tableViewCellNib = UINib(nibName: "ReportsTableViewCell", bundle: nil)
        
        self.tableView = UITableView(frame: tableViewRect , style: .plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = height / 5
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: "idReportCell")
        self.tableView.clipsToBounds = true
        self.tableView.layer.zPosition = -100
        
        self.view.addSubview(tableView)
    }
    
    private func getReportsArray() {
        var aluno = Aluno()
        
        if sharedDAO.aluno != nil {
            aluno = sharedDAO.aluno!
        }
        
        sharedDAO.getDenuncias(forAluno: aluno, completion: { arrayDenuncias in
            self.arrayDenuncias = arrayDenuncias
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDenuncias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ReportsTableViewCell
        let denuncia = arrayDenuncias[indexPath.row]
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idReportCell", for: indexPath as IndexPath) as! ReportsTableViewCell
        cell.backgroundColor = .clear
        cell.titleLabel.text = denuncia.categoria.rawValue
        cell.descriptionLabel.text = denuncia.descricao
        cell.selectionStyle = .none
        
        cell.statusBar.backgroundColor = getColor(forStatus: denuncia.status)
        
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
            destVc.report = arrayDenuncias[selectedIndex]
        }
    }
}
