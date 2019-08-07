//
//  ClimateOperation.swift
//  Weather
//
//  Created by Humaxvina on 8/9/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit


class ClimateProcess {
    var indexProcess: [Int: ClimateOperation] = [:]
    lazy var loadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    func addQueue(address: Address, at index: Int, completion: @escaping () -> ()) {
        let queue = ClimateOperation(address: address)
        self.indexProcess[index] = queue
        self.loadQueue.addOperation(queue)
        queue.completionBlock = {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

class ClimateOperation: Operation {
    
    var address: Address
    var semaphore: DispatchSemaphore!
    
    init(address: Address) {
        self.address = address
    }
    
    override func main() {
        self.semaphore = DispatchSemaphore(value: 0)
        if self.isCancelled {
            self.semaphore.signal()
            return
        }
        let params = NSMutableDictionary()
        params["q"] = self.address.name
        Networking.requestClimate(params: params) { (result) in
            if result.error != nil {
                self.semaphore.signal()
            } else {
                guard let data = result.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Climate.self, from: data)
                    self.address.climate = model
                    self.semaphore.signal()
                } catch {
                    print(error.localizedDescription)
                    print((try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)) ?? "nil")
                    self.semaphore.signal()
                }
            }
        }
        self.semaphore.wait()
    }
}
