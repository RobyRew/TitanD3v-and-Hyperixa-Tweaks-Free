#import "Headers.h"

%hook UICalloutBar

%property (nonatomic, retain) UIMenuItem *substiaItem;

-(id)initWithFrame:(CGRect)arg1 {
    UICalloutBar *orig = %orig;
    self.substiaItem = [[UIMenuItem alloc] initWithTitle:@"Substia" action:@selector(substiaSel:)];
    return orig;
}

-(void)updateAvailableButtons {
    %orig;

    if (!self.extraItems) {
        self.extraItems = @[];
    }

    bool display = false;
    NSArray *currentSystemButtons = MSHookIvar<NSArray *>(self, "m_currentSystemButtons");

    for (UICalloutBarButton *btn in currentSystemButtons) {
        if (btn.action == @selector(cut:)) {
            display = true;
        }
    }

    NSMutableArray *items = [self.extraItems mutableCopy];

    if (display) {
        if (![items containsObject:self.substiaItem]) {
            [items addObject:self.substiaItem];
        }
    } else {
        [items removeObject:self.substiaItem];
    }

    self.extraItems = items;

    %orig;
}

%end


%hook UIResponder
%new
-(void)substiaSel:(UIResponder *)sender {
	NSLog(@"aaaaaaaaaaaaa substiaSel...");

	NSString *originalText = [[UIPasteboard generalPasteboard].string copy];
    [[UIApplication sharedApplication] sendAction:@selector(cut:) to:nil from:self forEvent:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *selectedText = [[UIPasteboard generalPasteboard].string copy];

        if (selectedText) {
            [[UIPasteboard generalPasteboard] setString:selectedText];

			UIViewController * controller = [[UIApplication sharedApplication] keyWindow].rootViewController;

		    UIAlertController * alert = [UIAlertController  alertControllerWithTitle:@"Enter Shortcut and Phrase" 
		    message:nil
		    preferredStyle:UIAlertControllerStyleAlert];

		    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
		      textField.placeholder = @"Enter New Shortcut";
		      textField.text = selectedText;
		    }];

		    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
		      textField.placeholder = @"Enter New Phrase";
		    }];

		    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Add" 
		    style:UIAlertActionStyleDefault
		    handler:^(UIAlertAction * action) {
				
				NSString *shortcut = alert.textFields[0].text;
				NSString *phrase = alert.textFields[1].text;
				
				if([shortcut length] != 0 && [phrase length] !=0){
					[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.substia/addTRData" object:nil userInfo:@{@"shortcut" : shortcut, @"phrase" : phrase}];
				}
				else{
					UIAlertController * alertIN = [UIAlertController  alertControllerWithTitle:@"Please enter Shortcut and Phrase" 
				    message:nil
				    preferredStyle:UIAlertControllerStyleAlert];

				    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
				    
				    [alertIN addAction:cancelButton];
				    [controller presentViewController:alertIN animated:YES completion:nil];
				}

		    }];

		    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {}];

		    [alert addAction:okButton];
		    [alert addAction:cancelButton];
		    [controller presentViewController:alert animated:YES completion:nil];
            [[UIApplication sharedApplication] sendAction:@selector(paste:) to:nil from:self forEvent:nil];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (originalText) {
                [[UIPasteboard generalPasteboard] setString:originalText];
            } else {
                [[UIPasteboard generalPasteboard] setString:@""];
            }
        });
    });
}
%end


%hook SBHomeScreenViewController
-(void)viewDidAppear:(bool)arg1 {
	%orig;
	[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.substia/addTRData" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
		NSString *shortcutIn = [[[notification userInfo] objectForKey:@"shortcut"] stringValue];
		NSString *phraseIn = [[[notification userInfo] objectForKey:@"phrase"] stringValue];
		
	
		_KSTextReplacementClientStore *store = [[%c(_KSTextReplacementClientStore) alloc] init];
	 	_KSTextReplacementEntry *newEntry = [[%c(_KSTextReplacementEntry) alloc] init];
	    newEntry.phrase = phraseIn;
	    newEntry.shortcut = shortcutIn;
	    newEntry.needsSaveToCloud = YES;
	    newEntry.timestamp = [NSDate date];
		
	    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
	    NSCAssert([%c(_KSTextReplacementHelper) validateTextReplacement:newEntry] == 0,
			[%c(_KSTextReplacementHelper) errorStringForCode:
			[%c(_KSTextReplacementHelper) validateTextReplacement:newEntry]]);

	    [store addEntries:@[newEntry] removeEntries:nil withCompletionHandler:^(NSError *error) {
	        dispatch_semaphore_signal(sema);
	    }];
	}];
}
%end