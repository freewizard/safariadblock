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

#import "SABPreferences.h"
#import "SABPreferencesModule.h"

@implementation NSObject (ABPreferences)

+ (id)sharedPreferencesAdblock {
	static BOOL	preferencesAdded = NO;
	id preferences = [self sharedPreferencesAdblock];
	
	if (preferences != nil && !preferencesAdded) {
		[preferences addPreferenceNamed:@"AdBlock" owner:[SABPreferencesModule sharedInstance]];
		preferencesAdded = YES;
	}

	return preferences;
}

@end
