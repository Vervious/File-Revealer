//
//  RevealerAppDelegate.m
//  Revealer
//
//  Created by Nano8Blazex on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RevealerAppDelegate.h"
#import "VV_StatusItemView.h"
#import "VV_Interface.h"

#define WINDOW_CLOSE_DURATION .2
#define WINDOW_OPEN_DURATION .1
#define GAP_FROM_TOP 5

@interface RevealerAppDelegate() 

// declare private methods to surpress warnings
- (void)showInterface;
- (void)hideInterface;
- (void)calculateAndSetInterfaceSizeAndPosition;

@end

@implementation RevealerAppDelegate

@synthesize window;
@synthesize hasActiveInterface;
@synthesize pointOfReference;



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    ourItem = nil;

    [self updateStatusMenuDisplay:self];
    //[self updateStatusBarOnly:self]; //New Version does not have option for window
    [[self window] makeKeyAndOrderFront:nil]; // to make sure it shows up correctly once we use it
    [[self window] orderOut:nil]; // also see http://stackoverflow.com/questions/9245219/nspanel-popping-up-in-the-wrong-space/9245705#9245705
    
    
    /* Establish popover display settings */
    [NSApp activateIgnoringOtherApps:NO];
    // configure appearance of the panel
    NSPanel *panel = (id)[self window];
    [panel setAcceptsMouseMovedEvents:YES];
    [panel setLevel:NSPopUpMenuWindowLevel];
    // Make clear color so we can completely customize the panel using it's background view
    [panel setOpaque:NO];
    [panel setBackgroundColor:[NSColor clearColor]];
    
    // now calculate size, etc. of window
    VV_StatusItemView *statusItemView = (VV_StatusItemView *)ourItem.view;
    [self setPointOfReference:statusItemView.referencePoint];
    
}

/*- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    //BOOL statusEnabled = [[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"statusEnabled"] boolValue]; //YES if status bar is enabled, NO if not
	//return !statusEnabled;
}*/

//terminate stuff
-(void)applicationWillTerminate:(NSNotification *)notification {
    if (ourItem != nil) [ourItem release];
}

#pragma mark Window Behavior

- (void)windowWillClose:(NSNotification *)notification {
}

- (void)windowDidResignKey:(NSNotification *)notification {
    // resign Key and close interface
    [self setHasActiveInterface:NO];
}


#pragma mark no window only status bar 

- (IBAction)showMainWindows:(id)sender {
    [window makeKeyAndOrderFront:sender];
}

- (IBAction)updateStatusBarOnly:(id)sender {
    BOOL statusBarOnly = [[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"statusBarOnly"] boolValue];
    if (!statusBarOnly) {
        //ProcessSerialNumber psn = { 0, kCurrentProcess };
        //TransformProcessType(&psn, kProcessTransformToForegroundApplication); //shows the dock icon, pity we can't do the reverse
        [self showMainWindows:sender];
    } else {
        //DO nOT SHOW WINDOW ON LAUNCH
    }
}

#pragma mark status bar

- (IBAction)updateStatusMenuDisplay:(id)sender {
    /*BOOL statusEnabled = [[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"statusEnabled"] boolValue];
    if (statusEnabled) {
        [self activateStatusMenu];
    } else {
        [self disableStatusMenu];
        [[[NSUserDefaultsController sharedUserDefaultsController] values] setValue:[NSNumber numberWithBool:NO] forKey:@"openAtLogin"];
        [[[NSUserDefaultsController sharedUserDefaultsController] values] setValue:[NSNumber numberWithBool:NO] forKey:@"statusBarOnly"];
    }*/
    [self activateStatusMenu];
    [self toggleLoginItemStatus:sender];
}

// creates and returns a status bar item with preset parameters
- (NSStatusItem *)createStatusBarItemWithAction:(SEL)action {
    
    NSStatusBar *universalBar = [NSStatusBar systemStatusBar];
    NSStatusItem *newItem = [universalBar statusItemWithLength:NSSquareStatusItemLength];
    [newItem retain]; // not needed due to ARC
    
    // draw a custom view for the status Item to be able to get its position
    VV_StatusItemView *itemView = [[VV_StatusItemView alloc] initWithStatusItem:newItem];
    [itemView setImage:[NSImage imageNamed:@"statusIcon.png"]];
    [itemView setAlternateImage:[NSImage imageNamed:@"alternateStatusIcon.png"]];
    [itemView setAction:action];
    [itemView setTarget:self];
    [newItem setView:itemView];
    
    return newItem;
}

- (void)activateStatusMenu
{
    if (ourItem == nil) {
        /*NSStatusBar *bar = [NSStatusBar systemStatusBar];
        
        ourItem = [bar statusItemWithLength:NSSquareStatusItemLength];
        [ourItem retain];
        
        [ourItem setImage:[NSImage imageNamed:@"statusIcon.png"]];
        [ourItem setAlternateImage:[NSImage imageNamed:@"alternateStatusIcon.png"]];
        //[ourItem setTitle:@"FR"];
        [ourItem setHighlightMode:YES];
        [ourItem setMenu:ourStatusBarMenu];*/
        ourItem = [self createStatusBarItemWithAction:@selector(itemClicked:)];
        
    }
}

-(void)disableStatusMenu {
    if (ourItem!=nil) {
        NSStatusBar *bar = [NSStatusBar systemStatusBar];
        [bar removeStatusItem:ourItem];
        [ourItem release];
        ourItem = nil;
    }
}

#pragma mark event handling

/* handles a click on sender (type VV_StatusItemView) */
- (IBAction)itemClicked:(VV_StatusItemView *)sender {
    
    /* toggles the visibility of interface and click */
    // update popover location in case the menu moves (like between fullscreen mode and normal mode apps)
    [self setPointOfReference:sender.referencePoint];
    
    // now show the interface (or hide it). Since this is bound to the icon state through this controller, that changes too
    [self setHasActiveInterface:!(self.hasActiveInterface)];
}

#pragma mark setters

- (void)setHasActiveInterface:(BOOL)newFlag {
    if ( hasActiveInterface == newFlag ) return;
    hasActiveInterface = newFlag;
    // now display it!
    if ( hasActiveInterface ) {
        // show interface
        [self showInterface];
    } else {
        // hide interface
        [self hideInterface];
    }
    // now update our menuItem
    [(VV_StatusItemView *)[ourItem view] setHighlighted:self.hasActiveInterface];
}

- (void)setPointOfReference:(NSPoint)newPointOfReference {
    pointOfReference = newPointOfReference;
    // and recalculate interface location
    [self calculateAndSetInterfaceSizeAndPosition];
}

#pragma mark Panel Calculations

// calculate the window position and put it in the right spot
- (void)calculateAndSetInterfaceSizeAndPosition {
    VV_Interface * panel = (VV_Interface *)[self window];
    NSRect originalRect = [panel frame];
    NSRect newRect = originalRect;
    
    /* calculate interface size */
    // calculate position
    CGFloat newX = pointOfReference.x;
    CGFloat newY = pointOfReference.y;
    newX -= (newRect.size.width / 2);
    newY -= ((CGFloat) GAP_FROM_TOP + newRect.size.height);
    NSPoint newOrigin = NSMakePoint( newX, newY );
    newRect.origin = newOrigin;
    
    // calculate  and set arrow position
    [panel.interface setArrowXLocation:(int)(pointOfReference.x - newX)];
    
    [panel setFrame:newRect display:NO];
    
}

#pragma mark Panel

// show the interface (fade it in)
- (void)showInterface {
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:WINDOW_OPEN_DURATION];
    [[[self window] animator] setAlphaValue:1];
    [NSAnimationContext endGrouping];
    [[self window] makeKeyAndOrderFront:self];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:[self window] selector:@selector(orderOut:) object:self];
}

// hide the interface (fade it out)
- (void)hideInterface {  
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:WINDOW_CLOSE_DURATION];
    [[[self window] animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    [[self window] performSelector:@selector(orderOut:) withObject:self afterDelay:WINDOW_CLOSE_DURATION]; 
    
}



#pragma mark login items

-(void) addAppAsLoginItem{
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath]; 
    
	// Create a reference to the shared file list.
    // We are adding it to the current user only.
    // If we want to add it all users, use
    // kLSSharedFileListGlobalLoginItems instead of
    //kLSSharedFileListSessionLoginItems
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		//Insert an item to the list.
		LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
                                                                     kLSSharedFileListItemLast, NULL, NULL,
                                                                     url, NULL, NULL);
		if (item){
			CFRelease(item);
        }
	}	
    
	CFRelease(loginItems);
}

-(void) deleteAppFromLoginItem{
	NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath]; 
    
	// Create a reference to the shared file list.
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems, NULL);
    
	if (loginItems) {
		UInt32 seedValue;
		//Retrieve the list of Login Items and cast them to
		// a NSArray so that it will be easier to iterate.
		CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(loginItems, &seedValue);
		
		for(int i = 0 ; i< [(NSArray *)loginItemsArray count]; i++){
			LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)[(NSArray *)loginItemsArray
                                                                        objectAtIndex:i];
			//Resolve the item with URL
			if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr) {
				NSString * urlPath = [(NSURL*)url path];
				if ([urlPath compare:appPath] == NSOrderedSame){
					LSSharedFileListItemRemove(loginItems,itemRef);
				}
                CFRelease(url);
			}
		}
		CFRelease(loginItemsArray);
	}
    
    CFRelease(loginItems);
}

-(IBAction)toggleLoginItemStatus:(id)sender {
    BOOL openAtLogin = [[[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"openAtLogin"] boolValue];
    if (openAtLogin) {
        [self deleteAppFromLoginItem]; //reset it
        [self addAppAsLoginItem];
    } else {
        [self deleteAppFromLoginItem];
    }
}


@end
