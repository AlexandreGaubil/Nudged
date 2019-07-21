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
