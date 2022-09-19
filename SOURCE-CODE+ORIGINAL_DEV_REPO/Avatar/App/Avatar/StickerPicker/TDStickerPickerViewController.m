#import "TDStickerPickerViewController.h"

@implementation TDStickerPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    
    self.blurSetting = [_UIBackdropViewSettings settingsForStyle:2];
    self.blurView = [[_UIBackdropView alloc] initWithSettings:self.blurSetting];
    self.blurView.frame = self.view.bounds;
    [self.view insertSubview:self.blurView atIndex:0];
    
    
    NSString *myFile = [[NSBundle mainBundle]pathForResource:@"Stickers" ofType:@"plist"];
    self.stickerArray = [[NSMutableArray alloc] initWithContentsOfFile:myFile];
    
    [self layoutGrabberView];
    [self layoutCollectionView];
}


-(void)layoutGrabberView {
    
    self.grabberView = [[UIVisualEffectView alloc] init];
    self.grabberView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
    self.grabberView.layer.cornerRadius = 3;
    self.grabberView.clipsToBounds = YES;
    [self.view addSubview:self.grabberView];
    
    [self.grabberView size:CGSizeMake(40, 6)];
    [self.grabberView x:self.view.centerXAnchor];
    [self.grabberView top:self.view.topAnchor padding:10];
}


-(void)layoutCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[TDStickerPickerCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[TDStickerPickerCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView top:self.grabberView.bottomAnchor padding:20];
    [self.collectionView bottom:self.view.bottomAnchor padding:-20];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return self.stickerArray.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 45);
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[self.stickerArray objectAtIndex: section] objectForKey:@"Stickers"] count];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        TDStickerPickerCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.headerLabel.text = [[self.stickerArray objectAtIndex:indexPath.section] objectForKey: @"Title"];
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TDStickerPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *imageString = [[[self.stickerArray objectAtIndex: indexPath.section] objectForKey: @"Stickers"] objectAtIndex: indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:imageString];
    return cell;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,20,0,20);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/4-20, self.view.frame.size.width/4-20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.didSelectSticker = YES;
    [self.delegate didSelectSticker:[[[self.stickerArray objectAtIndex: indexPath.section] objectForKey: @"Stickers"] objectAtIndex: indexPath.row]];
    [self dismissVC];
}


-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (!self.didSelectSticker) {
        [self.delegate didDismissedStickersPicker];
    }
}

@end
