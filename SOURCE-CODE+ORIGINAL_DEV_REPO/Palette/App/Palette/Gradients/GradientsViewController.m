#import "GradientsViewController.h"

@implementation GradientsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Gradients";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    self.colourArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"GradientColour" ofType: @"plist"]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[GradientCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colourArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GradientCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.clearColor;
    
    UIColor *primraryColour = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"primraryHexCode"]];
    UIColor *secondaryColour = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"secondaryHexCode"]];
    
    cell.gradient.colors = @[(id)primraryColour.CGColor, (id)secondaryColour.CGColor];
    
    cell.firstPreview.backgroundColor = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"primraryHexCode"]];
    cell.secondPreview.backgroundColor = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"secondaryHexCode"]];
    cell.firstLabel.text = [NSString stringWithFormat:@"#%@",[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"primraryHexCode"]];
    cell.secondLabel.text = [NSString stringWithFormat:@"#%@",[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"secondaryHexCode"]];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width /2 -15;
    return CGSizeMake(width, width);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,10,0,10);  // top, left, bottom, right
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    UIColor *firstColour = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"primraryHexCode"]];
    
    const CGFloat *_components1 = CGColorGetComponents(firstColour.CGColor);
    CGFloat red1 = _components1[0];
    CGFloat green1 = _components1[1];
    CGFloat blue1 = _components1[2];
    
    NSString *redString1 = [NSString stringWithFormat:@"%d", (int) (red1 * 255.0)];
    NSString *greenString1 = [NSString stringWithFormat:@"%d", (int) (green1 * 255)];
    NSString *blueString1 = [NSString stringWithFormat:@"%d", (int) (blue1 * 255)];
    
    
    UIColor *secondColour = [self colorWithHexString:(NSString*)[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"secondaryHexCode"]];
    
    const CGFloat *_components2 = CGColorGetComponents(secondColour.CGColor);
    CGFloat red2 = _components2[0];
    CGFloat green2 = _components2[1];
    CGFloat blue2 = _components2[2];
    
    NSString *redString2 = [NSString stringWithFormat:@"%d", (int) (red2 * 255.0)];
    NSString *greenString2 = [NSString stringWithFormat:@"%d", (int) (green2 * 255)];
    NSString *blueString2 = [NSString stringWithFormat:@"%d", (int) (blue2 * 255)];
    
    
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"" message:@"Select which colour code you want to copy to clipboard." preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *hexAction = [UIAlertAction actionWithTitle:@"Copy HEX Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"First Colour: #%@ \nSecond Colour: #%@",[[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"primraryHexCode"], [[self.colourArray objectAtIndex:indexPath.row] objectForKey:@"secondaryHexCode"]];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The gradient colour values for HEX was saved to your clipboard"];
    }];
    
    
    UIAlertAction *rgbAction = [UIAlertAction actionWithTitle:@"Copy RGB Values" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"First Colour: rgb(%@, %@, %@) \nSecond Colour: rgb(%@, %@, %@)",redString1, greenString1, blueString1, redString2, greenString2, blueString2];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The gradient colour values for RGB was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Swift)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"First Colour: UIColor(red: %@.0/255.0, green: %@.0/255.0, blue: %@/255.0, alpha: 1.0) \nSecond Colour: UIColor(red: %@.0/255.0, green: %@.0/255.0, blue: %@/255.0, alpha: 1.0)",redString1, greenString1, blueString1, redString2, greenString2, blueString2];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The gradient colour values for Swift was saved to your clipboard"];
    }];
    
    
    UIAlertAction *swiftuiAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (SwiftUI)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"First Colour: Color(red: %@/255, green: %@/255, blue: %@/255) \nSecond Colour: Color(red: %@/255, green: %@/255, blue: %@/255)", redString1, greenString1, blueString1, redString2, greenString2, blueString2];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The gradient colour values for SwiftUI was saved to your clipboard"];
    }];
    
    
    UIAlertAction *objcAction = [UIAlertAction actionWithTitle:@"Copy UIColor Values (Objective-C)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        pasteboard.string = [NSString stringWithFormat:@"First Colour: [UIColor colorWithRed:%@/255.0 green: %@/255.0 blue: %@/255.0 alpha: 1.00]; \nSecond Colour: [UIColor colorWithRed:%@/255.0 green: %@/255.0 blue: %@/255.0 alpha: 1.00];", redString1, greenString1, blueString1, redString2, greenString2, blueString2];
        [self showAlertWithTitle:@"Saved!" subtitle:@"The gradient colour values for Objective-C was saved to your clipboard"];
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


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
        cell.alpha = 0.5;
    } completion:nil];
    
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
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


@end
