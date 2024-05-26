//
//  NetworService.swift
//  VIPER + DI
//
//  Created by Георгий Евсеев on 5.05.24.
//

import UIKit

enum UrlStrings: String {
    case adress = "https://jsonplaceholder.typicode.com/users"
}

protocol INetworkManager: AnyObject {
    func sendRequest(adress: String, completion: @escaping(Data?, Error?) -> Void)
}

class NetworkManager: INetworkManager {
    
    var presenter: IMainViewModel?

    func sendRequest(adress: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: adress) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            completion(data, error)
        }
        task.resume()
    }
}
