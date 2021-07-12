//
//  ParseDataOperation.swift
//  VKClient
//
//  Created by Lev on 6/20/21.
//

import Foundation

class ParseDataOperation<T: Codable>: Operation {
    
    var outputData: Any?
    
    var tempData: T?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data
        else { return }
        
        do {
            self.tempData = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            do {
                print(try JSONDecoder().decode(ErrorModel.self, from: data))
            } catch {
                print(error)
            }
        }
        
        converToReadableFormat()
    }
    
    func converToReadableFormat() {
        switch T.self {
        case is UserModel.Type:
            outputData = (tempData as? UserModel)?.response.items
        case is GroupModel.Type:
            outputData = (tempData as? GroupModel)?.response.items
        case is PhotoModel.Type:
            outputData = (tempData as? PhotoModel)?.response.items
        case is NewsModel.Type:
            guard var preParsedData = (tempData as? NewsModel)?.response else { return }
            
            var sources = [NewsModelItem]()
            
            for i in 0..<preParsedData.items.count {
                if preParsedData.items[i].sourceId < 0 {
                    let group = preParsedData.groups.first { $0.id == -preParsedData.items[i].sourceId }
                    var news = preParsedData.items[i]
                    news.authorName = group?.name
                    news.authorImageUrl = group?.imageUrl
                    sources.append(news)
                } else {
                    var profile = preParsedData.profiles.first { $0.id == preParsedData.items[i].sourceId }
                    var news = preParsedData.items[i]
                    news.authorName = profile?.fullname
                    news.authorImageUrl = profile?.imageUrl
                    sources.append(news)
                }
            }
            
            preParsedData.sources = sources
            outputData = preParsedData
        default:
            break
        }
    }
    
}
