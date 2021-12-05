#!/usr/bin/swift

import Foundation

// Struct representing our submarine
struct Submarine {
    var x: Int
    var aim: Int
    var depth: Int
}

// All possible submarine commands
enum SubmarineCommand {
  case forward // Increases X position
  case down // Increases depth positively
  case up // Decreases depth positively
}

// Start our program
main()


// Instantiate a new submarine, this is the
// object we'll manipulate to solve the puzzle.
// It starts at the zero position.
var s = Submarine(x: 0, aim: 0, depth: 0)

func main() {
    // Parse and send all the commands
    readFile()
    
    // Do the final calculation
    let solution = s.x * s.depth
    print(solution)
}

func readFile() {
    let input = FileHandle.standardInput

    let text = String(bytes: input.availableData, encoding: .utf8)!
    
    let lines = text.split(separator:"\n")

    // Iterate over each line and print the line
    for line in lines {
        let c = parseStringToCommand(input: String(line))
        if c.0 != nil && c.1 != nil {
            sendCommand(command: c.0!, value: c.1!)
        }
    }
}

// Send the submarine a command
func sendCommand(command: SubmarineCommand, value: Int) {
    switch command {
    case .forward:
        s.x += value
        s.depth += s.aim * value
    case .down:
        s.aim += value
    case .up:
        s.aim -= value
    }
}

private func parseStringToCommand(input: String) -> (SubmarineCommand?, Int?) {
    let array = input.components(separatedBy: " ")
    guard !array.isEmpty else { return (nil, nil) }
    guard let value = Int(array[1]) else { return (nil, nil) }

    switch array[0] {
    case "forward":
        return (SubmarineCommand.forward, value)
    case "down":
        return (SubmarineCommand.down, value)
    case "up":
        return (SubmarineCommand.up, value)
    default:
        return (nil, nil)
    }
}
