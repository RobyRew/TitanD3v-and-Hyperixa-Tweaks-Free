#include "DVCSecondaryListController.h"

@implementation DVCGestureController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Gesture" target:self];
	}

	return _specifiers;
}

@end


@implementation DVCColourController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self];
	}

	return _specifiers;
}

@end


@implementation DVCMiscellaneousController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end
