//
//  ViewController.swift
//  OnkyoSdk
//
//  Created by Savio Mendes de Figueiredo on 01/07/2017.
//  Copyright (c) 2017 Savio Mendes de Figueiredo. All rights reserved.
//

import UIKit
import Foundation
import OnkyoSdk

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView  =   UITableView()
    
    var items: [OnkyoDevice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addresses = Interface.getAllBroadcastAddresses()
        
        for broadcastAddress in addresses {
            let itemsTemp = OnkyoDeviceFactory().discoverDevices(broadcastAddress: broadcastAddress)
            items.append(contentsOf: itemsTemp)
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        tableView.frame         =   CGRect(x: 0, y: 50, width: screenWidth - 20, height: 200)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row].model!
        
        let switchView: UISwitch = UISwitch(frame: CGRect.zero)
        cell.accessoryView = switchView
        switchView.setOn(false, animated: true)
        switchView.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func switchChanged(sender: AnyObject) {
        
        let switchControl:UISwitch = sender as! UISwitch
        if switchControl.isOn {

            let onkyoClient = OnkyoClient(device: items[0])
            
            //var result = onkyoClient.sendCommand(to: items[0], commandName: .powerOn)
            //print ("\(result)")
            
            var result = onkyoClient.sendCommand(to: items[0], commandName: .powerQuery)
            print ("\(result)")
            
            //result = onkyoClient.sendCommand(to: items[0], commandName: .inputSelectorNetwork)
            //print ("\(result)")
            
            result = onkyoClient.sendCommand(to: items[0], commandName: .inputSelectorQuery)
            print ("\(result)")
        }
    }
}

