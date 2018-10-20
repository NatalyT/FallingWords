//
//  Words.swift
//  FallingWords
//
//  Created by Nataly Tatarintseva on 10/20/18.
//  Copyright © 2018 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit

private let vocabularyURL = "https://gist.githubusercontent.com/DroidCoder/7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"

struct Word: Codable {
    var text_eng: String?
    var text_spa: String?
    
    static func fetchJson() -> [Word]? {
        if let url = URL(string: vocabularyURL) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Word].self, from: data)
                return jsonData
            } catch DecodingError.dataCorrupted {
                print("Data corrupted")
            } catch {
                print("Fetching JSON Error")
            }
        }
        return nil
    }
}

