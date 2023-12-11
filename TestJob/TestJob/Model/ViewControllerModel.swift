//
//  ViewControllerModel.swift
//  TestJob
//
//  Created by Priyanka Sinha on 09/12/23.
//

import Foundation

struct Item:Codable{
    let id : String
    let url:String
    let height : Int
    let width: Int
    
}

protocol ViewControllerModelDelegate: AnyObject {
    func getData(items:[Item])
}

class ViewControllerModel{
    
    weak var delegate: ViewControllerModelDelegate?
    
    
    func fetchDataFromServer() {
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else { return}
        URLSession.shared.dataTask(with: url) { response, _, error in
            guard let data = response else {
              return
            }
            do {
                print(data)
                let responseData = try JSONDecoder().decode([Item].self , from:data)
                print(responseData)
                self.delegate?.getData(items: responseData)
                
            } catch {
                
               print("")
            }
       
        }.resume()
    }
}
