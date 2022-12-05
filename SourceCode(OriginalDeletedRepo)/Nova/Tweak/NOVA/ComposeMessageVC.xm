#import "ComposeMessageVC.h"

@implementation ComposeMessageVC

- (void)viewDidLoad {
  [super viewDidLoad];

  loadPrefs();

  self.view.backgroundColor = [UIColor backgroundColour];

  if (toggleWallpaper) {
      UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
      backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
      backgroundImage.image = [UIImage imageWithData:wallpaperImage];
      [self.view addSubview:backgroundImage];
  }

  self.doneButton = [[UIButton alloc] init];
  [self.doneButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
  self.doneButton.backgroundColor = [UIColor accentColour];
  self.doneButton.layer.cornerRadius = 20;
  self.doneButton.clipsToBounds = true;
  [self.view addSubview:self.doneButton];

  [self.doneButton top:self.view.topAnchor padding:10];
  [self.doneButton trailing:self.view.trailingAnchor padding:-10];
  [self.doneButton size:CGSizeMake(60, 40)];


  self.doneImage = [[UIImageView alloc] init];
  self.doneImage.image = [[UIImage systemImageNamed:@"checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  if (toggleCustomColour) {
    self.doneImage.tintColor = [UIColor iconTintColour];
  } else {
    self.doneImage.tintColor = UIColor.whiteColor;
  }
  [self.doneButton addSubview:self.doneImage];

  [self.doneImage size:CGSizeMake(20, 20)];
  [self.doneImage x:self.doneButton.centerXAnchor y:self.doneButton.centerYAnchor];


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentLeft;
  self.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
  self.titleLabel.textColor = [UIColor fontColour];
  self.titleLabel.text = @"Compose Message";
  [self.view addSubview:self.titleLabel];

  [self.titleLabel y:self.doneButton.centerYAnchor];
  [self.titleLabel leading:self.view.leadingAnchor padding:15];

  self.defaultChatHeight = 80;

  if (iPhone_6_8) {
    self.kbHeight = 260;
  } else if (iPhone_6_8_Plus) {
    self.kbHeight = 266;
  } else if (iPhone_X_XS_11Pro) {
    self.kbHeight = 336;
  } else if (iPhone_XR_XS_11Pro) {
    self.kbHeight = 346;
  } else if (iPhone_12_mini) {
    self.kbHeight = 336;
  } else if (iPhone_12_Pro) {
    self.kbHeight = 336;
  } else if (iPhone_12_Pro_Max) {
    self.kbHeight = 346;
  }

  [self layoutTableView];
  [self layoutToolbar];
  [self performSelector:@selector(refreshSenderChatHeight) withObject:nil afterDelay:0.1];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


  self.imageArray = [NSMutableArray array];

  self.toolbarColour = [UIColor toolbarColour];

  if (!toggleCustomColour) {

    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      self.photoButton.backgroundColor = [UIColor colorWithRed: 0.15 green: 0.15 blue: 0.16 alpha: 1.00];
    } else {
      self.photoButton.backgroundColor = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.92 alpha: 1.00];
    }

  } else {
    self.photoButton.backgroundColor = [UIColor photoButtonColour];
  }

if (showComposeTips) {
[self performSelector:@selector(showTipsAlert) withObject:nil afterDelay:1.0];
}

}


-(void)showTipsAlert {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:@"1) Tap on your chat bubble to start typing a message \n\n2) Tap anywhere outside your chat bubble to dismiss the keyboard \n\n3) Press photo button to add images attachment, you can add up to 5 images \n\n4) You can change your chat name and avatar image from the settings." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *dismissButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/DisableTipsAlert" object:nil userInfo:nil deliverImmediately:YES];
    }];

    [alert addAction:dismissButton];
    [self presentViewController:alert animated:YES completion:nil];

}


-(void)refreshSenderChatHeight {

  [self.tableView beginUpdates];
  [UIView animateWithDuration:.3 animations:^(void) {
    CGFloat paddingForTextView = 60;
    self.defaultChatHeight = self.senderTextView.contentSize.height + paddingForTextView;
  }];
  [self.tableView endUpdates];

  if (self.senderTextView.text && self.senderTextView.text.length > 0) {
    self.placeholderLabel.alpha = 0;
  } else {
    self.placeholderLabel.alpha = 0.7;
  }
}



-(void)layoutTableView {

  self.tableView = [[UITableView alloc] init];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.editing = NO;
  self.tableView.backgroundColor = UIColor.clearColor;
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:self.tableView];

  self.tableView.dataSource = self;
  self.tableView.delegate = self;

  [self.tableView top:self.doneButton.bottomAnchor padding:10];
  [self.tableView leading:self.view.leadingAnchor padding:0];
  [self.tableView trailing:self.view.trailingAnchor padding:0];
  [self.tableView bottom:self.view.bottomAnchor padding:-70];


  UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKB)];
  [self.tableView addGestureRecognizer:gestureRecognizer];

}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

  UIView *selectionView = [UIView new];
  selectionView.backgroundColor = UIColor.clearColor;
  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];


  if (indexPath.row == 0) {

    RecipientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[RecipientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.backgroundColor = UIColor.clearColor;
    cell.avatarImage.image = self.recipientAvatarImage;
    cell.nameLabel.text = self.recipientNameString;

    return cell;

  } else  {

    SenderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
      cell = [[SenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.backgroundColor = UIColor.clearColor;


    self.senderTextView = [[UITextView alloc] init];
    self.senderTextView.delegate = self;
    self.senderTextView.backgroundColor = [UIColor bubbleColour];
    self.senderTextView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0);
    self.senderTextView.font = [UIFont systemFontOfSize:18];
    self.senderTextView.layer.cornerRadius = 20;
    self.senderTextView.layer.maskedCorners = 13;
    self.senderTextView.text = self.senderTextString;
    self.senderTextView.textColor = [UIColor bubbleFontColour];
    [cell.contentView addSubview:self.senderTextView];

    [self.senderTextView width:250];
    [self.senderTextView trailing:cell.contentView.trailingAnchor padding:-20];
    [self.senderTextView top:cell.avatarImage.bottomAnchor padding:10];
    [self.senderTextView bottom:cell.contentView.bottomAnchor padding:0];


    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:18];
    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.textColor = [UIColor bubbleFontColour];
    self.placeholderLabel.text = @"Type something...";
    self.placeholderLabel.layer.zPosition = 10;
    self.placeholderLabel.alpha = 0.7;
    [self.senderTextView addSubview:self.placeholderLabel];

    [self.placeholderLabel y:self.senderTextView.centerYAnchor];
    [self.placeholderLabel leading:self.senderTextView.leadingAnchor padding:7];

    return cell;

  }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return 170;
  } else {
    return self.defaultChatHeight;
  }
}


- (void)textViewDidChange:(UITextView *)textView {

  [self.tableView beginUpdates];
  [UIView animateWithDuration:.3 animations:^(void) {
    CGFloat paddingForTextView = 60;
    self.defaultChatHeight = textView.contentSize.height + paddingForTextView;
  }];
  [self.tableView endUpdates];


  [UIView animateWithDuration:0.3 animations:^ {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, self.kbHeight , 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
  }];


  if (textView.text && textView.text.length > 0) {
    self.placeholderLabel.alpha = 0;
  } else {
    self.placeholderLabel.alpha = 0.7;
  }

}


-(void)layoutToolbar {

  self.toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 65, self.view.frame.size.width, 65)];
  if (self.didAddedAttachmentImages) {
    self.toolbarView.backgroundColor = self.toolbarColour;
  } else {
    self.toolbarView.backgroundColor = UIColor.clearColor;
  }
  self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  [self.view addSubview:self.toolbarView];


  self.photoButton = [[UIButton alloc] init];
  [self.photoButton addTarget:self action:@selector(presentImagePicker) forControlEvents:UIControlEventTouchUpInside];
  self.photoButton.layer.cornerRadius = 22.5;
  [self.toolbarView addSubview:self.photoButton];

  [self.photoButton size:CGSizeMake(45, 45)];
  [self.photoButton y:self.toolbarView.centerYAnchor];
  [self.photoButton leading:self.toolbarView.leadingAnchor padding:13];


  self.photoImage = [[UIImageView alloc] init];
  self.photoImage.image = [[UIImage systemImageNamed:@"photo.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.photoImage.tintColor = [UIColor iconTintColour];
  self.photoImage.contentMode = UIViewContentModeScaleAspectFit;
  [self.photoButton addSubview:self.photoImage];

  [self.photoImage size:CGSizeMake(25, 25)];
  [self.photoImage x:self.photoButton.centerXAnchor y:self.photoButton.centerYAnchor];


  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.toolbarView addSubview:self.collectionView];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;

  [self.collectionView top:self.toolbarView.topAnchor padding:5];
  [self.collectionView leading:self.photoButton.trailingAnchor padding:10];
  [self.collectionView trailing:self.toolbarView.trailingAnchor padding:-5];
  [self.collectionView bottom:self.toolbarView.bottomAnchor padding:-5];

}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.imageArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.photoImages.image = [self.imageArray objectAtIndex:indexPath.row];
  cell.countLabel.text = [NSString stringWithFormat:@"%li", indexPath.row +1];

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(50, 50);
}


-(void)keyboardWillShow:(NSNotification *)note {

  CGRect keyboardBounds;
  [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
  NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];

  keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];

  CGRect containerFrame = self.toolbarView.frame;
  containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:[duration doubleValue]];
   [UIView setAnimationCurve:[curve intValue]];

  self.toolbarView.frame = containerFrame;
  [UIView commitAnimations];


  [UIView animateWithDuration:0.3 animations:^ {

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, self.kbHeight , 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

  }];

}


-(void)keyboardWillHide:(NSNotification *)note {

  NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
   NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];

  CGRect containerFrame = self.toolbarView.frame;
  containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;

  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:[duration doubleValue]];
   [UIView setAnimationCurve:[curve intValue]];

  self.toolbarView.frame = containerFrame;
  [UIView commitAnimations];


  [UIView animateWithDuration:.3 animations:^(void) {
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
  }];

}


-(void)presentImagePicker {

  [self invokeHapticFeedback];

  [self.senderTextView resignFirstResponder];

  PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
  config.selectionLimit = 10;
  config.filter = [PHPickerFilter imagesFilter];

  PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
  pickerViewController.delegate = self;
  [self presentViewController:pickerViewController animated:YES completion:nil];

}


-(void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {

  self.didAddedAttachmentImages = YES;
  self.toolbarView.backgroundColor = self.toolbarColour;
  [self.imageArray removeAllObjects];

  [picker dismissViewControllerAnimated:YES completion:nil];

  for (PHPickerResult *result in results) {

    [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {

      if ([object isKindOfClass:[UIImage class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{

          [self.imageArray addObject:object];
          [self.collectionView reloadData];

          NSLog(@"%@", self.imageArray);

        });
      }
    }];

  }
}


-(void)presentKB {
  [self.senderTextView becomeFirstResponder];
}

-(void)dismissKB {
  [self.senderTextView resignFirstResponder];
}


-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}


-(void)dismissVC {

  [self invokeHapticFeedback];
  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillDisappear:(BOOL)animated {
  [self.messageDataDelegate passDataToCreateVC:self.imageArray message:self.senderTextView.text includedAttachment:self.didAddedAttachmentImages];
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {

  if (!toggleCustomColour) {

    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      self.photoButton.backgroundColor = [UIColor colorWithRed: 0.15 green: 0.15 blue: 0.16 alpha: 1.00];
    } else {
      self.photoButton.backgroundColor = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.92 alpha: 1.00];
    }

  } else {
    self.photoButton.backgroundColor = [UIColor photoButtonColour];
  }

}


-(void)invokeHapticFeedback {
    if (toggleHaptic) {
    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }
  }
}

@end
