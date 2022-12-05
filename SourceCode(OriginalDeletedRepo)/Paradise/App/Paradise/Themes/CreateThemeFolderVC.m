#import "CreateThemeFolderVC.h"

@implementation CreateThemeFolderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    self.addButton.hidden = YES;
    [self.textField becomeFirstResponder];
}


- (IBAction)beginEditing:(id)sender {
    
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
}


- (IBAction)editingChanged:(id)sender {
    
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
}


- (IBAction)finishedEdited:(id)sender {
    
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
}


- (IBAction)addNewFolder:(id)sender {
    
    NSString *string = self.textField.text;
    
    NSString *specialCharacterString = @"!~`@#$%^&*-+();:={}[],.<>?\\/\"\'.";
    NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacterString];
    
    if ([string.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length) {
        
        [self.textField resignFirstResponder];
        [self showWarningAlert];
        
    } else {
        
        NSString *dataPath = [NSString stringWithFormat:@"/Library/Themes/%@.theme/", self.textField.text];
        NSString *dataPath2 = [NSString stringWithFormat:@"/Library/Themes/%@.theme/IconBundles/", self.textField.text];

        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath2 withIntermediateDirectories:NO attributes:nil error:nil];
          
        }
        
        [self.textField resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddedNewThemeNotification" object:self];
        
    }
    
}


-(void)showWarningAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"You can't use special character or adding .theme extension as it will be added automatically." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.textField becomeFirstResponder];
    }];
    
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)dismissVC:(id)sender {
    
    [self.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
