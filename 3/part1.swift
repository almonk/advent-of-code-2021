#!/usr/bin/swift

import Foundation

// Start our program
main()

var data : [[Int]] = [[]]

func main() {
    readFileToData()
    
    let columnCount = data[0].count - 1 // Minus one because our array is zero based
    
    // For each column...
    var gammaRateBinary = ""
    var epsilonRateBinary = ""
    
    for i in 0...columnCount {
        gammaRateBinary = gammaRateBinary + returnMostCommonNumber(
            histogram: returnColumn(
                column: i
            ).histogram)!
        
        epsilonRateBinary = epsilonRateBinary +
            returnLeastCommonNumber(
                histogram: returnColumn(
                    column: i
                ).histogram)!
    }
    

    let solution = Int(gammaRateBinary.asBinary()!) * Int(epsilonRateBinary.asBinary()!)
    print(solution)

}

// Returns all the numbers from a certain column of our data
func returnColumn(column: Int) -> [Int] {
    var columnData : [Int] = []
    
    for item in data {
        guard column < item.count else { break }
        columnData.append(item[column])
    }
    
    return columnData
}

// Returns the mode value from a histogram
func returnMostCommonNumber(histogram: [Int: Int]) -> String? {
    guard histogram[0] != nil && histogram[1] != nil else { return nil }
    if histogram[0]! > histogram[1]! {
        return "0"
    } else {
        return "1"
    }
}

// Returns the least common value from a histogram
func returnLeastCommonNumber(histogram: [Int: Int]) -> String? {
    guard histogram[0] != nil && histogram[1] != nil else { return nil }
    if histogram[0]! < histogram[1]! {
        return "0"
    } else {
        return "1"
    }
}

// Reads a file line by line
func readFileToData() {
    // Clear the data object
    data = []
    
    let input = FileHandle.standardInput

    let text = String(bytes: input.availableData, encoding: .utf8)!
    
    let lines = text.split(separator:"\n")

    // Iterate over each line and print the line
    for line in lines {
        // Split the line into an array
        let lineAsArray = Array(line)
        var intLineAsArray: [Int] = []
        
        // Convert each character to an integer and add to another array
        for character in lineAsArray {
            intLineAsArray.append(Int(String(character))!)
        }
    
        // Append the new integer array to our data object
        data.append(intLineAsArray)
    }
}

// Extension to create histograms from a sequence
extension Sequence where Element: Hashable {
    var histogram: [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}

extension String {
    func asBinary() -> Int? {
        var result: Int = 0

        for digit in self {
            switch(digit) {
                case "0": result = result * 2
                case "1": result = result * 2 + 1
                default: return nil
            }
        }
        return result
    }
}
