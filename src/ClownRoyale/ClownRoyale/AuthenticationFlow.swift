import Foundation
import Promises

let defaults = UserDefaults.standard
let baseURL = "http://localhost:5000"

func sendRequestToServer(url: String, method: String, body: [String: Any]? = nil, login: Bool? = nil, isCallBack: [String: Any]? = nil) -> Promise<[String: Any]> {
    
    
    if isCallBack != nil {
        ajaxRequest(fullfill: isCallBack!["fullfill"] as! ([String : Any]) -> Void, reject: isCallBack!["reject"] as! ([String : Any]) -> Void, url: url, method: method, body: body, login: login)

    } else {
        
        
        print("NO CalLBACK!")
    }
    
    let res = Promise<[String: Any]>(on: .global(qos: .background)) {(ff, rj) in
        print("hallo")
        
        ajaxRequest(fullfill: ff as! ([String : Any]) -> Void, reject: rj as! ([String : Any]) -> Void, url: url, method: method, body: body, login: login)
        //ajaxRequest(fullfill: ff, reject: rj, url: url, method: method, body: body, login: login)

    }
    
    return res

 
}


func ajaxRequest(fullfill: ([String: Any]) -> Void, reject: ([String: Any]) -> Void, url: String, method: String, body: [String: Any]? = nil, login: Bool? = nil) {
    
    var request = URLRequest(url: URL(string: baseURL + url)!)
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    if login == nil {
        request.setValue( "Bearer \(getAToken())", forHTTPHeaderField: "Authorization")
    }
    
    request.httpMethod = method
    
    if body != nil {
        request.httpBody = body!.percentEncoded()
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data,
            let response = response as? HTTPURLResponse,
            error == nil else {                                              // check for fundamental networking error
            print("error", error ?? "Unknown error")
            return
        }

        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            
            if response.statusCode == 401 {
                silentLogin(r_token: getRToken(), url: url, method: method, data: body, login: login, fullfill: fullfill, reject: reject)
            }
            
            return
        }

        let responseString = String(data: data, encoding: .utf8)
        fullfill(parseJSON(jsonString: responseString!))
    }

    task.resume()
}

func silentLogin(r_token: String, url: String, method: String, data: [String: Any]? = nil, login: Bool? = nil, fullfill: ([String: Any]) -> Void, reject: ([String: Any]) -> Void) {
    sendRequestToServer(url: "/auth/refreshToken", method: "POST", body: ["refresh_token": getRToken()], isCallBack: ["fullfill": fullfill as! ([String: Any]) -> Void, "reject": reject as! ([String: Any]) -> Void]).then {token in
        setAToken(token: "\(token["access"]!)")

        sendRequestToServer(url: url, method: method, body: data, login: login).then {answer in
            print("ANSWER AFTER REFRESH: \(answer)")
        }
    }
}

func parseJSON(jsonString: String) -> [String: Any] {
    let data = Data(jsonString.utf8)

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            
            return json
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
    
    return ["nil": "nil"]
}

func setAToken(token: String) {
    defaults.set(token, forKey: "a_token")
}

func getAToken() -> String {
    return UserDefaults.standard.string(forKey: "a_token")!
}

func setRToken(token: String) {
    defaults.set(token, forKey: "r_token")
}

func getRToken() -> String {
    return UserDefaults.standard.string(forKey: "r_token")!
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
