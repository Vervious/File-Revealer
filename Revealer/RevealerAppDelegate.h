//
//  RevealerAppDelegate.h
//  Revealer
//
//  Created by Nano8Blazex on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VV_StatusItemView.h"

@interface RevealerAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
    NSWindow *window;
    IBOutlet NSMenu *ourStatusBarMenu;
    NSStatusItem *ourItem;
    
    /* popover */
    BOOL hasActiveInterface;
    NSPoint pointOfReference;
}

@property (assign) IBOutlet NSWindow *window;
//popover
@property (nonatomic, assign) BOOL hasActiveInterface;
@property (nonatomic, assign) NSPoint pointOfReference;

-(IBAction)toggleLoginItemStatus:(id)sender;
- (IBAction)updateStatusMenuDisplay:(id)sender;
- (IBAction)updateStatusBarOnly:(id)sender; 
-(IBAction)showMainWindows:(id)sender;
- (void)activateStatusMenu;
- (void)disableStatusMenu;

//status bar
- (IBAction)itemClicked:(VV_StatusItemView *)sender;



@end
