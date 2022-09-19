#include "LUVSecondaryListController.h"

@implementation LUVAppearanceController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Appearance" target:self];
	}

	return _specifiers;
}

@end

@implementation LUVColourController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self];
	}

	return _specifiers;
}

@end

@implementation LUVMiscellaneousController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end
