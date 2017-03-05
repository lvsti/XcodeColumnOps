//
//  UT_ColumnCloningPaste.swift
//  XcodeColumnOps
//
//  Created by Tamas Lustyik on 2017. 03. 05..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Quick
import Nimble

class ColumnCloningPasteSpec: QuickSpec {
    
    override func spec() {
        describe("pasting to an empty selection (blinking cursor)") {
            
            context("the string has newlines") {

                it("inserts the first line of the string at the cursor") {
                    
                }

            }
            
            context("the string doesn't have newlines") {

                it("inserts the string at the cursor") {
                    
                }

            }
            
            it("keeps the cursor position") {
                
            }
            
        }
        
        describe("pasting to a single-line selection") {

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the selection") {
                    
                }
                
            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the start of the selection") {
                    
                }
                
            }
            
            it("sets the cursor position to the start of the selection") {
                
            }
            
            it("resets the selection") {
                
            }
            
        }
        
        describe("pasting to a multiline selection") {

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the selection") {
                    
                }
                
                it("inserts the first line of the string in each subsequent line of the selection " +
                   "at the column of the start of the selection") {
                    
                }
                
            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the cursor") {
                    
                }
                
                it("inserts the string in each subsequent line of the selection " +
                   "at the column of the start of the selection") {
                    
                }
                
            }
            
            context("some lines of the selection are shorter than the column of the start of the selection") {
                
                it("pads short lines with spaces up to the column of the start of the selection") {
                    
                }
                
            }
            
            it("sets the cursor position to the start of the selection") {
                
            }
            
            it("resets the selection") {
                
            }

        }
        
        describe("pasting to a noncontinuous multiselection") {

            context("the string has newlines") {
                
                it("inserts the first line of the string at the start of the first selection") {
                    
                }
                
                it("inserts the first line of the string in each line of the selection " +
                   "at the column of the start of the first selection") {
                    
                }
                
            }
            
            context("the string doesn't have newlines") {
                
                it("inserts the string at the start of the first selection") {
                    
                }
                
                it("inserts the string in each line of the selection at the column of the start of the first selection") {
                    
                }
                
            }
            
            context("some lines of the selection are shorter than the column of the start of the first selection") {
                
                it("pads short lines with spaces up to the column of the start of the first selection") {
                    
                }
                
            }
            
            it("sets the cursor position to the start of the first selection") {
                
            }
            
            it("resets the selection") {
                
            }

        }
    }
    
}
