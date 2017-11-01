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
    
    lazy var tableView: UITableView! = {
        let tableViewCellNib = UINib(nibName: "ReportsTableViewCell", bundle: nil)
        
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.rowHeight = height / 5
        tableview.register(tableViewCellNib, forCellReuseIdentifier: "idReportCell")
        tableview.clipsToBounds = true
        
        return tableview
    }()
    
    fileprivate var tableViewSectionsTitle: [String] = []
    fileprivate var selectedIndex: Int!
    fileprivate var arrayDenuncias: [Denuncia] = []
    
    var tableConstraints: [NSLayoutConstraint]  {
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 1.0))
        return constraints
    }
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getReportsArray()
        let rightButtonItem = UIBarButtonItem.init(
            title: "+",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
        title = "Echo"
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate(tableConstraints)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toCatVC", sender: self)
    }
 
    
    //MARK: - Aux Methods
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
