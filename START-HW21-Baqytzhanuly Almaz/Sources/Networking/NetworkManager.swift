//
//  NetworkManager.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/11/23.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
    func getCards(from url: String, with completion: @escaping ([Card]) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Cards.self) { (data) in
            if data.response?.statusCode == 200, let result = data.value {
                let cards = result.cards
                completion(cards)
            } else {
                print("error in request")
            }
        }
    }
    
    func getImage(from url: String, with completion: @escaping ((UIImage) -> Void)) {
        let request = AF.request(url)
        request.responseData { (data) in
            if data.response?.statusCode == 200, let result = data.value {
                guard let image = UIImage(data: result) else { return }
                completion(image)
                return
            } 
        }
    }
}
