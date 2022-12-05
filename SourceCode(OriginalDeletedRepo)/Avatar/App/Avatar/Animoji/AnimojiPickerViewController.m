#import "AnimojiPickerViewController.h"

@interface AnimojiPickerViewController () 
@property (nonatomic, copy) NSArray <NSString *> *puppetNames;
@end


@implementation AnimojiPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    self.puppetNames = [ASAnimoji puppetNames];
    
    [self layoutCollectionView];
}


- (void)layoutCollectionView {
    
    self.flowLayout = [self makeFlowLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.backgroundView = nil;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.collectionView.frame = self.view.bounds;
    [self.collectionView registerClass:[AnimojiPickerCell class] forCellWithReuseIdentifier:@"AnimojiCell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (UICollectionViewFlowLayout *)makeFlowLayout {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat itemSize;
    CGFloat padding = 28;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat puppetsPerLine = 3;
    
    itemSize = (screenWidth / puppetsPerLine) - (padding * puppetsPerLine) + (padding * 2);
    
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    
    return layout;
}


- (void)setPuppetNames:(NSArray<NSString *> *)puppetNames {
    _puppetNames = [puppetNames copy];
    [self.collectionView reloadData];
}


- (void)selectPuppetWithName:(NSString *)puppetName {
    if (![self.puppetNames containsObject:puppetName]) return;
    NSUInteger idx = [self.puppetNames indexOfObject:puppetName];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.puppetNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AnimojiPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimojiCell" forIndexPath:indexPath];
    
    cell.puppetName = self.puppetNames[indexPath.item];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *animoji = self.puppetNames[indexPath.item];
    [self.delegate didSelectAnimojiWithName:animoji];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
