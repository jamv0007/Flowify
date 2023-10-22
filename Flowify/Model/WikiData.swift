//
//  WikiData.swift
//  Flowify
//
//  Created by Jose Antonio on 22/10/23.
//

import Foundation
//Estructura para decodificar JSON
struct WikiData: Decodable {
    let query: Query
}

struct Query: Decodable {
    let pageids: [String]
    let pages: [String:Page]
}

struct Page: Decodable {
    let title: String
    let extract: String
    let thumbnail: ImageWikiData
}

struct ImageWikiData: Decodable {
    let source: String
}
