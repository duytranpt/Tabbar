//
//  ProflieModel.swift
//  gif
//
//  Created by Duy Tran on 21/12/2022.
//

import Foundation
import SwiftyJSON

struct ResponseFfp: Codable {

    var ffpClass: String?
    var airline: String?
    var ffpFullName: String?
    var ffpNumber: String?
    var ffpClassName: String?

    init(_ json: JSON) {
        ffpClass = json["ffpClass"].stringValue
        airline = json["airline"].stringValue
        ffpFullName = json["ffpFullName"].stringValue
        ffpNumber = json["ffpNumber"].stringValue
        ffpClassName = json["ffpClassName"].stringValue
    }

    init(ffpClass: String, airline: String, ffpFullName: String, ffpNumber: String, ffpClassName: String) {
        self.ffpClass = ffpClass
        self.airline = airline
        self.ffpFullName = ffpFullName
        self.ffpNumber = ffpNumber
        self.ffpClassName = ffpClassName
    }
    
}

struct ResponseListDocument: Codable {

    var documentType: String?
    var passportExpiryDate: String?
    var passportNation: String?
    var documentId: String?
    var passportIssueCountry: String?
    var passportNumber: String?

    init(_ json: JSON) {
        documentType = json["documentType"].stringValue
        passportExpiryDate = json["passportExpiryDate"].stringValue
        passportNation = json["passportNation"].stringValue
        documentId = json["documentId"].stringValue
        passportIssueCountry = json["passportIssueCountry"].stringValue
        passportNumber = json["passportNumber"].stringValue
    }
    
    init(documentId: String, documentType: String?, passportExpiryDate: String, passportIssueCountry: String, passportNation: String, passportNumber: String) {
        self.documentId = documentId
        self.documentType = documentType
        self.passportExpiryDate = passportExpiryDate
        self.passportIssueCountry = passportIssueCountry
        self.passportNation = passportNation
        self.passportNumber = passportNumber
    }
    
}

struct ResponseListPax: Codable {

    var lastNameFull: String?
    var lastName: String?
    var firstNameFull: String?
    var firstName: String?
    var title: String?
    var gender: Int?
    var email: String?
    var phone: String?
    var paxId: String?
    var dob: String?
    var listDocument: [ResponseListDocument]?

    init(_ json: JSON) {
        lastNameFull = json["lastNameFull"].stringValue
        lastName = json["lastName"].stringValue
        firstNameFull = json["firstNameFull"].stringValue
        title = json["title"].stringValue
        firstName = json["firstName"].stringValue
        gender = json["gender"].intValue
        email = json["email"].stringValue
        phone = json["phone"].stringValue
        paxId = json["paxId"].stringValue
        dob = json["dob"].stringValue
        listDocument = json["listDocument"].arrayValue.map { ResponseListDocument($0) }
    }
    
    init(firstName: String, firstNameFull: String, gender: Int, lastName: String, lastNameFull: String, phone: String, title: String, paxId: String, email: String, dob: String, listDocument: [ResponseListDocument]) {
        self.firstName = firstName
        self.firstNameFull = firstNameFull
        self.gender = gender
        self.lastName = lastName
        self.lastNameFull = lastNameFull
        self.phone = phone
        self.title = title
        self.paxId = paxId
        self.email = email
        self.dob = dob
        self.listDocument = listDocument
        
    }
    
    

}

struct ProfileModel: Codable {
    var b2cId: String?
    var ffp:            [ResponseFfp]?
    var listPax:        [ResponseListPax]?
    var dob:            String?
    var firstName:      String?
    var gender:         Int?
    var title:          String?
    var email:          String?
    var phone:          String?
    var lastNameFull:   String?
    var lastName:       String?
    var listDocument:   [ResponseListDocument]?
    var firstNameFull:  String?
    var registered:     Int?
    var profileId:      String?
    var verifyData: String?

    init(_ json: JSON) {
        b2cId = json["b2cId"].stringValue
        ffp = json["ffp"].arrayValue.map { ResponseFfp($0) }
        listPax = json["listPax"].arrayValue.map { ResponseListPax($0) }
        dob = json["dob"].stringValue
        firstName = json["firstName"].stringValue
        gender = json["gender"].intValue
        title = json["title"].stringValue
        email = json["email"].stringValue
        phone = json["phone"].stringValue
        lastNameFull = json["lastNameFull"].stringValue
        lastName = json["lastName"].stringValue
        listDocument = json["listDocument"].arrayValue.map { ResponseListDocument($0) }
        firstNameFull = json["firstNameFull"].stringValue
        registered = json["registered"].intValue
        profileId = json["profileId"].stringValue
        verifyData = json["verifyData"].stringValue
    }
    
    init(b2cId: String, ffp: [ResponseFfp], listPax: [ResponseListPax], dob: String, firstName: String, gender: Int, title: String, email: String, phone: String, lastNameFull: String, lastName: String, listDocument: [ResponseListDocument], firstNameFull: String, registered: Int, profileId: String, verifyData: String) {
        self.b2cId = b2cId
        self.ffp = ffp
        self.listPax = listPax
        self.dob = dob
        self.firstName = firstName
        self.gender = gender
        self.title = title
        self.email = email
        self.phone = phone
        self.lastNameFull = lastNameFull
        self.lastName = lastName
        self.listDocument = listDocument
        self.firstNameFull = firstNameFull
        self.registered = registered
        self.profileId = profileId
        self.verifyData = verifyData
    }
    
}

struct BSVInfor {
    
    var embossedName: String?
    var currentTierCode: String?
    var identifierNo: String?
    var currentTier: String?
    
    init(_ json: JSON) {
        embossedName = json["embossedName"].stringValue
        currentTierCode = json["currentTierCode"].stringValue
        identifierNo = json["identifierNo"].stringValue
        currentTier = json["currentTier"].stringValue
    }
    
    init(embossedName: String, currentTierCode: String, identifierNo: String, currentTier: String) {
        self.embossedName = embossedName
        self.currentTierCode = currentTierCode
        self.identifierNo = identifierNo
        self.currentTier = currentTier
    }
}

struct ProfileHomeModel {
    var displayName:  String
    var phoneNumber: String
    var profileID: String
    
    init(displayName: String, phoneNumber: String, profileID: String) {
        self.displayName = displayName
        self.phoneNumber = phoneNumber
        self.profileID = profileID
    }
    
    init(_ json: JSON) {
        self.displayName = json["displayName"].stringValue
        self.phoneNumber = json["phoneNumber"].stringValue
        self.profileID = json["profileID"].stringValue
    }
}
