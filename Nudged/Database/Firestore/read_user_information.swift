//
//  Read_history.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.


import Foundation
import FirebaseFirestore

func read_user_information(identifier: String, completion: @escaping (HouseDetails?, Error?) -> Void) {
    let db = Firestore.firestore()
    if identifier == "" {
        completion(nil, nil)
    } else {
        db.collection("houses/Singapore/01").document(identifier).getDocument(completion: {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let houseDetails = HouseDetails.init(querySnapshot.data() ?? [:], identifier: identifier)
                completion(houseDetails, error)
            } else {
                completion(nil, nil)
            }
        })
    }
}

func create_postal_codes() {
    let db = Firestore.firestore()
    for i in 0...200 {
        db.collection("houses").document("Singapore").collection("01").addDocument(data: [
            "p": "01" + String(describing: (i + 1000)),
            "h": String(describing: Int.random(in: 1...5)),
            "e": [
                "01_07_2019": Float.random(in: 12...18),
                "02_07_2019": Float.random(in: 12...18),
                "03_07_2019": Float.random(in: 12...18),
                "04_07_2019": Float.random(in: 12...18),
                "05_07_2019": Float.random(in: 12...18),
                "06_07_2019": Float.random(in: 12...18),
                "07_07_2019": Float.random(in: 12...18),
                "08_07_2019": Float.random(in: 12...18),
                "09_07_2019": Float.random(in: 12...18),
                "10_07_2019": Float.random(in: 12...18),
                "11_07_2019": Float.random(in: 12...18),
                "12_07_2019": Float.random(in: 12...18),
                "13_07_2019": Float.random(in: 12...18),
                "14_07_2019": Float.random(in: 12...18),
                "15_07_2019": Float.random(in: 12...18),
                "16_07_2019": Float.random(in: 12...18),
                "17_07_2019": Float.random(in: 12...18),
                "18_07_2019": Float.random(in: 12...18),
                "19_07_2019": Float.random(in: 12...18)
            ]
            ])
        
    }
}

func reset_usage_data() {
    var electricity_history: [String: Double] = [:]
    
    let date_formatter = DateFormatter()
    date_formatter.dateFormat = "yyyy_MM_dd HH:mm"
    
    let corrected_current_date_double_value: Double = Double(Date().timeIntervalSinceReferenceDate) - Double(Date().timeIntervalSinceReferenceDate).truncatingRemainder(dividingBy: 1800)
    
    for i in -400...400 {
    //for i in -2400...52560 {
        let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(exactly: corrected_current_date_double_value - Double(i * 1800) ) ?? 0)
        electricity_history[date_formatter.string(from: date)] = Double.random(in: 12...18)
    }
    
    Firestore.firestore().collection("houses/Singapore/01").document("0C97A1icrNmm5efNcPNT").setData([
        "h": 4,
        "k": "a",
        "p": "011024",
        "s": 151,
        "e": electricity_history
        ])
}

