#import <UIKit/UIKit.h>
#import <substrate.h>

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)app {
    %orig;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ButterflyLoaded" object:nil];
}
%end
