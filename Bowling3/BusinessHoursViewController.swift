//
//  BusinessHoursViewController.swift
//  Bowling3
//
//  Created by Daichi Yoshikawa on 2020/09/17.
//  Copyright © 2020 Daichi Yoshikawa. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class BusinessHoursViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesshours = [BusinessHour]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getBusinessHours()
        // Do any additional setup after loading the view.
    }
    
    func getBusinessHours(){
        
        AF.request("https://www.round1.co.jp/shop/tenpo/shiga-hamaotsu.html").response{
            response in
            if let html = response.value{
                if let doc = try? HTML(html: html!, encoding: .utf8){
                    var businessHourTitle: [String] = []
                    var businessHourRange = [String]()
                    for i in (1...3){
                        for link in doc.xpath("//*[@id='m_contents']/div[2]/div/table/tr[\(i)]/th"){
                            print(link.text ?? "")
                            businessHourTitle.append(link.text ?? "")
                            
                        }
                    }
                    
                    for i in (1...3){
                        for link in doc.xpath("//*[@id='m_contents']/div[2]/div/table/tr[\(i)]/td"){
                            print(link.text ?? "")
                            businessHourRange.append(link.text ?? "")
                        }
                        
                    }
                    
                    
                    for i in (0...2){
                        let hours = BusinessHour()
                        hours.title = businessHourTitle[i]
                        hours.range = businessHourRange[i]
                        self.businesshours.append(hours)
                    }
                    self.tableView.reloadData()

                }

            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesshours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessHoursCell", for: indexPath)

        let business = self.businesshours[indexPath.row]
        print("business\(business.title)")
        
        //sizeを表示
        let labelTitle = cell.viewWithTag(1) as! UILabel
        labelTitle.text = business.title
        
        
        //priceを表示
        let labelRange = cell.viewWithTag(2) as! UILabel
        labelRange.text = business.range
        
        print("表にしてるよー")
        
        return cell
    }
    
    class BusinessHour: NSObject{
        var title: String = ""
        var range: String = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
