#import <Cocoa/Cocoa.h>
#import "Safari.h"

@interface NSObject (ABToolbarController)

- (NSArray *)adblock_toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar;
- (NSToolbarItem *)adblock_toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;

@end