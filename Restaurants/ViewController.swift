//
//  ViewController.swift
//  Dash
//
//  Created by Ankit on 14/10/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var restaurantsTblVw: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    
    // MARK: Interface Builder Properties
    
    var restaurantsData: Resturant.RestaurantsInfo?
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = nil
        activityIndicator.hidesWhenStopped = true
        restaurantListApi()
    }
    
    
    // MARK: Interface Builder Action
    
    @IBAction func rightBarButtonAction(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        restaurantListApi()
    }
    
    
    // MARK: Hit Restaurants API
    
    func restaurantListApi() {
        activityIndicator.startAnimating()
        let url = URL(string: "https://appgrowthcompany.com:3000/v1/restaurant/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("SEC eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjYzMzA4MjZiMmFlMzU5NTA5ODQzMDYiLCJpYXQiOjE2MDAzMzYwMDN9.G6PF6sBbiSolYooa-uTOY86Z_0vFsDc8yDs9befV8RY", forHTTPHeaderField: "authorization")
        
        
        let param = ["latitude": 30.1236, "longitude": 76.4546] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                if error == nil {
                    if let data = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                                if let response = json["data"] as? [String: Any] {
                                    self.parseJSON(response: response)
                                }
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
            }.resume()
        } catch let error {
            print(error)
        }
    }
    
    // MARK: Convert JSON To Model
    
    private func convertJsonObjectToModel<T: Decodable>(_ object: [String: Any], modelType: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            do {
                let modelObj = try jsonDecoder.decode(modelType, from: data!)
                return modelObj
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
        return nil
    }
    
    
    // MARK: Parse Response
    
    func parseJSON(response: [String: Any]) {
        if let restaurantModel = convertJsonObjectToModel(response, modelType: Resturant.RestaurantsInfo.self) {
            restaurantsData = restaurantModel
            DispatchQueue.main.async {
                self.restaurantsTblVw.reloadData()
                self.navigationItem.rightBarButtonItem = self.rightBarButton
                self.rightBarButton.isEnabled = true
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        if indexPath.row == 0 {
            cell.restaurantsCollVwHeight.constant = 180
        } else {
            cell.restaurantsCollVwHeight.constant = 250
        }
        cell.restaurantsCollVw.tag = indexPath.row
        cell.setRestaurantData(restaurantsData: restaurantsData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return (restaurantsData?.categories?.count ?? 0) > 0 ? UITableView.automaticDimension : 0
        case 1:
            return (restaurantsData?.saved?.count ?? 0) > 0 ? UITableView.automaticDimension : 0
        case 2:
            return (restaurantsData?.bestOffers?.count ?? 0) > 0 ? UITableView.automaticDimension : 0
        default:
            return (restaurantsData?.recommended?.count ?? 0) > 0 ? UITableView.automaticDimension : 0
        }
    }
}

