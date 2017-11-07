//
//  AnnouncementsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AnnouncementsViewController: UIViewController {
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    lazy var tableView: UITableView! = {
        let tableViewCellNib = UINib(nibName: "AnnouncementsTableViewCell", bundle: nil)
        
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.rowHeight = height / 5
        tableview.register(tableViewCellNib, forCellReuseIdentifier: "idAnnouncCell")
        tableview.clipsToBounds = true
        
        return tableview
    }()
    
    fileprivate var arrayAvisos: [Aviso] = []
    fileprivate var selectedIndex: Int!
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    var tableConstraints: [NSLayoutConstraint]  {
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 1.0))
        constraints.append(NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 1.0))
        return constraints
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
        title = "Avisos"
        
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
        self.getAvisosArray()
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    //MARK: - Aux Methods
    private func tableViewSetup() {
        let tableViewRect = CGRect(x: 0, y: height / 4.73, width: width, height: height)
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
    
    private func getAvisosArray() {
        var aluno = Aluno()
        
        if sharedDAO.aluno != nil {
            aluno = sharedDAO.aluno!
        }
        
        sharedDAO.getAvisos(forAluno: aluno, completion: { arrayAvisos in
            self.arrayAvisos = arrayAvisos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

//MARK: - Extensions
//MARK: Table View Data Source
extension AnnouncementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAvisos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AnnouncementsTableViewCell
        let aviso = arrayAvisos[indexPath.row]
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idAnnouncCell", for: indexPath as IndexPath) as! AnnouncementsTableViewCell
        cell.backgroundColor = .clear
        
        cell.titleLabel.text = aviso.titulo
        cell.descriptionLabel.text = aviso.descricao
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - Table View Delegate
extension AnnouncementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global().async() {
            self.selectedIndex = indexPath.row
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toDetailsAnnoun", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsAnnoun" {
            let destVc = segue.destination as! DetailsAnnouncementsViewController
            destVc.aviso = arrayAvisos[selectedIndex]
        }
    }
}
