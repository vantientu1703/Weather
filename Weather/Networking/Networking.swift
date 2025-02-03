import UIKit
// appid = da959f4dc38bf1543c1f799b98310560
let WEATHER_API = "https://api.openweathermap.org/data/2.5/weather?%@&appid=da959f4dc38bf1543c1f799b98310560"
typealias Result = (data: Data?, error: Error?)

class Networking {
    static func requestClimate(params: NSMutableDictionary, completion: @escaping (_ result: Result) -> ()) {
        guard let url = params.urlRequest() else {
            completion((nil, nil))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    let result: Result = (data, error)
                    completion(result)
                } else {
                    let result: Result = (nil, error)
                    completion(result)
                }
            }
        }
        task.resume()
    }
}

extension NSMutableDictionary {
    func toParameterString() -> String {
        let allKeys = self.allKeys
        if allKeys.count == 0 {
            return ""
        }
        var params: String = ""
        for key in allKeys {
            params.append("\(key)=\(self[key] ?? "")")
            if key as? String != allKeys.last as? String {
                params.append("&")
            }
        }
        return params
    }
    
    func urlRequest() -> URL? {
        guard let urlString = String(format: WEATHER_API, self.toParameterString()).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        let url = URL(string: urlString)
        return url
    }
}
