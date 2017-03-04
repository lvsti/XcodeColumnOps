//
//  UT_BlockPaste.swift
//  XcodeBlockPasteTests
//
//  Created by Tamas Lustyik on 2017. 03. 04..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Quick
import Nimble

class BlockPasteSpec: QuickSpec {

    override func spec() {
        
        describe("pasting single selection") {
            
            context("at the end of file") {
                
                it("appends the selection to the end") {
                    
                }
                
            }
            
            context("at an inner location") {
                
                it("inserts the selection at the cursor") {
                    
                }
                
            }
            
        }
        
        describe("pasting multi selection") {

            context("at the end of file") {
                
                it("appends the first selection to the last line") {
                    
                }
                
                it("adds (<selection count> - 1) new lines") {
                    
                }
                
                it("fills inserted lines with spaces up to the cursor's column") {
                    
                }
                
                it("appends each subsequent selection at the end of the inserted padded lines") {
                    
                }
                
            }
            
            context("at an inner location") {
                
                it("inserts the first selection at the cursor") {
                    
                }
                
                context("there are more than (<EOF's line#> - <cursor's line#> + 1) selections") {
                    
                    it("adds (<selection count> - (<EOF's line#> - <cursor's line#> + 1)) new lines") {
                        
                    }
                    
                }
                
                it("pads the (<selection count> - 1) consecutive lines starting from (<cursor's line#> + 1) " +
                   "with spaces up to the cursor's column if necessary") {
                    
                }
                
                it("inserts the Nth selection (N in 0..<selection count>-1) at the cursor's column" +
                   "in the (<cursor's line#> + N)th line") {
                    
                }
                
            }

        }
        
    }
    
}
