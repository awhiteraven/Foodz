//
//  Document.m
//  Foodz
//
//  Created by Jon Wei on 5/11/12.
//  Copyright (c) 2012 aWhiteRaven. All rights reserved.
//

#import "Document.h"

@implementation Document

- (id)init {
    if (self = [super init]) {
        // Add your subclass-specific initialization here.
        // If an error occurs here, return nil.
        // arrayWithObjects returned autorelease.
        foodzList = [[NSMutableArray alloc]init];
                     
        NSDictionary *diablo = [NSMutableDictionary dictionary];
        [diablo setValue:@"Diablo" forKey:@"nameKey"];
        [diablo setValue:@"3" forKey:@"qualityKey"];
        [foodzList addObject:diablo];
        
        NSDictionary *minecraft = [NSMutableDictionary dictionary];
        [minecraft setValue:@"Minecraft" forKey:@"nameKey"];
        [minecraft setValue:@"10" forKey:@"qualityKey"];
        [foodzList addObject:minecraft];
        
        [pBar setUsesThreadedAnimation:NO];
    }
    return self;
}

- (void)dealloc {
    [foodzList release];
    foodzList = nil;
    
    [super dealloc];
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    /*
     Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    */
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    /*
    Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    */
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (IBAction)addFood:(id)sender {
    NSNumber *quantity = [NSNumber numberWithInt:[qualityField intValue]];
    
    NSMutableDictionary *newItem = [NSMutableDictionary dictionary];
    [newItem setValue:[foodzField stringValue] forKey:@"nameKey"];
    [newItem setValue:quantity forKey:@"qualityKey"];
     
    [foodzList addObject:newItem]; 
    
    [foodzTable reloadData];
    
}

- (IBAction)removeFood:(id)sender {
    int selectedIndex = (int)[foodzTable selectedRow];
    if (selectedIndex == -1) 
        return;
    
    
    NSAlert *deleteAlert = [[NSAlert alloc]init]; {
        [deleteAlert addButtonWithTitle:@"Delete"];
        [deleteAlert addButtonWithTitle:@"Cancel"];
        [deleteAlert setMessageText:@"Delete this item?"];
        [deleteAlert setInformativeText:@"Deleted items cannot be restored."];
        
        [deleteAlert setAlertStyle:NSWarningAlertStyle];
        
        int deleteValue = (int)[deleteAlert runModal];
        if (deleteValue == NSAlertFirstButtonReturn) {
            [foodzList removeObjectAtIndex:selectedIndex];
            [foodzTable reloadData];
        }
        
        [deleteAlert release];
    }
    
    
}

- (IBAction)pBarAdd:(id)sender {
    [pBar incrementBy:10];
    for (int i = 0; i < 10; i++) {
        [pBar incrementBy:1];
    }
}

- (IBAction)pBarMinus:(id)sender {
    [pBar incrementBy:-10];
}



/**
 Saving methods
 */
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)type error:(NSError **)outError {
    return [foodzList writeToURL:url atomically:YES];
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)type error:(NSError **)outError {
    [foodzList release];
    foodzList = nil;
    foodzList = [[NSMutableArray alloc]initWithContentsOfURL:url];
    [foodzTable reloadData];
    
    return YES;
}


/**
 Protocol methods
 */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [foodzList count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    NSDictionary *itemDictionary = [foodzList objectAtIndex:rowIndex];
    
    if (aTableColumn == qualityColumn) 
        return [itemDictionary valueForKey:@"qualityKey"];
    else if (aTableColumn == itemColumn)
        return [itemDictionary valueForKey:@"nameKey"];
    else
        return nil;
    
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    NSDictionary *itemDictionary = [foodzList objectAtIndex:rowIndex];
    
    NSLog(@"%@",[anObject class]);
    
    if (aTableColumn == qualityColumn) 
        [itemDictionary setValue:anObject forKey:@"qualityKey"];
    else if (aTableColumn == itemColumn)
        [itemDictionary setValue:anObject forKey:@"nameKey"];
 
}



@end
