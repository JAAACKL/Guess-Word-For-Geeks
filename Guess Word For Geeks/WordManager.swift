//
//  WordManager.swift
//  Guess Word For Geeks
//
//  Created by 林子轩 on 2022/5/3.
//

import Foundation

class WordManager {
    
    private var nextIndex = 0
    private var words : [[String]] = []
    private var summary : [Bool] = []
    
    init() {
        let libs = UserDefaults.array(forKey: .selectedLibraries)!
        for l in libs {
            do {
                let path = Bundle.main.path(forResource: "\(l)", ofType: "txt")!
                let content = try String(contentsOfFile: path)
                let lines = content.split(separator: "\n")
                for line in lines {
                    let values = line.split(separator: ",", omittingEmptySubsequences: false)
                    var entry : [String] = []
                    for v in values {
                        entry.append(String(v))
                    }
                    words.append(entry)
                }
            } catch {
                print("error")
            }
        }
        
        words.shuffle()
    }
    
    func next() -> [String] {
        let temp = words[nextIndex % words.count]
        nextIndex += 1
        return temp
    }
    
    func record(_ correct: Bool) {
        summary.append(correct)
    }
    
    func getSummary() -> [(String, Bool)] {
        var result : [(String, Bool)] = []
        for i in 0..<summary.count {
            result.append((words[i % words.count][0], summary[i]))
        }
        return result
    }
}
