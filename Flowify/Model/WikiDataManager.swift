//
//  WikiDataManager.swift
//  Flowify
//
//  Created by Jose Antonio on 21/10/23.
//

import Foundation
import Alamofire
import SDWebImage

//Manager de los datos de la wiki
struct WikiDataManager{
    
    //URL
    let url = "https://en.wikipedia.org/w/api.php"
    //let urlComplete = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts|pageimages&exintro=&explaintext=&titles=stemless%20gentian&indexpageids&redirects=1&pithumbsize=500"
    
    var delegate: WikiDataDelegate?
    
    //MARK: - Request de la informacion
    func requestInfo(flowerName: String){
        //Parametros del método GET
        let parameters: [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
        ]
        
        //Request
        AF.request(url, method: .get ,parameters: parameters).validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    //Si es afirmativo se parsea del JSON
                    let access: WikiDataAccess? = parseJSON(response.data!)
                    if let a = access{
                        delegate?.getDataWiki(a)
                    }
                case let .failure(error):
                    delegate?.getErrorWiki(error)
                }
            }
    }
    
    //MARK: - Parsea de JSON
    func parseJSON(_ data: Data) -> WikiDataAccess? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(WikiData.self, from: data)
            let id = decodeData.query.pageids[0]
            let page = decodeData.query.pages[id]
    
            return WikiDataAccess(title: page?.title ?? "",text: page?.extract ?? "",image: page?.thumbnail.source ?? "")
        }catch{
            delegate?.getErrorWiki(error)
            return nil
        }
    }
    
    
}
