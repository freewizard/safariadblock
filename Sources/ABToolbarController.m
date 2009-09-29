#import "ABToolbarController.h"
#import "Constants.h"
#import "ABHelper.h"
#import "ABController.h"

@implementation NSObject (ABToolbarController)

- (NSArray *)adblock_toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return [[self adblock_toolbarAllowedItemIdentifiers:toolbar] arrayByAddingObject:SafariAdBlockToolbarIdentifier];
}

- (NSToolbarItem *)adblock_toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	if (![itemIdentifier isEqualToString:SafariAdBlockToolbarIdentifier])
		return [self adblock_toolbar:toolbar itemForItemIdentifier:itemIdentifier willBeInsertedIntoToolbar:flag];
	
	NSButton *button = [[[NSButton alloc] initWithFrame:NSMakeRect(0.0, 0.0, 28.0, 22.0)] autorelease];
	[button setButtonType:NSToggleButton];
	[button setBezelStyle:NSTexturedRoundedBezelStyle];
	NSImage *on = [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:BundleIdentifier] pathForImageResource:@"ToolbarOn"]] autorelease];
	NSImage *off = [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:BundleIdentifier] pathForImageResource:@"ToolbarOff"]] autorelease];
	[button setImage:on];
	[button setAlternateImage:off];
	[button setTitle:nil];
	//[button setTarget:[ABController sharedController]];
	//[button setAction:@selector(enabledOrDisable:)];
	[button bind:@"value" toObject:[NSUserDefaults standardUserDefaults] withKeyPath:IsEnabledPrefsKey options:[NSDictionary dictionaryWithObject:NSNegateBooleanTransformerName forKey:NSValueTransformerNameBindingOption]];
	
	NSToolbarItem *toolbarItem = [[[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier] autorelease];
	[toolbarItem setLabel:@"Safari AdBlock"];
	[toolbarItem setPaletteLabel:@"Enable/Disable Safari AdBlock"];
	[toolbarItem setToolTip:@"Enable/Disable Safari AdBlock"];
	[toolbarItem setView:button];	
	
  return toolbarItem;
}

@end
