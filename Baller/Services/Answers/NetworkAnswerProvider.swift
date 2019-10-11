//
//  OnlineAnswerService.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import Alamofire

/// A concrete provider that fetches answers online.

class NetworkAnswerProvider: AnswerProviding {

    private let endpoint = "https://8ball.delegator.com/magic/JSON/whatislove?"

    private lazy var reachability = NetworkReachabilityManager(host: endpoint)

    enum NetworkProviderError: Error { case failedToRetrieveAnswer }

    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void) {

        guard let reachability = reachability, reachability.isReachable,
            let url = URL(string: endpoint) else {
                completionHandler(Result.failure(NetworkProviderError.failedToRetrieveAnswer))
                return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data, error == nil,
                let answer = try? JSONDecoder().decode(SerializableAnswer.self, from: data) {
                completionHandler(Result.success(answer.toAnswer()))
            } else if let error = error {
                completionHandler(Result.failure(error))
            }
        }.resume()
    }

}
