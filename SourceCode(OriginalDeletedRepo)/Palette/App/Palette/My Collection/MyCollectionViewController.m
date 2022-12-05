#import "MyCollectionViewController.h"

static NSMutableDictionary *mutableDict;
static NSMutableArray *allDataArray;

static void deleteDataForID(NSString *idToRemove){
    
    //NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSString *prefPath = [NSString stringWithFormat:@"%@/MyCollection.plist", aDocumentsDirectory];
    NSString *prefPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
    mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    [mutableDict removeObjectForKey:idToRemove];
    [mutableDict writeToFile:prefPath atomically:YES];
    
}

@implementation MyCollectionViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"My Collection";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    //NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSString *prefPath = [NSString stringWithFormat:@"%@/MyCollection.plist", aDocumentsDirectory];
    NSString *prefPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
    mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    allDataArray = [NSMutableArray new];
    for(NSString *key in mutableDict){
        [allDataArray addObject:mutableDict[key]];
    }
    
    [self layoutTitleAndSubtitle];
    [self checkCollectionCount];
    [self layoutTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCollectionNotification:) name:@"NewCollectionNotification" object:nil];
}


-(void)layoutTitleAndSubtitle {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.text = @"No Collection";
    self.titleLabel.alpha = 0;
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel x:self.view.centerXAnchor y:self.view.centerYAnchor];
    [self.titleLabel leading:self.view.leadingAnchor padding:20];
    [self.titleLabel trailing:self.view.trailingAnchor padding:-20];
    
    
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.textColor = UIColor.labelColor;
    self.subtitleLabel.font = [UIFont systemFontOfSize:16];
    self.subtitleLabel.numberOfLines = 3;
    self.subtitleLabel.text = @"Browse through some colours and add them to your collection";
    self.subtitleLabel.alpha = 0;
    [self.view addSubview:self.subtitleLabel];
    
    [self.subtitleLabel x:self.view.centerXAnchor];
    [self.subtitleLabel top:self.titleLabel.bottomAnchor padding:15];
    [self.subtitleLabel leading:self.view.leadingAnchor padding:20];
    [self.subtitleLabel trailing:self.view.trailingAnchor padding:-20];
}


- (void)receiveCollectionNotification:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"NewCollectionNotification"]) {
        [self refreshTableView];
    }
    
}


-(void)checkCollectionCount {
    
    NSString *notifCnt = [NSString stringWithFormat:@"%ld", allDataArray.count];
    
    if ([notifCnt isEqualToString:@"0"]) {
        self.titleLabel.alpha = 1;
        self.subtitleLabel.alpha = 1;
    } else {
        self.titleLabel.alpha = 0;
        self.subtitleLabel.alpha = 0;
    }
}


-(void)refreshTableView {
    
    //NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSString *prefPath = [NSString stringWithFormat:@"%@/MyCollection.plist", aDocumentsDirectory];
    NSString *prefPath = @"/var/mobile/Library/Preferences/PaletteCollections.plist";
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
    mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    allDataArray = [NSMutableArray new];
    for(NSString *key in mutableDict){
        [allDataArray addObject:mutableDict[key]];
    }
    
    [self.tableView reloadData];
    
    [self performSelector:@selector(checkCollectionCount) withObject:nil afterDelay:0.2];
    
}


-(void)layoutTableView {
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allDataArray.count;;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[ColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    
    cell.backgroundColor = UIColor.clearColor;
    cell.colourView.backgroundColor = [self colorWithHexString:(NSString*)[[allDataArray objectAtIndex:indexPath.row] objectForKey:@"hexCode"]];
    cell.nameLabel.text = allDataArray[indexPath.row][@"colourName"];
    cell.hexLabel.text = allDataArray[indexPath.row][@"hexCode"];
    
    UIColor *selectedColour = [self colorWithHexString:(NSString*)[[allDataArray objectAtIndex:indexPath.row] objectForKey:@"hexCode"]];
    
    const CGFloat *_components = CGColorGetComponents(selectedColour.CGColor);
    CGFloat red = _components[0];
    CGFloat green = _components[1];
    CGFloat blue = _components[2];
    
    NSString *redString = [NSString stringWithFormat:@"%d", (int) (red * 255.0)];
    NSString *greenString = [NSString stringWithFormat:@"%d", (int) (green * 255)];
    NSString *blueString = [NSString stringWithFormat:@"%d", (int) (blue * 255)];
    
    cell.rgbLabel.text = [NSString stringWithFormat:@"RGB(%@, %@, %@)", redString, greenString, blueString];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        deleteDataForID(allDataArray[indexPath.row][@"id"]);
        [self refreshTableView];
    }
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *clearAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        deleteDataForID(allDataArray[indexPath.row][@"id"]);
        [self refreshTableView];
        
        [tableView setEditing:NO animated:YES];
        
        completionHandler(YES);
    }];
    
    UIImage *transparentImage = [UIImage imageNamed:@"transparent"];
    UIImage *trashImage = [UIImage imageNamed:@"trash"];
    CGSize sacleSize = CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [trashImage drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedTrashImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    clearAction.image = resizedTrashImage;
    clearAction.backgroundColor = [UIColor colorWithPatternImage:transparentImage];
    
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[clearAction]];
    
    return configuration;
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
        cell.alpha = 0.5;
    } completion:nil];
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        cell.alpha = 1;
    } completion:nil];
}


-(UIColor*)colorWithHexString:(NSString*)hex {
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    UIColor *selectedColour = [self colorWithHexString:(NSString*)[[allDataArray objectAtIndex:indexPath.row] objectForKey:@"hexCode"]];
    
    const CGFloat *_components = CGColorGetComponents(selectedColour.CGColor);
    CGFloat red = _components[0];
    CGFloat green = _components[1];
    CGFloat blue = _components[2];
    
    NSString *redString = [NSString stringWithFormat:@"%d", (int) (red * 255.0)];
    NSString *greenString = [NSString stringWithFormat:@"%d", (int) (green * 255)];
    NSString *blueString = [NSString stringWithFormat:@"%d", (int) (blue * 255)];
    
    
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"" message:@"Select which colour code you want to copy to clipboard." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *hexAction = [UIAlertAction actionWithTitle:@"Copy HEX Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"#%@",[[allDataArray objectAtIndex:indexPath.row] objectForKey:@"hexCode"]];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for HEX was saved to your clipboard"];
    }];
    
    
    UIAlertAction *rgbAction = [UIAlertAction actionWithTitle:@"Copy RGB Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"rgb(%@, %@, %@)",redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for RGB was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Swift)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"UIColor(red: %@.0/255.0, green: %@.0/255.0, blue: %@/255.0, alpha: 1.0)",redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for Swift was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftuiAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (SwiftUI)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"Color(red: %@/255, green: %@/255, blue: %@/255)", redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for SwiftUI was saved to your clipboard"];
    }];
    
    
    UIAlertAction *objcAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Objective-C)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"[UIColor colorWithRed:%@/255.0 green: %@/255.0 blue: %@/255.0 alpha: 1.00];", redString, greenString, blueString];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The colour values for Objective-C was saved to your clipboard"];
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [view addAction:hexAction];
    [view addAction:rgbAction];
    [view addAction:swiftAction];
    [view addAction:swiftuiAction];
    [view addAction:objcAction];
    [view addAction:cancelAction];
    [self presentViewController:view animated:YES completion:nil];
    
}


-(void)showAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    [alert showAlertWithTitle:title withSubtitle:subtitle withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
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
}

@end

