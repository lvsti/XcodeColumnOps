//
//  UT_ColumnPaste.swift
//  XcodeColumnOpsTests
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Quick
import Nimble

class ColumnPasteSpec: QuickSpec {

    override func spec() {
        
        var sut: ColumnPaste!
        var result: [String] = []
        let lines = [
            "apple juice\n",
            "\n",
            "orange\n",
            "pear"
        ]
        
        beforeEach {
            sut = ColumnPaste()
            result = []
        }
        
        describe("pasting a single string") {
            
            let strings = ["FOOBAR"]
            
            context("at the end of file") {
                
                it("appends the string to the end") {
                    // when
                    result = sut.paste(strings, into: lines, at: (lines.count - 1, lines.last!.characters.count))
                    
                    // then
                    expect(result).to(equal([
                        "apple juice\n",
                        "\n",
                        "orange\n",
                        "pearFOOBAR"
                    ]))
                }
                
            }
            
            context("at an inner location") {
                
                it("inserts the string at the cursor") {
                    // when
                    result = sut.paste(strings, into: lines, at: (0, 2))
                    
                    // then
                    expect(result).to(equal([
                        "apFOOBARple juice\n",
                        "\n",
                        "orange\n",
                        "pear"
                    ]))
                }
                
            }
            
        }
        
        describe("pasting strings from multiselection") {
            
            let strings = ["FOOBAR", "QUUX", "STUFF"]

            context("at the end of file") {
                
                let location: PasteLocation = (lines.count - 1, lines.last!.characters.count)
                
                it("appends the first string to the last line with a terminating newline") {
                    // when
                    result = sut.paste(strings, into: lines, at: location)
                    
                    // then
                    expect(result[lines.count - 1]).to(equal(lines.last! + strings.first! + "\n"))
                }
                
                it("adds (<string count> - 1) new lines") {
                    // when
                    result = sut.paste(strings, into: lines, at: location)
                    
                    // then
                    expect(result.count).to(equal(lines.count + strings.count - 1))
                }
                
                it("fills inserted lines with spaces up to the cursor's column") {
                    // given
                    let padding = String(repeating: " ", count: location.column)

                    // when
                    result = sut.paste(strings, into: lines, at: location)
                    
                    // then
                    expect(result[result.count - 2].hasPrefix(padding)).to(beTrue())
                    expect(result[result.count - 1].hasPrefix(padding)).to(beTrue())
                }
                
                it("appends each subsequent string at the end of the inserted padded lines") {
                    // when
                    result = sut.paste(strings, into: lines, at: location)
                    
                    // then
                    expect(result).to(equal([
                        "apple juice\n",
                        "\n",
                        "orange\n",
                        "pearFOOBAR\n",
                        "    QUUX\n",
                        "    STUFF"
                    ]))
                }
                
            }
            
            context("at an inner location") {
                
                let location: PasteLocation = (0, 2)
                let overflowingStrings = ["RED", "GREEN", "BLUE", "YELLOW", "BROWN"]
                
                it("inserts the first string at the cursor") {
                    // when
                    result = sut.paste(strings, into: lines, at: location)
                    
                    // then
                    expect(result[location.line]).to(equal("apFOOBARple juice\n"))
                }
                
                context("there are more than (<EOF's line#> - <cursor's line#> + 1) strings") {
                    
                    it("adds (<string count> - (<EOF's line#> - <cursor's line#> + 1)) new lines") {
                        // when
                        result = sut.paste(overflowingStrings, into: lines, at: location)

                        // then
                        expect(result.count).to(equal(lines.count + overflowingStrings.count - (lines.count - 1 - location.line + 1)))
                    }
                    
                }
                
                it("pads the (<string count> - 1) consecutive lines starting from (<cursor's line#> + 1) " +
                   "with spaces up to the cursor's column if necessary") {
                    // given
                    let padding = String(repeating: " ", count: location.column)
                    
                    // when
                    result = sut.paste(overflowingStrings, into: lines, at: location)
                    
                    // then
                    for i in location.line..<location.line + overflowingStrings.count {
                        if i >= result.count {
                            expect(true).to(beFalse())
                            break
                        }
                        expect(result[i].hasPrefix(padding) || (i < lines.count && lines[i].characters.count >= location.column)).to(beTrue())
                    }
                }
                
                it("inserts the Nth string (N in 0..<string count>-1) at the cursor's column" +
                   "in the (<cursor's line#> + N)th line") {
                    // when
                    result = sut.paste(overflowingStrings, into: lines, at: location)

                    // then
                    expect(result).to(equal([
                        "apREDple juice\n",
                        "  GREEN\n",
                        "orBLUEange\n",
                        "peYELLOWar\n",
                        "  BROWN"
                    ]))
                }
                
            }

        }
        
    }
    
}
