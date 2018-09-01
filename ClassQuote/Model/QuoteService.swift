//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Mickael on 01/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class QuoteService {
    static var shared = QuoteService()
    private init(){}
    private let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    private let pictureUrl = URL(string: "https://source.unsplash.com/random")!
    private var task: URLSessionDataTask?
    
    func getQuote(callback: @escaping (Bool, Quote?)->Void) {
        let request = createQuoteRequest()
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                            let text = responseJSON["quoteText"],
                            let author = responseJSON["quoteAuthor"] {
                            self.getImage { (data) in
                                if let data = data {
                                    let quote = Quote(text: text, author: author, imageData: data)
                                    callback(true, quote)
                                } else {
                                    callback(false, nil)
                                }
                            }
                        } else {
                            callback(false, nil)
                        }
                    } else {
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            }
        }
        task?.resume()
    }
    
    private func getImage(completionHandler: @escaping (Data?)->Void) {
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: pictureUrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        completionHandler(data)
                    } else {
                        completionHandler(nil)
                    }
                } else {
                    completionHandler(nil)
                }
            }
        }
        task?.resume()
    }
    
    private func createQuoteRequest() -> URLRequest {
        var request = URLRequest(url: quoteUrl)
        request.httpMethod = "POST"
        
        let body = "method=getQuote&lang=en&format=json"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}
