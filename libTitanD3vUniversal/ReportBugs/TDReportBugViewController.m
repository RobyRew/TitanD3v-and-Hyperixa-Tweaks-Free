#import "TDReportBugViewController.h"
#import "TDReportCell.h"

#define iPhone_SE ([[UIScreen mainScreen] bounds].size.height == 568) // iPhone SE
#define iPhone_6_8 ([[UIScreen mainScreen] bounds].size.height == 667) // iPhone 6, 6s, 7 and 8
#define iPhone_6_8_Plus ([[UIScreen mainScreen] bounds].size.height == 736) // iPhone 6, 6s, 7 and 8 Plus
#define iPhone_X_XS_11Pro ([[UIScreen mainScreen] bounds].size.height == 812) // iPhone X, XS, 11 Pro
#define iPhone_XR_XS_11Pro ([[UIScreen mainScreen] bounds].size.height == 896) // iPhone XR, XS Max, 11 Pro Max
#define iPhone_12_Pro ([[UIScreen mainScreen] bounds].size.height == 844) // iPhone 12 & 12 Pro
#define iPhone_12_mini ([[UIScreen mainScreen] bounds].size.height == 780) // iPhone 12 mini
#define iPhone_12_Pro_Max ([[UIScreen mainScreen] bounds].size.height == 926) // iPhone 12 Pro Max

static UIImagePickerController *pickerView;
static NSInteger categoriesSelectedIndex = 0;
NSData *documentData;
NSData *imageData;
NSString *urlString;
NSString *messageString;

float basePadding;
float cancelPadding;
float collectionTopPadding;
float attachmentPadding;
float messageHeight;
float composeHeight;

@implementation TDReportBugViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.clearColor;
  self.tintColour = [[TDAppearance sharedInstance] tintColour];

  [self layoutDeviceSize];
  [self layoutBaseView];
  [self layoutBanner];
  [self layoutButton];
  [self layoutAttachment];
  [self layoutMessage];
  [self layoutCollectionView];
  [self layoutCompose];
}


-(void)layoutDeviceSize {

  if (iPhone_6_8) {

    basePadding = 25;
    cancelPadding = 10;
    collectionTopPadding = 10;
    attachmentPadding = 25;
    messageHeight = 50;
    composeHeight = 280;

  } else if (iPhone_6_8_Plus) {

    basePadding = 25;
    cancelPadding = 10;
    collectionTopPadding = 10;
    attachmentPadding = 25;
    messageHeight = 50;
    composeHeight = 300;

  } else if (iPhone_X_XS_11Pro) {

    basePadding = 40;
    cancelPadding = 20;
    collectionTopPadding = 10;
    attachmentPadding = 35;
    messageHeight = 60;
    composeHeight = 320;

  } else if (iPhone_XR_XS_11Pro) {

    basePadding = 70;
    cancelPadding = 35;
    collectionTopPadding = 10;
    attachmentPadding = 55;
    messageHeight = 60;
    composeHeight = 370;

  } else if (iPhone_12_Pro) {

    basePadding = 70;
    cancelPadding = 35;
    collectionTopPadding = 10;
    attachmentPadding = 55;
    messageHeight = 60;
    composeHeight = 370;

  } else if (iPhone_12_mini) {

    basePadding = 90;
    cancelPadding = 10;
    collectionTopPadding = 10;
    attachmentPadding = 25;
    messageHeight = 50;
    composeHeight = 280;

  } else if (iPhone_12_Pro_Max) {

    basePadding = 70;
    cancelPadding = 35;
    collectionTopPadding = 10;
    attachmentPadding = 55;
    messageHeight = 60;
    composeHeight = 370;
  }
}


-(void)layoutBaseView {

  self.baseView = [[UIView alloc] init];
  self.baseView.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.baseView.layer.cornerRadius = 20;
  self.baseView.layer.maskedCorners = 3;
  if(@available(iOS 13.0, *)) {
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
  }
  self.baseView.clipsToBounds = true;
  [self.view addSubview:self.baseView];

  self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.baseView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
  [self.baseView.widthAnchor constraintEqualToConstant:self.view.frame.size.width].active = YES;
  [self.baseView.heightAnchor constraintEqualToConstant:self.view.frame.size.height -basePadding].active = YES;
}


-(void)layoutBanner {

  self.bannerView = [[UIView alloc] init];
  self.bannerView.clipsToBounds = true;
  [self.baseView addSubview:self.bannerView];

  self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.bannerView.topAnchor constraintEqualToAnchor:self.baseView.topAnchor].active = YES;
  [self.bannerView.leadingAnchor constraintEqualToAnchor:self.baseView.leadingAnchor].active = YES;
  [self.bannerView.trailingAnchor constraintEqualToAnchor:self.baseView.trailingAnchor].active = YES;
  [self.bannerView.heightAnchor constraintEqualToConstant:140].active = YES;


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Bug Report/bug.png"];
  self.iconImage.clipsToBounds = true;
  self.iconImage.layer.cornerRadius = 15;
  [self.bannerView addSubview:self.iconImage];

  self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
  [self.iconImage.heightAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.widthAnchor constraintEqualToConstant:90].active = YES;
  [self.iconImage.topAnchor constraintEqualToAnchor:self.bannerView.topAnchor constant:10].active = YES;
  [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.titleLabel.font = [UIFont systemFontOfSize:16];
  self.titleLabel.text = @"Bug report";
  [self.bannerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
  [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.bannerView.centerXAnchor].active = true;

}


-(void)layoutButton {

  self.cancelButton = [[UIButton alloc] init];
  [self.cancelButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
  [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
  [self.cancelButton setTitleColor:self.tintColour forState:UIControlStateNormal];
  [self.baseView addSubview:self.cancelButton];

  self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.cancelButton.heightAnchor constraintEqualToConstant:30].active = YES;
  [self.cancelButton.widthAnchor constraintEqualToConstant:100].active = YES;
  [self.cancelButton.bottomAnchor constraintEqualToAnchor:self.baseView.bottomAnchor constant:-cancelPadding].active = YES;
  [[self.cancelButton centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;


  self.reportButton = [[UIButton alloc] init];
  [self.reportButton addTarget:self action:@selector(prepareReport) forControlEvents:UIControlEventTouchUpInside];
  [self.reportButton setTitle:@"Report" forState:UIControlStateNormal];
  [self.reportButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  self.reportButton.backgroundColor = self.tintColour;
  self.reportButton.layer.cornerRadius = 10;
  [self.baseView addSubview:self.reportButton];

  self.reportButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.reportButton.heightAnchor constraintEqualToConstant:50].active = YES;
  [self.reportButton.widthAnchor constraintEqualToConstant:200].active = YES;
  [self.reportButton.bottomAnchor constraintEqualToAnchor:self.cancelButton.topAnchor constant:-10].active = YES;
  [[self.reportButton centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
}


-(void)layoutAttachment {

  self.attachmentView = [[UIView alloc] init];
  self.attachmentView.backgroundColor = UIColor.clearColor;
  [self.baseView addSubview:self.attachmentView];

  self.attachmentView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.attachmentView.heightAnchor constraintEqualToConstant:60].active = YES;
  [self.attachmentView.widthAnchor constraintEqualToConstant:250].active = YES;
  [[self.attachmentView centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
  [self.attachmentView.bottomAnchor constraintEqualToAnchor:self.reportButton.topAnchor constant:-attachmentPadding].active = YES;


  self.fileButton = [[UIButton alloc] init];
  self.fileButton.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.fileButton.layer.cornerRadius = 25;
  [self.fileButton addTarget:self action:@selector(presentDocumentVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *fileImage = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Bug Report/file.png"];
  [self.fileButton setImage:fileImage forState:UIControlStateNormal];
  self.fileButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [self.attachmentView addSubview:self.fileButton];

  self.fileButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.fileButton.heightAnchor constraintEqualToConstant:50].active = YES;
  [self.fileButton.widthAnchor constraintEqualToConstant:50].active = YES;
  [[self.fileButton centerYAnchor] constraintEqualToAnchor:self.attachmentView.centerYAnchor].active = true;
  [[self.fileButton centerXAnchor] constraintEqualToAnchor:self.attachmentView.centerXAnchor constant:-65].active = true;


  self.fileLabel = [[UILabel alloc] init];
  self.fileLabel.text = @"File";
  self.fileLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.fileLabel.textAlignment = NSTextAlignmentCenter;
  self.fileLabel.font = [UIFont systemFontOfSize:10];
  [self.attachmentView addSubview:self.fileLabel];

  self.fileLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.fileLabel centerXAnchor] constraintEqualToAnchor:self.fileButton.centerXAnchor].active = true;
  [self.fileLabel.topAnchor constraintEqualToAnchor:self.fileButton.bottomAnchor constant:5].active = YES;


  self.imageButton = [[UIButton alloc] init];
  self.imageButton.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.imageButton.layer.cornerRadius = 25;
  [self.imageButton addTarget:self action:@selector(presentPhotoVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *imageImage = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Bug Report/image.png"];
  [self.imageButton setImage:imageImage forState:UIControlStateNormal];
  self.imageButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [self.attachmentView addSubview:self.imageButton];

  self.imageButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.imageButton.heightAnchor constraintEqualToConstant:50].active = YES;
  [self.imageButton.widthAnchor constraintEqualToConstant:50].active = YES;
  [[self.imageButton centerYAnchor] constraintEqualToAnchor:self.attachmentView.centerYAnchor].active = true;
  [[self.imageButton centerXAnchor] constraintEqualToAnchor:self.attachmentView.centerXAnchor].active = true;


  self.imageLabel = [[UILabel alloc] init];
  self.imageLabel.text = @"Photo";
  self.imageLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.imageLabel.textAlignment = NSTextAlignmentCenter;
  self.imageLabel.font = [UIFont systemFontOfSize:10];
  [self.attachmentView addSubview:self.imageLabel];

  self.imageLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.imageLabel centerXAnchor] constraintEqualToAnchor:self.imageButton.centerXAnchor].active = true;
  [self.imageLabel.topAnchor constraintEqualToAnchor:self.imageButton.bottomAnchor constant:5].active = YES;


  self.urlButton = [[UIButton alloc] init];
  self.urlButton.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.urlButton.layer.cornerRadius = 25;
  [self.urlButton addTarget:self action:@selector(presentURLVC) forControlEvents:UIControlEventTouchUpInside];
  UIImage *urlImage = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Bug Report/url-link.png"];
  [self.urlButton setImage:urlImage forState:UIControlStateNormal];
  self.urlButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [self.attachmentView addSubview:self.urlButton];

  self.urlButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.urlButton.heightAnchor constraintEqualToConstant:50].active = YES;
  [self.urlButton.widthAnchor constraintEqualToConstant:50].active = YES;
  [[self.urlButton centerYAnchor] constraintEqualToAnchor:self.attachmentView.centerYAnchor].active = true;
  [[self.urlButton centerXAnchor] constraintEqualToAnchor:self.attachmentView.centerXAnchor constant:65].active = true;


  self.urlLabel = [[UILabel alloc] init];
  self.urlLabel.text = @"URL";
  self.urlLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
  self.urlLabel.textAlignment = NSTextAlignmentCenter;
  self.urlLabel.font = [UIFont systemFontOfSize:10];
  [self.attachmentView addSubview:self.urlLabel];

  self.urlLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.urlLabel centerXAnchor] constraintEqualToAnchor:self.urlButton.centerXAnchor].active = true;
  [self.urlLabel.topAnchor constraintEqualToAnchor:self.urlButton.bottomAnchor constant:5].active = YES;
}


-(void)layoutMessage {

  self.messageView = [[UIView alloc] init];
  self.messageView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.messageView.layer.cornerRadius = 15;
  self.messageView.clipsToBounds = true;
  self.messageView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
  self.messageView.layer.borderWidth = 0.5;
  [self.baseView addSubview:self.messageView];

  self.messageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.messageView.heightAnchor constraintEqualToConstant:messageHeight].active = YES;
  [self.messageView.bottomAnchor constraintEqualToAnchor:self.attachmentView.topAnchor constant:-10].active = YES;
  [self.messageView.widthAnchor constraintEqualToConstant:350].active = YES;
  [[self.messageView centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;


  self.messageLabel = [[UILabel alloc] init];
  self.messageLabel.textColor = UIColor.whiteColor;
  self.messageLabel.text = @"Describe more about a bug";
  self.messageLabel.textAlignment = NSTextAlignmentLeft;
  self.messageLabel.alpha = 0.6;
  [self.messageView addSubview:self.messageLabel];

  self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[self.messageLabel centerYAnchor] constraintEqualToAnchor:self.messageView.centerYAnchor].active = true;
  [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.messageView.leadingAnchor constant:10].active = YES;
  [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.messageView.trailingAnchor constant:10].active = YES;

  [self.messageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(composeDescription)]];
}


-(void)layoutCollectionView {

  self.categoriesArray = [[NSArray alloc] initWithObjects:@"Bug", @"Performance", @"Crashed", @"Prefs Bundle \nError", @"Respring Loop", @"Safe Mode", @"Other",  nil];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[TDReportCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.baseView addSubview:self.collectionView];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;

  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.collectionView.topAnchor constraintEqualToAnchor:self.bannerView.bottomAnchor constant:collectionTopPadding].active = YES;
  [self.collectionView.widthAnchor constraintEqualToConstant:350].active = YES;
  [[self.collectionView centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = true;
  [self.collectionView.bottomAnchor constraintEqualToAnchor:self.messageView.topAnchor constant:-20].active = YES;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.categoriesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  TDReportCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.baseView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  cell.appLabel.text = [self.categoriesArray objectAtIndex:indexPath.row];

  if (indexPath.row == categoriesSelectedIndex) {
    cell.baseView.layer.borderColor = self.tintColour.CGColor;
    cell.iconImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/checked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.iconImage.tintColor = self.tintColour;
    cell.baseView.layer.borderWidth = 1.5;
  } else {
    cell.baseView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
    cell.iconImage.image = nil;
    cell.baseView.layer.borderWidth = 0.6;
  }

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return CGSizeMake(170, 90);

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  [[TDUtilities sharedInstance] haptic:0];
  categoriesSelectedIndex = indexPath.row;
  [self.collectionView reloadData];

}


-(void)layoutCompose {

  self.composeView = [[UIView alloc] initWithFrame:self.view.bounds];
  self.composeView.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.composeView.alpha = 0;
  [self.view addSubview:self.composeView];


  self.textView = [[UITextView alloc] init];
  self.textView.clipsToBounds = YES;
  self.textView.contentInset = UIEdgeInsetsZero;
  self.textView.delegate = self;
  self.textView.editable = YES;
  self.textView.font = [UIFont systemFontOfSize:18];
  self.textView.backgroundColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  self.textView.scrollEnabled = YES;
  self.textView.textAlignment = NSTextAlignmentLeft;
  self.textView.textColor = UIColor.whiteColor;;
  self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
  self.textView.layer.cornerRadius = 15;
  if(@available(iOS 13.0, *)) {
    self.textView.layer.cornerCurve = kCACornerCurveContinuous;
  }
          self.textView.layer.borderColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: 0.5].CGColor;
        self.textView.layer.borderWidth = 0.5;
  [self.composeView addSubview:self.textView];

  self.textView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.textView.heightAnchor constraintEqualToConstant:composeHeight].active = YES;
  [self.textView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50].active = YES;
  [self.textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
  [self.textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
}


-(void)composeDescription {

  self.composeView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
  self.composeView.alpha = 1.0;

  [UIView animateWithDuration:0.4/1.5 animations:^{
    self.composeView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
  }];

  [self.textView becomeFirstResponder];

}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

  UIToolbar *textToolbar = [[UIToolbar alloc] init];
  [textToolbar sizeToFit];
  textToolbar.barStyle = UIBarStyleDefault;
  textToolbar.tintColor = self.tintColour;
  textToolbar.items = [self textToolBarButtons];
  self.textView.inputAccessoryView = textToolbar;

  return YES;

}


-(NSArray *)textToolBarButtons {

  NSMutableArray *textButtons = [[NSMutableArray alloc] init];

  [textButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];

  [textButtons addObject:[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)]];

  return [textButtons copy];

}


-(void)dismissKeyboard {

  [[TDUtilities sharedInstance] haptic:0];

  [UIView animateWithDuration:0.4/1.5 animations:^{
    self.composeView.alpha = 0;
  }];

  [self.textView resignFirstResponder];
  if (self.textView.text && self.textView.text.length > 0) {
    NSString *composeString = self.textView.text;
    self.messageLabel.text = composeString;
  } else {
    self.messageLabel.text = @"Describe more about a bug";
  }
}


-(void)presentDocumentVC {

  [[TDUtilities sharedInstance] haptic:0];

  UIDocumentPickerViewController* documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
  documentPicker.delegate = self;
  documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
  [self presentViewController:documentPicker animated:YES completion:nil];

}


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
  if (controller.documentPickerMode == UIDocumentPickerModeImport) {

    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
    NSError *error = nil;
    [coordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
      documentData = [NSData dataWithContentsOfURL:newURL];
      NSLog(@"%@", documentData);
    }];
  }
}


-(void)presentPhotoVC {

  [[TDUtilities sharedInstance] haptic:0];

  pickerView = [[UIImagePickerController alloc] init];
  pickerView.allowsEditing = YES;
  pickerView.delegate = self;
  [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  [self presentViewController:pickerView animated:YES completion:nil];

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

  [pickerView dismissViewControllerAnimated:YES completion:nil];
  UIImage *img = [info valueForKey:UIImagePickerControllerEditedImage];
  imageData = UIImageJPEGRepresentation(img, 1.0);

}


-(void)presentURLVC {

  [[TDUtilities sharedInstance] haptic:0];

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"URL" message:@"Paste the URL for the crash report from pastebin, ghostbin or any pasteboard website." preferredStyle:UIAlertControllerStyleAlert];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"URL";
  }];

  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    urlString = alertController.textFields.firstObject.text;
    NSLog(@"url:%@", urlString);

  }];
  [alertController addAction:confirmAction];

  [self presentViewController:alertController animated:YES completion:nil];

}


-(void)prepareReport {

  [[TDUtilities sharedInstance] haptic:0];

  if ([MFMailComposeViewController canSendMail]) {

    if (self.textView.text && self.textView.text.length > 0) {

      MFMailComposeViewController * composeEmailVC = [MFMailComposeViewController new];
      composeEmailVC.mailComposeDelegate = self;

      NSString *subjectString = [self.categoriesArray objectAtIndex:categoriesSelectedIndex];
      [composeEmailVC setSubject:subjectString];

      NSString *composeString = self.textView.text;
      if (urlString != nil) {
        messageString = [NSString stringWithFormat:@"(Description)\n%@ \n\n(URL) \n%@", composeString, urlString];
      } else {
        messageString = [NSString stringWithFormat:@"Description:\n%@", composeString];
      }
      [composeEmailVC setMessageBody:messageString isHTML:NO];

      if (documentData != nil) {
        [composeEmailVC addAttachmentData:documentData mimeType:@"text/plain" fileName:@"crash-report.txt"];
      }

      if (imageData != nil) {
        [composeEmailVC addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"ScreenShot"];
      }

      NSString *emailAddressString = @"support@titand3v.com";
      [composeEmailVC setToRecipients:[NSArray arrayWithObjects:emailAddressString, nil]];

      [self presentViewController:composeEmailVC animated:YES completion:nil];


    } else {

      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"The description is blank, you will need to describe more about the bug you are experiencing before you can report the bug." preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

      }];
      [alertController addAction:okAction];
      alertController.view.tintColor = self.tintColour;
      [self presentViewController:alertController animated:YES completion:nil];

    }

  } else {

    NSLog(@"Mail services are not available or configure to your device");
  }

}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {

  switch (result) {
    case MFMailComposeResultCancelled:
    NSLog(@"Mail cancelled");

    break;

    case MFMailComposeResultSaved:
    NSLog(@"Mail saved");

    break;

    case MFMailComposeResultSent:
    NSLog(@"Mail sent");
    [self performSelector:@selector(showConfirmation) withObject:nil afterDelay:1.0];

    break;

    case MFMailComposeResultFailed:
    NSLog(@"Mail sent failure: %@",error.description);

    break;
  }

  [controller dismissViewControllerAnimated:true completion:nil];

}


-(void)showConfirmation {

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sent!" message:@"Thank you for report the bug, the team will be in touch in the next 48 hours." preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [self dismissVC];
  }];
  [alertController addAction:okAction];
  alertController.view.tintColor = self.tintColour;
  [self presentViewController:alertController animated:YES completion:nil];

}


-(void)dismissVC {
  categoriesSelectedIndex = 0;
  //    documentData = nil;
  //    imageData = nil;
  urlString = nil;
  [self.collectionView reloadData];
  [[TDUtilities sharedInstance] haptic:0];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
