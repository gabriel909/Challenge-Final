//
//  ReportsViewController.swift
//  Challenge-Final
//
//  Created by Luisa Mello on 21/09/17.
//  Copyright © 2017 Gabriel Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ReportsViewController: UIViewController {
    var activityIndicator: NVActivityIndicatorView!
    var viewActivity: UIView!
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
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "+",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        self.setActivityIndicator()

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
        
        self.getReportsArray()
        self.toggleActivity(true)
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
    
    fileprivate func toggleActivity(_ bool: Bool) {
        let centerPoint = CGPoint(x: width / 2, y: height / 2 + tableView.contentOffset.y)
        
        self.viewActivity.center = centerPoint
//        self.activityIndicator.center = centerPoint
        self.viewActivity.isHidden = bool
        self.activityIndicator.isHidden = bool
        
        if !bool {
            self.activityIndicator.startAnimating()
            
        } else {
            self.activityIndicator.stopAnimating()
            
        }
    }
    
    private func setActivityIndicator() {
        let visibleRect = CGRect(x: tableView.contentOffset.x, y: tableView.contentOffset.y, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
        let centerPoint = CGPoint(x: visibleRect.size.width / 2, y: visibleRect.size.height / 2)
        let sizeView = width / 4
        let rect = CGRect(x: (width / 2) - (sizeView / 2) , y: height / 2 - 100, width: sizeView, height: sizeView)
        viewActivity = UIView(frame: rect)
        viewActivity.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        viewActivity.layer.cornerRadius = 10
        viewActivity.center = centerPoint
        
        let widthHeight = width / 5.3
        let midRect = (viewActivity.frame.width / 2) - (widthHeight / 2)
        let rectActivity = CGRect(x: midRect, y: midRect, width: widthHeight, height: widthHeight)
        self.activityIndicator = NVActivityIndicatorView(frame: rectActivity)
        self.activityIndicator.type = .ballScaleRipple
        
        self.viewActivity.addSubview(activityIndicator)
        self.tableView.addSubview(viewActivity)
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
        self.toggleActivity(false)
        
        DispatchQueue.global().async() {
            self.selectedIndex = indexPath.row
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toDetailsReport", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsReport" {
            let destVc = segue.destination as! DetailsReportsViewController
            destVc.report = arrayDenuncias[selectedIndex]
        }
    }
}
