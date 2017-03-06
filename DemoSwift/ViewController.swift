//
//  ViewController.swift
//  DemoSwift
//
//  Created by Chandan Singh on 26/02/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    var categorieArrays = ["Trading Songs", "Top Chard", "New Releases", "Recently Played"]
    var totalArrays = [Array<String>]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do Default Setup
        self.setDefaultData()
        
        self.registerNibforHeaderFooterView()
        
        // Do NavigationBar setup YES/NO
        self.showNavigationBar(check: true)
        
    }

    func registerNibforHeaderFooterView() {
        let nib = UINib(nibName: "CustomHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier:"CustomHeader")
    }
    
    func setDefaultData(){
        let tradingSongs = ["Aaron","Abdul","Abdullah","Abe","Abraham"]
        let newReleases = ["Aaron","Abdul","Abdullah","Abe","Abraham"]
        let topChard  = ["Aaron","Abdul","Abdullah","Abe","Abraham"]
        let recentlyPlayed  = ["Aaron","Abdul","Abdullah","Abe","Abraham"]
        self.totalArrays = [tradingSongs, newReleases, topChard, recentlyPlayed]
    }
    
    func showNavigationBar(check:Bool){
        if check {
            self.tableView.allowsMultipleSelection = true
            self.navigationItem.rightBarButtonItem = self.editButton
            self.navigationItem.leftBarButtonItem = self.addButton
        }
    }
    
    
    @IBAction func addbtnAction(_ sender: Any) {
        self.tableView.beginUpdates()
        self.tableView.insertSections(IndexSet(integer:self.categorieArrays.count), with:.bottom)
        let indextPath = IndexPath(row:0, section:(self.categorieArrays.count))
        self.categorieArrays.append("New Itme")
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at:indextPath, at:.bottom , animated:true )
    }
    
    @IBAction func editbtnAction(_ sender: Any) {
        self.tableView.setEditing(true, animated: true)
        self.updateNavigationBarButton()
    }
    
    
    @IBAction func canclebtnAction(_ sender: Any) {
        self.tableView.setEditing(false, animated: true)
        self.updateNavigationBarButton()
    }
   
    func updateNavigationBarButton() {
        if self.tableView.isEditing {
            self.navigationItem.rightBarButtonItem = self.cancelButton
            self.addButton.hidden = true
        }else{
            self.addButton.hidden = false
            if (self.categorieArrays.count == 0 ){
                self.editButton.hidden =  true
            }else{
                self.editButton.hidden =  false
            }
            self.navigationItem.rightBarButtonItem = self.editButton
        }
    }
    
    func showAlartView(tag:Int){
        let alertController = UIAlertController(title: "Alert!",  message: "You want to delete this section",preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Ok", style: .destructive, handler: { (action:UIAlertAction!) in
            self.categorieArrays.remove(at:tag)
            self.tableView.reloadData()
        })
        alertController.addAction(clearAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController,    animated: true, completion:nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - HeaderSeeAllDelegate

extension ViewController : HeaderSeeAllDelegate {
    
    func buttonseeAllTapped(headerTag:Int){
        print(headerTag)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 34;
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerFooterView :CustomHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier:"CustomHeader") as! CustomHeader
        headerFooterView.lblHeader.text = categorieArrays[section]
        headerFooterView.btnSeeAll.tag = section
        headerFooterView.buttonseeAllDelegate = self
        return headerFooterView;
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorieArrays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TableViewCell", for: indexPath) as!TableViewCell
        cell.listSongs = self.totalArrays[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateNavigationBarButton()
    }
    
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.showAlartView(tag: indexPath.section)
        }
    }
}

extension UIBarButtonItem {
    var hidden: Bool {
        get {
            return !self.isEnabled && self.tintColor == UIColor.clear
        }
        set {
            self.tintColor = newValue ? UIColor.clear : nil
            self.isEnabled = !newValue
        }
    }
}
