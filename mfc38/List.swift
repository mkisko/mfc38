//
//  List.swift
//  mfc38
//
//  Created by Алексей Усанов on 21.12.16.
//  Copyright © 2016 Алексей Усанов. All rights reserved.
//

import Foundation
import ObjectMapper

class Lists: Mappable {
    var id: String?
    var name: String?
    var key: String?
    var active: String?
    var order_: String?
    var types: [Types]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        active      <- map["active"]
        id          <- map["id"]
        key         <- map["key"]
        name        <- map["name"]
        order_      <- map["order_"]
        types       <- map["types"]
    }
}

class Types:Mappable {
    var id: String?
    var key: String?
    var name: String?
    var check: Bool?
    var services: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        key         <- map["key"]
        name        <- map["name"]
        check       <- map["check"]
        services     <- map["services"]
    }
}

class NewList:Mappable {
    var aService: [attrService]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        aService      <- map["aService"]
    }
}

class attrService {
    var serId: String
    var types: Attr
    
    init(serId: String, types: Attr) {
        self.serId = serId
        self.types = types
    }
}

class Status:Mappable {
    var id: String?
    var id_status: String?
    var code_ais: String?
    var date_: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        id_status       <- map["id_status"]
        code_ais        <- map["code_ais"]
        date_           <- map["date_"]
        name            <- map["name"]
    }
}

class Tree:Mappable {
    var tree: Dictionary<String, String>?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        tree <- map["1"]
    }
}

class ServiceTree:Mappable {
    var id: String?
    var name: String?
    var ticketText: String?
    var serviceList: [Tree]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        ticketText  <- map["ticketText"]
        serviceList <- map["serviceList"]
    }
}


//список услуг
class ListService:Mappable {
    var ser_id: String?
    var name: String?
    var service_key: String?
    var attr: Attr?
    var part: Bool?
    var items: [ListService]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ser_id      <- map["ser_id"]
        name        <- map["name"]
        service_key <- map["service_key"]
        attr        <- map["attr"]
        part        <- map["part"]
        items       <- map["items"]
    }
}

class Attr:Mappable {
    var lifeSituationText: String? = nil
    var organizationText: String? = nil
    var recipientsText: String? = nil
    var documentsText: String? = nil
    var documentsFiles: [String]? = nil
    var paymentInfoText: String? = nil
    var timeTermText: String? = nil
    var serviceResultText: String? = nil
    var mfcsText: String? = nil
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lifeSituationText       <- map["lifeSituationText"]
        organizationText        <- map["organizationText"]
        recipientsText          <- map["recipientsText"]
        documentsText           <- map["documentsText"]
        documentsFiles          <- map["documentsFiles"]
        paymentInfoText       <- map["paymentInfoText"]
        timeTermText        <- map["timeTermText"]
        serviceResultText          <- map["serviceResultText"]
        mfcsText           <- map["mfcsText"]
        
    }
}

