//
//  OnlineAnswerService.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import Alamofire

/// Concrete provider that fetches answers online.

struct OnlineProvider: AnswerProviding {
    
    private let endpoint = "https://8ball.delegator.com/magic/JSON/whatislove?"
    
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void) {
       
        guard let url = URL(string: endpoint) else { return }
        let request = URLRequest(url: url, timeoutInterval: 2.5)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let data = data, error == nil,
                let answer = try? JSONDecoder().decode(Answer.self, from: data) {
                completionHandler(Result.success(answer))
            } else if let error = error {
                completionHandler(Result.failure(error))
            }
        }.resume()
    }
}
