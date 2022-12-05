#include "DGTSecondaryListController.h"

@implementation DGTAppearanceController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Appearance" target:self];
	}

	return _specifiers;
}

@end


@implementation DGTColourController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self];
	}

	return _specifiers;
}

@end


@implementation DGTMiscellaneousController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end
