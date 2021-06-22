//
//  GetDataOperation.swift
//  VKClient
//
//  Created by Lev on 6/20/21.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    
    private var request: DataRequest
    
    init(request: DataRequest) {
        self.request = request
    }
    
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [self] response in
            data = response.value
            state = .finished
        }
    }
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
