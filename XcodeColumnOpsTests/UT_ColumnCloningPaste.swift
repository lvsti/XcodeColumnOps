//
//  UT_ColumnCloningPaste.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Quick
import Nimble

struct Selection: TextRange {
    var start: TextPosition
    var end: TextPosition
}


class ColumnCloningPasteSpec: QuickSpec {
    
    override func spec() {
        
        var sut: ColumnCloningPaste!
        var result: ([String], [TextRange]) = ([], [])
        let lines = [
            "apple juice\n",
            "\n",
            "orange\n",
            "pear"
        ]
        let string = "FOOBAR"
        let multilineString = "FOOBAR\nQUUX\nBAZ"
        
        beforeEach {
            sut = ColumnCloningPaste()
        }
        
        describe("pasting to an empty selection (blinking cursor)") {
            
            let cursor = Cursor(line: 0, column: 5)
            let selections = [Selection(start: cursor, end: cursor)]

            context("the string has newlines") {

                it("inserts the first line of the string at the cursor") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                }
                
                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)

                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }
                
            }
            
            context("the string doesn't have newlines") {

                it("inserts the string at the cursor") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                    for i in 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }

                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }
                
            }
            
            it("keeps the cursor position") {
                // when
                result = sut.paste(string, into: lines, selectedRanges: selections)
                
                // then
                expect(result.1).to(haveCount(1))
                expect(result.1.first! == selections.first!).to(beTrue())
            }
            
        }
        
        describe("pasting to a single-line selection") {

            let start = Cursor(line: 0, column: 5)
            let end = Cursor(line: 0, column: lines.first!.characters.count)
            let selections = [Selection(start: start, end: end)]

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the selection") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                }

                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }

            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the start of the selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                }

                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }

            }
            
            it("sets the cursor position to the start of the selection and resets the selection") {
                // when
                result = sut.paste(string, into: lines, selectedRanges: selections)

                // then
                expect(result.1).to(haveCount(1))
                expect(result.1.first! == Selection(start: start, end: start)).to(beTrue())
            }
            
        }
        
        describe("pasting to a multiline selection") {

            let start = Cursor(line: 0, column: 5)
            let end = Cursor(line: 2, column: 2)
            let selections = [Selection(start: start, end: end)]

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the selection") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                }
                
                it("inserts the first line of the string in each subsequent line of the selection") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end.line - start.line + 1 {
                        expect(result.0[i].range(of: "FOOBAR")).toNot(beNil())
                    }
                }
             
                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in end.line + 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }

            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the cursor") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("appleFOOBAR juice\n"))
                }
                
                it("inserts the string in each subsequent line of the selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end.line - start.line + 1 {
                        expect(result.0[i].range(of: "FOOBAR")).toNot(beNil())
                    }
                }
                
                it("inserts the string at the column of the start of the selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end.line - start.line + 1 {
                        let resultLine = result.0[i]
                        let rangeStart = resultLine.range(of: "FOOBAR")?.lowerBound
                        if let rangeStart = rangeStart {
                            expect(resultLine.distance(from: resultLine.startIndex, to: rangeStart)).to(equal(start.column))
                        } else {
                            expect(rangeStart).toNot(beNil())
                        }
                    }
                }
                
                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in end.line + 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }

            }
            
            context("some lines of the selection are shorter than the column of the start of the selection") {
                
                it("pads short lines with spaces up to the column of the start of the selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)

                    // then
                    for i in start.line ... end.line {
                        let padCount = start.column - lines[i].characters.count
                        if padCount > 0 {
                            expect(result.0[i].hasPrefix(lines[i])).to(beTrue())
                            expect(result.0[i].hasSuffix(String(repeating: " ", count: padCount))).to(beTrue())
                        }
                    }
                }
                
            }
            
            it("sets the cursor position to the start of the selection and resets the selection") {
                // when
                result = sut.paste(string, into: lines, selectedRanges: selections)
                
                // then
                expect(result.1).to(haveCount(1))
                expect(result.1.first! == Selection(start: start, end: start)).to(beTrue())
            }

        }
        
        describe("pasting to a noncontinuous multiselection") {

            let start1 = Cursor(line: 0, column: 2)
            let end1 = Cursor(line: 0, column: 5)
            let start2 = Cursor(line: 2, column: 2)
            let end2 = Cursor(line: 2, column: 5)
            let selections = [Selection(start: start1, end: end1),
                              Selection(start: start2, end: end2)]

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the first selection") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("apFOOBARple juice\n"))
                }
                
                it("inserts the first line of the string in each line that the selections span") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end2.line - start1.line + 1 {
                        expect(result.0[i].range(of: "FOOBAR")).toNot(beNil())
                    }
                }
                
                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(multilineString, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in end2.line + 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }
                
            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the cursor") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0.first).to(equal("apFOOBARple juice\n"))
                }
                
                it("inserts the string in each subsequent line of the first selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end2.line - start1.line + 1 {
                        expect(result.0[i].range(of: "FOOBAR")).toNot(beNil())
                    }
                }
                
                it("inserts the string at the column of the start of the first selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in 1 ..< end2.line - start1.line + 1 {
                        let resultLine = result.0[i]
                        let rangeStart = resultLine.range(of: "FOOBAR")?.lowerBound
                        if let rangeStart = rangeStart {
                            expect(resultLine.distance(from: resultLine.startIndex, to: rangeStart)).to(equal(start1.column))
                        } else {
                            expect(rangeStart).toNot(beNil())
                        }
                    }
                }
                
                it("keeps the rest of the text intact") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    expect(result.0).to(haveCount(lines.count))
                    for i in end2.line + 1 ..< lines.count {
                        expect(result.0[i]).to(equal(lines[i]))
                    }
                }
                
            }
            
            context("some lines of the selection are shorter than the column of the start of the first selection") {
                
                it("pads short lines with spaces up to the column of the start of the first selection") {
                    // when
                    result = sut.paste(string, into: lines, selectedRanges: selections)
                    
                    // then
                    for i in start1.line ... end2.line {
                        let padCount = start1.column - lines[i].characters.count
                        if padCount > 0 {
                            expect(result.0[i].hasPrefix(lines[i])).to(beTrue())
                            expect(result.0[i].hasSuffix(String(repeating: " ", count: padCount))).to(beTrue())
                        }
                    }
                }
                
            }
            
            it("sets the cursor position to the start of the selection and resets the selection") {
                // when
                result = sut.paste(string, into: lines, selectedRanges: selections)
                
                // then
                expect(result.1).to(haveCount(1))
                expect(result.1.first! == Selection(start: start1, end: start1)).to(beTrue())
            }

        }
    }
    
}
