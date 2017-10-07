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
    fileprivate var arrayAvisos: [Aviso] = []
    fileprivate var selectedIndex: Int!
    
    fileprivate let sharedDAO = DAO.sharedDAO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ola")
        
        getAvisosArray()
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
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetailsAnnoun", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsAnnoun" {
            let destVc = segue.destination as! DetailsAnnouncementsViewController
            destVc.aviso = arrayAvisos[selectedIndex]
        }
    }
}
