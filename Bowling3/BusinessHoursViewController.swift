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
        
//        AF.request("https://www.round1.co.jp/shop/tenpo/shiga-hamaotsu.html").responseString{
//            response in
//
//            print("\(response)")
//        }
        //スクレイピング対象のサイトを指定
        AF.request("https://www.round1.co.jp/shop/tenpo/shiga-hamaotsu.html").responseString{
            response in
            if let html = response.value{
                if let doc = try? HTML(html: html, encoding: .utf8){
                    print("動いてる")

                    
                    let xxx = doc.xpath("//table[@class='table_inline']")
                    print("\(xxx)")
                    //営業時間のリストのタイトルを取得
                    var businessHourTitle = [String]()
                    for link in doc.xpath("//table[@class='table_inline']/tbody/tr/th"){
                        businessHourTitle.append(link.text ?? "")
                        print("タイトル取れてる")
                    }
                    //営業時間を取得
                    var businessHourRange = [String]()
//                    for link in doc.xpath("//table[@class='table_inline']/td[0]"){
                    for link in doc.xpath("//table[@class='table_inline']/tbody/tr/th"){
                        businessHourRange.append(link.text ?? "")
                        print("営業時間取れてる")
                    }

                    //配列に格納
                    for (index, value) in businessHourTitle.enumerated(){
                        let businessHour = BusinessHour()
                        businessHour.title = value
                        businessHour.range = businessHourRange[index]
                        self.businesshours.append(businessHour)
                        print("配列に格納してるよー")
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
