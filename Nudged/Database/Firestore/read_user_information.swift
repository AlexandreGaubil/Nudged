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
        db.collection("houses").document(identifier).getDocument(completion: {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let houseDetails = HouseDetails.init(querySnapshot.data()!, identifier: identifier)
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
