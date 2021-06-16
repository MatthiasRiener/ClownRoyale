import Foundation

// Helper to determine if we're running on simulator or device
struct PlatformUtils {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

struct TokenUtils {
    
    /*
     Funktion holt Access Token für Videochat
     Token enthält berechtigten User + spezifischer Raum (User darf nur diesem einem Raum beitreten)
     */
    static func sendData(completionHandler: @escaping (_ token: String) -> Void) {
        var videoToken: String = ""
        
            var request = URLRequest(url: URL(string: baseURL + "/video/accessToken")!)
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            request.setValue( "Bearer \(getAToken())", forHTTPHeaderField: "Authorization")
            
            request.httpMethod = "GET"
                        
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
                    
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                let tokenResponse = parseJSON(jsonString: responseString!)
                
                videoToken = tokenResponse["tk"] as! String
                print("TokenResponse:")
                print(videoToken)
                completionHandler(videoToken)
            }

            task.resume()
    }
}


