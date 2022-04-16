#import "EditorViewController.h"

@implementation EditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configDeviceSize];
    [self layoutMenuBar];
    [self layoutIconEditor];
    [self layoutToolView];
    [self layoutCollectionView];
    [self layoutTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRefreshAppDetailsNotification:) name:@"RefreshAppDetailsNotification" object:nil];
    
    showTutorial = [[AppManager sharedInstance] boolForKey:@"showTutorial" defaultValue:YES];
    
    if (showTutorial) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self presentTutorialVC];
        });
    }
}


- (void)receiveRefreshAppDetailsNotification:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"RefreshAppDetailsNotification"]) {
        
        loadPrefs();
        self.appLabel.text = appName;
        
    }
    
}


-(void)configDeviceSize {
    
    if (iPhone_6_8) {
        iconSize = 230;
    } else if (iPhone_6_8_Plus) {
        iconSize = 250;
    } else if (iPhone_X_XS_11Pro) {
        iconSize = 275;
    } else if (iPhone_XR_XS_11Pro) {
        iconSize = 275;
    } else if (iPhone_12_Pro) {
        iconSize = 275;
    } else if (iPhone_12_mini) {
        iconSize = 230;
    } else if (iPhone_12_Pro_Max) {
        iconSize = 320;
    }
    
}


-(void)layoutMenuBar {
    
    loadPrefs();
    
    self.moreButton = [[UIButton alloc] init];
    UIImage *moreImage = [[UIImage systemImageNamed:@"rectangle.grid.1x2.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.moreButton setImage:moreImage forState:UIControlStateNormal];
    self.moreButton.tintColor = UIColor.whiteColor;
    self.moreButton.backgroundColor = [UIColor colorNamed:@"Accent"];
    self.moreButton.layer.cornerRadius = 20;
    self.moreButton.menu = [self toolMenuManagement];
    self.moreButton.showsMenuAsPrimaryAction = true;
    [self.topbarView addSubview:self.moreButton];
    
    [self.moreButton size:CGSizeMake(60, 40)];
    [self.moreButton leading:self.topbarView.leadingAnchor padding:15];
    [self.moreButton y:self.topbarView.centerYAnchor];
    
    
    self.saveButton = [[UIButton alloc] init];
    [self.saveButton addTarget:self action:@selector(saveIconTheme) forControlEvents:UIControlEventTouchUpInside];
    UIImage *saveImage = [[UIImage systemImageNamed:@"paperplane.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.saveButton setImage:saveImage forState:UIControlStateNormal];
    self.saveButton.tintColor = UIColor.whiteColor;
    self.saveButton.backgroundColor = [UIColor colorNamed:@"Accent"];
    self.saveButton.layer.cornerRadius = 20;
    [self.topbarView addSubview:self.saveButton];
    
    [self.saveButton size:CGSizeMake(60, 40)];
    [self.saveButton trailing:self.topbarView.trailingAnchor padding:-15];
    [self.saveButton y:self.topbarView.centerYAnchor];
    
    
    self.appLabel = [[UILabel alloc] init];
    self.appLabel.textAlignment = NSTextAlignmentCenter;
    self.appLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    self.appLabel.textColor = UIColor.labelColor;
    self.appLabel.text = appName;
    [self.topbarView addSubview:self.appLabel];
    
    [self.appLabel x:self.topbarView.centerXAnchor];
    [self.appLabel y:self.topbarView.centerYAnchor];
    [self.appLabel leading:self.moreButton.trailingAnchor padding:15];
    [self.appLabel trailing:self.saveButton.leadingAnchor padding:-15];
    
}


-(void)layoutIconEditor {
    
    self.iconView = [[UIView alloc] init];
    self.iconView.backgroundColor = [UIColor colorNamed:@"Containers"];
    self.iconView.layer.cornerRadius = 25;
    self.iconView.layer.cornerCurve = kCACornerCurveContinuous;
    self.iconView.clipsToBounds = true;
    [self.view addSubview:self.iconView];
    
    [self.iconView size:CGSizeMake(iconSize, iconSize)];
    [self.iconView x:self.view.centerXAnchor];
    [self.iconView top:self.topbarView.bottomAnchor padding:20];
    
    
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconView addSubview:self.backgroundImage];
    [self.backgroundImage fill];
    //self.backgroundImage.image = [UIImage imageNamed:@"preview"];
    
    
    self.iconContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    [self.iconView addSubview:self.iconContainerView];
    
    
    self.gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    self.gradientView.alpha = 0;
    [self.iconContainerView addSubview:self.gradientView];
    
    
    self.primraryColour = UIColor.whiteColor;
    self.secondaryColour = UIColor.systemTealColor;
    
    gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    
    
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    //    self.iconImage.image = [[UIImage imageNamed:@"paradise-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.iconImage.image = [UIImage imageNamed:@"paradise-icon"];
    self.iconImage.center = self.iconContainerView.center;
    self.iconImage.tintColor = [UIColor colorNamed:@"Accent"];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconView addSubview:self.iconImage];
    [self addMovementGesturesToView:self.iconImage];
}


-(void)layoutToolView {
    
    self.toolsView = [[UIView alloc] init];
    self.toolsView.backgroundColor = [UIColor colorNamed:@"Containers"];
    self.toolsView.layer.cornerRadius = 25;
    self.toolsView.layer.cornerCurve = kCACornerCurveContinuous;
    self.toolsView.layer.maskedCorners = 3;
    self.toolsView.clipsToBounds = true;
    [self.view addSubview:self.toolsView];
    
    [self.toolsView top:self.iconView.bottomAnchor padding:20];
    [self.toolsView leading:self.view.leadingAnchor padding:0];
    [self.toolsView trailing:self.view.trailingAnchor padding:0];
    [self.toolsView bottom:self.view.bottomAnchor padding:0];
    
    
    self.resetTransformButton = [[UIButton alloc] init];
    [self.resetTransformButton addTarget:self action:@selector(resetIconTransformPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImage *resetImage = [[UIImage imageNamed:@"reset"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.resetTransformButton setImage:resetImage forState:UIControlStateNormal];
    self.resetTransformButton.tintColor = UIColor.systemRedColor;
    self.resetTransformButton.alpha = 0;
    [self.view addSubview:self.resetTransformButton];
    
    [self.resetTransformButton size:CGSizeMake(25, 25)];
    [self.resetTransformButton trailing:self.view.trailingAnchor padding:-10];
    [self.resetTransformButton bottom:self.toolsView.topAnchor padding:-10];
    
    
    self.segmentView = [[UIView alloc] init];
    self.segmentView.backgroundColor = [UIColor colorNamed:@"Main Background"];
    self.segmentView.layer.cornerRadius = 20;
    self.segmentView.clipsToBounds = true;
    [self.toolsView addSubview:self.segmentView];
    
    [self.segmentView size:CGSizeMake(254, 40)];
    [self.segmentView top:self.toolsView.topAnchor padding:10];
    [self.segmentView x:self.toolsView.centerXAnchor];
    
    
    self.segmentControl = [[ParadiseSegmentControl alloc] initWithStringsArray:@[@"Editor", @"Icon Tools"]];
    self.segmentControl.frame = CGRectMake(2, 2, 250, 36);
    self.segmentControl.cornerRadius = 18;
    self.segmentControl.backgroundColor = UIColor.clearColor;
    self.segmentControl.labelTextColorInsideSlider = UIColor.labelColor;
    self.segmentControl.labelTextColorOutsideSlider = UIColor.labelColor;
    self.segmentControl.sliderColor = [UIColor colorNamed:@"Containers"];
    [self.segmentView addSubview:self.segmentControl];
    
    
    [self.segmentControl setPressedHandler:^(NSUInteger index) {
        
        if (index == 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.collectionView.alpha = 1;
                self.tableView.alpha = 0;
            }];
            
        } else if (index == 1) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.collectionView.alpha = 0;
                self.tableView.alpha = 1;
            }];
        }
        
    }];
}


-(void)layoutCollectionView  {
    
    self.editorArray = [[NSArray alloc] initWithObjects:@"Icons", @"Icon Image", @"Icon Colour", @"Background Image", @"Background Colour", @"BG Top Gradient", @"BG Bottom Gradient", nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[EditorCell class] forCellWithReuseIdentifier:@"Cell1"];
    [self.collectionView registerClass:[ColourCell class] forCellWithReuseIdentifier:@"Cell2"];
    [self.toolsView addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView top:self.segmentView.bottomAnchor padding:10];
    [self.collectionView leading:self.toolsView.leadingAnchor padding:0];
    [self.collectionView trailing:self.toolsView.trailingAnchor padding:0];
    [self.collectionView bottom:self.toolsView.bottomAnchor padding:-10];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.editorArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        EditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.iconImage.image = [UIImage imageNamed:@"imagepicker-icon"];
        cell.titleLabel.text = [self.editorArray objectAtIndex:indexPath.row];
        cell.previewImage.contentMode = UIViewContentModeScaleAspectFit;
        
        if (tempImage != nil) {
            cell.previewImage.image = tempImage;
            cell.previewImage.tintColor = [UIColor colorNamed:@"Accent"];
        } else {
            cell.previewImage.image = [UIImage imageNamed:@"paradise-icon"];
        }
        
        return cell;
        
    } else if (indexPath.row == 1) {
        
        EditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.iconImage.image = [UIImage imageNamed:@"imagepicker-icon"];
        cell.titleLabel.text = [self.editorArray objectAtIndex:indexPath.row];
        cell.previewImage.contentMode = UIViewContentModeScaleAspectFill;
        cell.previewImage.image = [UIImage imageNamed:@"default-preview"];
        
        return cell;
        
    } else if (indexPath.row == 3) {
        
        EditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.iconImage.image = [UIImage imageNamed:@"imagepicker-icon"];
        cell.titleLabel.text = [self.editorArray objectAtIndex:indexPath.row];
        cell.previewImage.contentMode = UIViewContentModeScaleAspectFill;
        cell.previewImage.image = [UIImage imageNamed:@"default-preview"];
        
        return cell;
        
    } else {
        
        ColourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.iconImage.image = [UIImage imageNamed:@"colourpicker-icon"];
        cell.titleLabel.text = [self.editorArray objectAtIndex:indexPath.row];
        
        if (indexPath.row == 2) {
            cell.colourView.backgroundColor = [UIColor colorNamed:@"Accent"];
        } else if (indexPath.row == 4) {
            cell.colourView.backgroundColor = [UIColor colorNamed:@"Containers"];
        } else if (indexPath.row == 5) {
            cell.colourView.backgroundColor = self.primraryColour;
        } else if (indexPath.row == 6) {
            cell.colourView.backgroundColor = self.secondaryColour;
        }
        
        return cell;
        
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width /2 -15;
    return CGSizeMake(width, 110);
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        IconsViewController *iconVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IconsViewController"];
        iconVC.iconDelegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:iconVC];
        [self presentViewController:navController animated:YES completion:nil];
        
    } else if (indexPath.row == 1) {
        
        [self iconImagePicker];
        
    } else if (indexPath.row == 2) {
        
        colourPickerIndex = 0;
        [self presentColorPickerVC];
        
    } else if (indexPath.row == 3) {
        
        [self backgroundImagePicker];
        
    } else if (indexPath.row == 4) {
        
        self.gradientView.alpha = 0;
        self.backgroundImage.image = nil;
        colourPickerIndex = 1;
        [self presentColorPickerVC];
        
    } else if (indexPath.row == 5) {
        
        colourPickerIndex = 2;
        self.gradientView.alpha = 1;
        self.backgroundImage.image = nil;
        [self presentColorPickerVC];
        
    } else if (indexPath.row == 6) {
        
        self.gradientView.alpha = 1;
        self.backgroundImage.image = nil;
        colourPickerIndex = 3;
        [self presentColorPickerVC];
    }
    
}


-(void)layoutTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.alpha = 0;
    [self.toolsView addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView top:self.segmentView.bottomAnchor padding:10];
    [self.tableView leading:self.toolsView.leadingAnchor padding:10];
    [self.tableView trailing:self.toolsView.trailingAnchor padding:-10];
    [self.tableView bottom:self.toolsView.bottomAnchor padding:-10];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[ToolsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"Resize", @"Rotate", nil];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"resize", @"rotate", nil];
    cell.toolsDelegate = self;
    cell.iconImage.image = [[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    cell.slider.tag = indexPath.row;
    [cell.slider addTarget:self action:@selector(iconToolsSliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (indexPath.row == 0) {
        cell.slider.minimumValue = 20;
        cell.slider.maximumValue = 350;
        cell.slider.continuous = YES;
        cell.slider.value = 130;
    } else if (indexPath.row == 1) {
        cell.slider.continuous = YES;
        cell.slider.value = 0;
    }
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


-(void)iconToolsSliderChanged:(UISlider*)sender {
    
    ToolsCell *cell = (ToolsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 0) {
        [self.iconImage setFrame:CGRectMake(0, 0, cell.slider.value, cell.slider.value)];
        self.iconImage.center = self.iconContainerView.center;
    } else if (indexPath.row == 1) {
        self.iconImage.transform = CGAffineTransformMakeRotation(cell.slider.value * 2*M_PI);
    }
    
}


- (void)resetToolsForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ToolsCell *cells = (ToolsCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        [self.iconImage setFrame:CGRectMake(0, 0, 130, 130)];
        self.iconImage.center = self.iconContainerView.center;
        cells.slider.value = 130;
        
    } else if (indexPath.row == 1) {
        
        self.iconImage.transform = CGAffineTransformIdentity;
        cells.slider.value = 0;
    }
    
}


- (void)addMovementGesturesToView:(UIView *)view {
    view.userInteractionEnabled = YES;
    
    if (!panGesture) {
        panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        panGesture.delegate = self;
        panGesture.cancelsTouchesInView = NO;
        [view addGestureRecognizer:panGesture];
        
        pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
        pinchGesture.delegate = self;
        pinchGesture.cancelsTouchesInView = NO;
        [view addGestureRecognizer:pinchGesture];
        
        rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
        rotateGesture.delegate = self;
        rotateGesture.cancelsTouchesInView = NO;
        [view addGestureRecognizer:rotateGesture];
    }
    
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:panGesture.view.superview];
    
    if (UIGestureRecognizerStateBegan == panGesture.state || UIGestureRecognizerStateChanged == panGesture.state) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.resetTransformButton.alpha = 1;
        }];
        
        panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x, panGesture.view.center.y + translation.y);
        
        [panGesture setTranslation:CGPointZero inView:self.view];
    }
    
}


- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinchGesture {
    
    if (UIGestureRecognizerStateBegan == pinchGesture.state || UIGestureRecognizerStateChanged == pinchGesture.state) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.resetTransformButton.alpha = 1;
        }];
        
        float currentScale = [[pinchGesture.view.layer valueForKeyPath:@"transform.scale.x"] floatValue];
        
        float minScale = 0.5;
        float maxScale = 4.0;
        float zoomSpeed = .5;
        
        float deltaScale = pinchGesture.scale;
        
        deltaScale = ((deltaScale - 1) * zoomSpeed) + 1;
        
        deltaScale = MIN(deltaScale, maxScale / currentScale);
        deltaScale = MAX(deltaScale, minScale / currentScale);
        
        CGAffineTransform zoomTransform = CGAffineTransformScale(pinchGesture.view.transform, deltaScale, deltaScale);
        pinchGesture.view.transform = zoomTransform;
        
        pinchGesture.scale = 1;
    }
}


- (void)handleRotateGesture:(UIRotationGestureRecognizer *)rotateGesture {
    if (UIGestureRecognizerStateBegan == rotateGesture.state || UIGestureRecognizerStateChanged == rotateGesture.state) {
        [UIView animateWithDuration:0.3 animations:^{
            self.resetTransformButton.alpha = 1;
        }];
        rotateGesture.view.transform = CGAffineTransformRotate(rotateGesture.view.transform, rotateGesture.rotation);
        rotateGesture.rotation = 0;
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


-(void)backgroundImagePicker {
    
    self.gradientView.alpha = 0;
    
    self.backgroundImagePickerController = [[UIImagePickerController alloc] init];
    self.backgroundImagePickerController.delegate = self;
    self.backgroundImagePickerController.allowsEditing = false;
    self.backgroundImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.backgroundImagePickerController animated:YES completion:nil];
    
}


-(void)iconImagePicker {
    
    self.iconImagePickerController = [[UIImagePickerController alloc] init];
    self.iconImagePickerController.delegate = self;
    self.iconImagePickerController.allowsEditing = false;
    self.iconImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.iconImagePickerController animated:YES completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    if (picker == self.backgroundImagePickerController) {
        
        self.backgroundImage.image = info[UIImagePickerControllerOriginalImage];
        NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:3 inSection:0];
        EditorCell *cell = (EditorCell *)[self.collectionView cellForItemAtIndexPath:_indexPath];
        cell.previewImage.image = info[UIImagePickerControllerOriginalImage];
        
    } else if (picker == self.iconImagePickerController) {
        self.iconImage.image = info[UIImagePickerControllerOriginalImage];
        tempImage = info[UIImagePickerControllerOriginalImage];
        
        NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        EditorCell *cell = (EditorCell *)[self.collectionView cellForItemAtIndexPath:_indexPath];
        cell.previewImage.image = info[UIImagePickerControllerOriginalImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)presentColorPickerVC {
    
    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    if (colourPickerIndex == 0) {
        colourPickerVC.selectedColor = self.iconImage.tintColor;
    } else if (colourPickerIndex == 1) {
        colourPickerVC.selectedColor = self.iconView.backgroundColor;
    } else if (colourPickerIndex == 2) {
        colourPickerVC.selectedColor = self.primraryColour;
    } else if (colourPickerIndex == 3) {
        colourPickerVC.selectedColor = self.secondaryColour;
    }
    [self presentViewController:colourPickerVC animated:YES completion:nil];
}


- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{
    
    UIColor *cpSelectedColour = viewController.selectedColor;
    
    if (colourPickerIndex == 0) {
        self.iconImage.tintColor = cpSelectedColour;
        //self.backgroundColourPreview.backgroundColor = cpSelectedColour;
    } else if (colourPickerIndex == 1) {
        self.iconView.backgroundColor = cpSelectedColour;
        //self.iconColourView.backgroundColor = cpSelectedColour;
    } else if (colourPickerIndex == 2) {
        self.primraryColour = cpSelectedColour;
        //self.primraryColourPreview.backgroundColor = cpSelectedColour;
        gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
    } else if (colourPickerIndex == 3) {
        self.secondaryColour = cpSelectedColour;
        //self.secondaryColourPreview.backgroundColor = cpSelectedColour;
        gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
    }
    
}


- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{
    
    UIColor *cpSelectedColour = viewController.selectedColor;
    
    if (colourPickerIndex == 0) {
        
        self.iconImage.tintColor = cpSelectedColour;
        //self.backgroundColourPreview.backgroundColor = cpSelectedColour;
        NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
        EditorCell *cell1 = (EditorCell *)[self.collectionView cellForItemAtIndexPath:_indexPath1];
        cell1.previewImage.tintColor = cpSelectedColour;
        NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];
        ColourCell *cell2 = (ColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
        cell2.colourView.backgroundColor = cpSelectedColour;
        tempColour = cpSelectedColour;
        
    } else if (colourPickerIndex == 1) {
        
        self.iconView.backgroundColor = cpSelectedColour;
        NSIndexPath *_indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
        EditorCell *cell1 = (EditorCell *)[self.collectionView cellForItemAtIndexPath:_indexPath1];
        cell1.previewImage.tintColor = cpSelectedColour;
        NSIndexPath *_indexPath2 = [NSIndexPath indexPathForItem:4 inSection:0];
        ColourCell *cell2 = (ColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath2];
        cell2.colourView.backgroundColor = cpSelectedColour;
        
    } else if (colourPickerIndex == 2) {
        
        self.primraryColour = cpSelectedColour;
        gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
        
        self.iconView.backgroundColor = cpSelectedColour;
        NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:5 inSection:0];
        ColourCell *cell = (ColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath];
        cell.colourView.backgroundColor = cpSelectedColour;
        
    } else if (colourPickerIndex == 3) {
        
        self.secondaryColour = cpSelectedColour;
        gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
        
        self.iconView.backgroundColor = cpSelectedColour;
        NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:6 inSection:0];
        ColourCell *cell = (ColourCell *)[self.collectionView cellForItemAtIndexPath:_indexPath];
        cell.colourView.backgroundColor = cpSelectedColour;
    }
    
}


-(void)resetIconTransformPressed {
    
    panGesture = nil;
    
    [self.iconImage removeFromSuperview];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.resetTransformButton.alpha = 0;
    }];
    
    [self addIconImage];
    
}


-(void)addIconImage {
    
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    if (tempImage != nil) {
        self.iconImage.image = tempImage;
    } else {
        self.iconImage.image = [UIImage imageNamed:@"paradise-icon"];
    }
    self.iconImage.center = self.iconContainerView.center;
    self.iconImage.tintColor = tempColour;
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconView addSubview:self.iconImage];
    [self addMovementGesturesToView:self.iconImage];
    
}


-(UIMenu *)toolMenuManagement {
    
    UIAction *previewAction = [UIAction actionWithTitle:@"Preview" image:[UIImage systemImageNamed:@"eye.fill"] identifier:nil handler:^(UIAction *action) {
        [self previewIcon];
    }];
    
    UIAction *saveAction = [UIAction actionWithTitle:@"Save Icon Theme" image:[UIImage systemImageNamed:@"paperplane.fill"] identifier:nil handler:^(UIAction *action) {
        [self saveIconTheme];
    }];
    
    UIAction *exportAction = [UIAction actionWithTitle:@"Export" image:[UIImage systemImageNamed:@"square.and.arrow.up.fill"] identifier:nil handler:^(UIAction *action) {
        [self exportIcon];
    }];
    
    UIAction *photoAction = [UIAction actionWithTitle:@"Save to Photo Library" image:[UIImage systemImageNamed:@"photo.fill.on.rectangle.fill"] identifier:nil handler:^(UIAction *action) {
        [self saveIconToPhotoAlbum];
    }];
    
    UIAction *tutorialAction = [UIAction actionWithTitle:@"Show Tutorial" image:[UIImage systemImageNamed:@"questionmark.circle.fill"] identifier:nil handler:^(UIAction *action) {
        [self presentTutorialVC];
    }];
    
    //    UIAction *templateAction = [UIAction actionWithTitle:@"Save Template" image:[UIImage systemImageNamed:@"square.fill"] identifier:nil handler:^(UIAction *action) {
    //
    //    }];
    
    UIAction *resetAction = [UIAction actionWithTitle:@"Reset Icon" image:[UIImage systemImageNamed:@"trash.fill"] identifier:nil handler:^(UIAction *action) {
        [self resetIconEditor];
    }];
    resetAction.attributes = UIMenuElementAttributesDestructive;
    
    //saveAction.attributes = UIMenuElementAttributesDestructive; // UIMenuElementAttributesDisabled
    
    return [UIMenu menuWithTitle:@"Icon Settings" children:@[previewAction, saveAction, exportAction, photoAction, tutorialAction, resetAction]];
}


-(void)previewIcon {
    
    PreviewViewController *previewVC = [[PreviewViewController alloc] init];
    previewVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:previewVC animated:YES completion:nil];
    
    UIGraphicsBeginImageContextWithOptions(self.iconView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.iconView.layer renderInContext:context];
    UIImage *contextImage = UIGraphicsGetImageFromCurrentImageContext();
    
    previewVC.previewImage.image = contextImage;
    
}


-(void)saveIconTheme {
    
    loadPrefs();
    
    self.iconView.layer.cornerRadius = 0;
    
    UIGraphicsBeginImageContextWithOptions(self.iconView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.iconView.layer renderInContext:context];
    UIImage *contextImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSString *imageSubdirectory = [NSString stringWithFormat:@"/Library/Themes/%@/IconBundles/", themeFolderName];
    
    NSString *iconName = [NSString stringWithFormat:@"%@-large.png", bundleID];
    
    NSString *filePath = [imageSubdirectory stringByAppendingPathComponent:iconName];
    
    NSData *imageData = UIImagePNGRepresentation(contextImage);
    [imageData writeToFile:filePath atomically:YES];
    
    [self showAlertWithTitle:@"Successfully" message:@"Your icon have been saved to the theme folder you selected, you can apply icons theme by using theme engine and respring is required if you aren't using snowboard."];
    [self performSelector:@selector(resetCornerRadius) withObject:nil afterDelay:0.2];
}


-(void)saveIconToPhotoAlbum {
    
    self.iconView.layer.cornerRadius = 0;
    
    UIGraphicsBeginImageContextWithOptions(self.iconView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.iconView.layer renderInContext:context];
    UIImage *contextImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(contextImage, nil, nil, nil);
    
    [self showAlertWithTitle:@"Successfully" message:@"Your icon was saved to your photo library."];
    [self performSelector:@selector(resetCornerRadius) withObject:nil afterDelay:0.2];
}


-(void)exportIcon {
    
    self.iconView.layer.cornerRadius = 0;
    
    UIGraphicsBeginImageContextWithOptions(self.iconView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.iconView.layer renderInContext:context];
    UIImage *contextImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSString *title = @"Paradise";
    NSArray *dataToShare = @[contextImage, title];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:dataToShare applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
    
    
    [controller setCompletionWithItemsHandler:^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        if (activityType == nil)    {
            self.iconView.layer.cornerRadius = 25;
        } else {
            self.iconView.layer.cornerRadius = 25;
        }
    }];
    
}


-(void)resetIconEditor {
    
    self.iconView.backgroundColor = [UIColor colorNamed:@"Containers"];
    self.backgroundImage.image = nil;
    self.gradientView.alpha = 0;
    self.primraryColour = UIColor.whiteColor;
    self.secondaryColour = UIColor.systemTealColor;
    gradient.colors = @[(id)self.primraryColour.CGColor, (id)self.secondaryColour.CGColor];
    tempImage = nil;
    tempColour = [UIColor colorNamed:@"Accent"];
    
    [self resetIconTransformPressed];
    [self.collectionView reloadData];
    
}


-(void)resetCornerRadius {
    self.iconView.layer.cornerRadius = 25;
}


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(void)sendDataToEditor:(UIImage*)image {
    
    self.iconImage.image = image;
    tempImage = image;
    
    NSIndexPath *_indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    EditorCell *cell = (EditorCell *)[self.collectionView cellForItemAtIndexPath:_indexPath];
    cell.previewImage.image = image;
    cell.previewImage.tintColor = tempColour;
}


-(void)presentTutorialVC {
    
    TutorialViewController *tutorialVC = [[TutorialViewController alloc] init];
    tutorialVC.modalInPresentation = YES;
    [self presentViewController:tutorialVC animated:YES completion:nil];
}


@end
