//
//  Document.h
//  Foodz
//
//  Created by Jon Wei on 5/11/12.
//  Copyright (c) 2012 aWhiteRaven. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Document objects provide functionality typical documents have

@interface Document : NSDocument <NSTableViewDataSource> {
    
    IBOutlet NSTableView *foodzTable;
    IBOutlet NSTextField *foodzField;
    IBOutlet NSTextField *qualityField;
    
    // Columns
    IBOutlet NSTableColumn *qualityColumn;
    IBOutlet NSTableColumn *itemColumn;
    
    NSMutableArray *foodzList;
}
- (IBAction)addFood:(id)sender;
- (IBAction)removeFood:(id)sender;

@end
