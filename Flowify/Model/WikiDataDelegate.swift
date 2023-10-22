//
//  WikiDataDelegate.swift
//  Flowify
//
//  Created by Jose Antonio on 22/10/23.
//

import Foundation

//Protocolo para enviar los datos y error a la UI
protocol WikiDataDelegate {
    func getDataWiki(_ data: WikiDataAccess)
    func getErrorWiki(_ error: Error)
}
