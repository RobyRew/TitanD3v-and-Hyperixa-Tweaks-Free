//#import "LibraryViewController.h"
//
//@implementation LibraryViewController
//
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.navigationItem.title = @"Templates";
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
//    
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
//    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    self.collectionView.backgroundColor = UIColor.clearColor;
//    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.collectionView setShowsHorizontalScrollIndicator:NO];
//    [self.collectionView setShowsVerticalScrollIndicator:NO];
//    [self.collectionView registerClass:[LibraryCell class] forCellWithReuseIdentifier:@"Cell"];
//    [self.view addSubview:self.collectionView];
//    
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//}
//
//
//- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 20;
//}
//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//        
//        LibraryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//        
//        cell.backgroundColor = UIColor.clearColor;
//        cell.previewImage.image = [UIImage imageNamed:@"preview"];
//    cell.titleLabel.text = @"Saved :)";
//    cell.libraryDelegate = self;
//
//    
//        return cell;
//    
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width  = self.view.frame.size.width /2 -15;
//    return CGSizeMake(width, width);
//}
//
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10.0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10.0;
//}
//
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0,10,0,10);  // top, left, bottom, right
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
//        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
//        cell.alpha = 0.5;
//    } completion:nil];
//    
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
//        cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        cell.alpha = 1;
//    } completion:nil];
//    
//}
//
//
//- (void)deleteLibraryForCell:(UICollectionViewCell *)cell {
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//    
//    if (indexPath.row == 1) {
//        self.view.backgroundColor = UIColor.yellowColor;
//    } else if (indexPath.row == 3) {
//        self.view.backgroundColor = UIColor.greenColor;
//    }
//
//
//}
//
//
//@end
