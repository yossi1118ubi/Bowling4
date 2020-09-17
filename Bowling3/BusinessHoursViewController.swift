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
        getBusinessHours()
        // Do any additional setup after loading the view.
    }
    
    func getBusinessHours(){
        //スクレイピング対象のサイトを指定
        Alamofire.request("https://www.round1.co.jp/shop/tenpo/shiga-hamaotsu.html").responseString{
        response in
            if let html = response.result.value{
                if let html = doc = try? HTML(html, encoding: .utf8){
                    
                    //営業時間のリストのタイトルを取得
                    var businessHourTitle = [String]()
                    for link in doc.xpath("//th[@class='table_inline']"){
                        lists.append(link.text ?? "")
                    }
                    //営業時間を取得
                    var businessHourRange = [String]()
                    for link in doc.dpath("//td[@class='table_inline']"){
                        businessHourRange.append(link.text ?? "")
                    }
                    
                    //配列に格納
                    for (index, value) in sizes.enumerated(){
                        let businessHour = BusinessHour()
                        businessHour.title = value
                        businessHour.range = businessHourRange[index]
                        self.businesshours.append(businessHour)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessHours", for: indexPath)

        let business = self.businesshours[indexPath.row]
        
        //sizeを表示
        let labelTitle = cell.viewWithTag(1) as! UILabel
        labelTitle.text = business.title
        
        //priceを表示
        let labelRange = cell.viewWithTag(2) as! UILabel
        labelRange.text = business.range
        
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
