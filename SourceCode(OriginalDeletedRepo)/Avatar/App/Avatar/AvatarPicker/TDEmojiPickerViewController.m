#import "TDEmojiPickerViewController.h"

@implementation TDEmojiPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    
    self.blurSetting = [_UIBackdropViewSettings settingsForStyle:2];
    self.blurView = [[_UIBackdropView alloc] initWithSettings:self.blurSetting];
    self.blurView.frame = self.view.bounds;
    [self.view insertSubview:self.blurView atIndex:0];
    
    
    NSString *myFile = [[NSBundle mainBundle]pathForResource:@"Emoji" ofType:@"plist"];
    self.emojiArray = [[NSMutableArray alloc] initWithContentsOfFile:myFile];
    
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
    [self.collectionView registerClass:[TDEmojiPickerCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[TDEmojiPickerCellHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView top:self.grabberView.bottomAnchor padding:20];
    [self.collectionView bottom:self.view.bottomAnchor padding:-20];
    [self.collectionView leading:self.view.leadingAnchor padding:0];
    [self.collectionView trailing:self.view.trailingAnchor padding:0];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return self.emojiArray.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 45);
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[self.emojiArray objectAtIndex: section] objectForKey:@"Emojis"] count];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        TDEmojiPickerCellHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.headerLabel.text = [[self.emojiArray objectAtIndex:indexPath.section] objectForKey: @"Title"];
        reusableview = headerView;
    }
    
    return reusableview;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TDEmojiPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.emojiLabel.text = [[[self.emojiArray objectAtIndex: indexPath.section] objectForKey: @"Emojis"] objectAtIndex: indexPath.row];
    
    return cell;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,20,0,20);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/8, self.view.frame.size.width/8);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.didSelectEmoji = YES;
    [self.delegate didSelectEmoji:[[[self.emojiArray objectAtIndex: indexPath.section] objectForKey: @"Emojis"] objectAtIndex: indexPath.row]];
    [self dismissVC];
}


-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (!self.didSelectEmoji) {
        [self.delegate didDismissedEmojiPicker];
    }
}

@end
