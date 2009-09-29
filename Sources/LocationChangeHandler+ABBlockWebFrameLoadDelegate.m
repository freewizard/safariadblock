/*
 This file is part of Safari AdBlock.
 
 Safari AdBlock is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 any later version.
 
 Safari AdBlock is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with Safari AdBlock.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "LocationChangeHandler+ABBlockWebFrameLoadDelegate.h"
#import <RegexKit/RegexKit.h>
#import "Constants.h"
#import "ABController.h"
#import "ABHelper.h"

// Fake src definition, because we know DOMHTMLImageElement and DOMHTMLEmbedElement implement it
@interface DOMElement (ABDOMElement)
- (NSString *)src;
@end

@implementation NSObject (ABLocationChangeHandler)

- (void)adblock_webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:IsEnabledPrefsKey] && [[frame DOMDocument] documentElement]) {
	
		// If page is not whitelisted
		if (![[sender mainFrameURL] _isMatchedByAnyRegexInArray:[[[ABController sharedController] filters] objectForKey:PageWhiteListFiltersKey]]) {
			
			NSArray *whiteList = [[[ABController sharedController] filters] objectForKey:WhiteListFiltersKey];
			NSArray *blockList = [[[ABController sharedController] filters] objectForKey:BlockListFiltersKey];
			NSArray *types = [NSArray arrayWithObjects:@"img", @"embed", @"iframe", nil];
            
			for (NSString *type in types) {
                @try {
                    DOMXPathResult* elements = [[frame DOMDocument] evaluate:[@"//" stringByAppendingString:type]
                                                                 contextNode:[[frame DOMDocument] documentElement]
                                                                    resolver:nil
                                                                        type:DOM_UNORDERED_NODE_SNAPSHOT_TYPE
                                                                    inResult:nil];
                    DOMElement *element = nil;
                    unsigned i, len = elements.snapshotLength;
                    for (i = 0; i < len; ++i) {
                        element = (DOMElement *)[elements snapshotItem:i];
                        if ([element respondsToSelector:@selector(src)]) {
                            NSString *src = [element src];
                            if (![src _isMatchedByAnyRegexInArray:whiteList])
                                if ([src _isMatchedByAnyRegexInArray:blockList])
                                    [element setAttribute:@"style" value:@"visibility: hidden;"];
                        }
                    }
                }
                @catch (NSException *e) {
                    NSLog(@"Safari AdBlock: exception %@ in adblock_webView:didFinishLoadForFrame:", e);
                }
			}
		}
	}
	[self adblock_webView:sender didFinishLoadForFrame:frame];
}

@end
