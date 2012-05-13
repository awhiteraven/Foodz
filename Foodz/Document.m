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
    for (NSString *aItem in foodzList) {
        if ([aItem isEqualToString:[foodzField stringValue]]) {
            NSAlert *existingItemAlert = [[NSAlert alloc]init]; {
                [existingItemAlert addButtonWithTitle:@"Cancel"];
                [existingItemAlert addButtonWithTitle:@"Add Item Anyway"];
                [existingItemAlert setMessageText:@"Item already exists."];
                [existingItemAlert setInformativeText:@"This is a duplicate."];
                
                [existingItemAlert setAlertStyle:NSInformationalAlertStyle];
                
                int existValue = (int)[existingItemAlert runModal];
                [existingItemAlert release];
                if (existValue == NSAlertSecondButtonReturn) 
                    break;
                else 
                    return;
            }
        }
    }
    
    [foodzList addObject:[foodzField stringValue]]; 
        
    if (sender == foodzField) 
        [foodzField setStringValue:@""];
    
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
    return [foodzList objectAtIndex:rowIndex];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    [foodzList replaceObjectAtIndex:rowIndex withObject:anObject];
}



@end
