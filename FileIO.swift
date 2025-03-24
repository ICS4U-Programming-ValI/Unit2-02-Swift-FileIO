import Foundation

//
//  FileIO.swift
//
//  Created by Val I on 2025-03-03.
//  Version 1.0
//  Copyright (c) 2025 Val I. All rights reserved.
//
//  The fileio program reads a sample input file with integers on each line
//  For each line of integers:
//  Convert them from string to int.
//  Calculate the sum of all the integers. 
//  Write the sum to the output file.
//  and displays the error message in “output.txt”
//

enum FileErrors: Error {
    case FileError
}

// Define the input and output file
let inputFile = "input.txt"
let outputFile = "output.txt"

// Read the input file
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: can't find input file")
    exit(1)
}

// Open the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: can't open output file")
    exit(1)
}

// Read the contents of the input file
let inputData = input.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: can't convert input data to string")
    exit(1)
}

// Split the string into lines
let inputLines = inputString.components(separatedBy: .newlines)

// Process each line
for line in inputLines {
    do {
        // Split the line into an array of strings
        let arrayOfStrings = line.split(separator: " ")
        
        // Check if the array is empty
        if arrayOfStrings.isEmpty {
            // Write "Nothing on this line" to the output file
            let message = "Nothing on this line\n"
            output.write(message.data(using: .utf8)!)
        } else {
            // Calculate the sum of the integers
            var sum = 0
            for numString in arrayOfStrings {
                // Convert the string to an integer
                if let numInt = Int(numString) {
                    sum += numInt
                } else {
                    throw FileErrors.FileError
                }
            }
            // Write the sum to the output file
            let message = "\(sum)\n"
            output.write(message.data(using: .utf8)!)
        }
    } catch {
        // Write the error message to the output file
        let errorMessage = "line is of strings not of integers.\n"
        output.write(errorMessage.data(using: .utf8)!)
    }
}

// Close the input and output files
input.closeFile()
output.closeFile()