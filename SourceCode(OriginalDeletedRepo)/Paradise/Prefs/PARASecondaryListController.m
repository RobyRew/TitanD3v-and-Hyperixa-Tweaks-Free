#include "PARASecondaryListController.h"

@implementation PARAAppearanceController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Appearance" target:self];
	}

	return _specifiers;
}

@end


@implementation PARAColourController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self];
	}

	return _specifiers;
}

@end


@implementation PARAMiscellaneousController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end
