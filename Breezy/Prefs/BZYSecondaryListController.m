#include "BZYSecondaryListController.h"

@implementation BZYGestureController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Gesture" target:self];
	}

	return _specifiers;
}

@end
