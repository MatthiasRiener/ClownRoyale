import Foundation

let defaults = UserDefaults.standard

func sendRequestToServer(url: String, method: String, data: [String: Any]? = nil, login: Bool? = nil) {
    print("Sending Request!")
    
    let baseURL = "http://localhost:5000"
    var request = URLRequest(url: URL(string: baseURL + url)!)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    print("LOGIN: \(login)")
    if login == nil {
        request.setValue( "Bearer \(getAToken())", forHTTPHeaderField: "Authorization")
    }
    request.httpMethod = method
    if data != nil {
        request.httpBody = data!.percentEncoded()
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
                silentLogin(r_token: getRToken())
            }
            
            return
        }

        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString!)")
        parseJSON(jsonString: responseString!)
    }

    task.resume()
}

func silentLogin(r_token: String) {
    print("SILENT LOGIN: \(r_token)")
}

func parseJSON(jsonString: String) {
    let data = Data(jsonString.utf8)

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if json["isLogin"] != nil {
                setAToken(token: "\(json["access"]!)")
                setRToken(token: "\(json["refresh"]!)")
            } else {
                print("JSON: \(json)")
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
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
