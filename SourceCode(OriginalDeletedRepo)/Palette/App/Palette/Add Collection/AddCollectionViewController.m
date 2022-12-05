#import "AddCollectionViewController.h"

@implementation AddCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorNamed:@"Accent"] forState:UIControlStateNormal];
    [self.view addSubview:self.cancelButton];
    
    [self.cancelButton top:self.view.topAnchor padding:16];
    [self.cancelButton leading:self.view.leadingAnchor padding:20];
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton addTarget:self action:@selector(addCollection) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor colorNamed:@"Accent"] forState:UIControlStateNormal];
    self.addButton.hidden = YES;
    [self.view addSubview:self.addButton];
    
    [self.addButton top:self.view.topAnchor padding:16];
    [self.addButton trailing:self.view.trailingAnchor padding:-20];
    
    
    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImage.image = [UIImage systemImageNamed:@"heart.fill"];
    [self.view addSubview:self.iconImage];
    
    [self.iconImage size:CGSizeMake(80, 80)];
    [self.iconImage top:self.addButton.bottomAnchor padding:25];
    [self.iconImage x:self.view.centerXAnchor];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightSemibold];
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.text = @"Collection Name";
    self.titleLabel.numberOfLines = 2;
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel top:self.iconImage.bottomAnchor padding:30];
    [self.titleLabel leading:self.view.leadingAnchor padding:20];
    [self.titleLabel trailing:self.view.trailingAnchor padding:-20];
    [self.titleLabel x:self.view.centerXAnchor];
    
    
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.placeholder = @"Enter collection name...";
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.backgroundColor = [UIColor colorNamed:@"Containers"];
    self.textField.textColor = UIColor.labelColor;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textField];
    
    [self.textField height:40];
    [self.textField top:self.titleLabel.bottomAnchor padding:30];
    [self.textField leading:self.view.leadingAnchor padding:20];
    [self.textField trailing:self.view.trailingAnchor padding:-20];
    [self.textField x:self.view.centerXAnchor];
    
    [self.textField becomeFirstResponder];
}


- (void)textFieldDidChange:(id)sender {
   
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.textField.text && self.textField.text.length > 0) {
        self.addButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
    }
    
    return YES;
}


-(void)addCollection {
    
    [self.textField resignFirstResponder];
    
    //NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSString *prefPath = [NSString stringWithFormat:@"%@/MyCollection.plist", aDocumentsDirectory];
    NSString *prefPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
    self.mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *withID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
    NSDictionary *data = @{@"id" : withID, @"colourName" : self.textField.text, @"hexCode" : self.hexCode};
    [self.mutableDict setValue:data forKey:withID];
    [self.mutableDict writeToFile:prefPath atomically:YES];
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    [alert showAlertWithTitle:@"" withSubtitle:[NSString stringWithFormat:@"%@ have been added to your collection", self.textField.text] withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
    alert.alertBackgroundColor = [UIColor colorNamed:@"Alert"];
    alert.titleColor = UIColor.systemGreenColor;
    alert.subTitleColor = UIColor.labelColor;
    [alert makeAlertTypeSuccess];
    alert.blurBackground = YES;
    alert.autoHideSeconds = 2;
    alert.dismissOnOutsideTouch = YES;
    alert.bounceAnimations = YES;
    alert.animateAlertInFromTop = YES;
    alert.animateAlertOutToBottom = YES;
    alert.hideAllButtons = YES;
    
    [self performSelector:@selector(dismissVC2) withObject:nil afterDelay:2.5];
    
}


- (void)dismissVC {
    
    [self.textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dismissVC2 {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewCollectionNotification" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
