#import "FavouriteFilterViewController.h"

@implementation FavouriteFilterViewController

-(instancetype)initWithHeight:(CGFloat)height {

  self = [super init];
  if (self) {
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.myAnimator = [[TDAnimator alloc] initWithCHeight:height andDimALpha:1.0];
    self.transitioningDelegate = self.myAnimator;

  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.systemBackgroundColor;
  self.view.layer.cornerRadius = 25;
  self.view.layer.cornerCurve = kCACornerCurveContinuous;
  self.view.layer.maskedCorners = 3;

  self.categoriesName = [[SettingManager sharedInstance] objectForKey:@"savedCategoriesName" defaultValue:@"All Favourites"];

  [self layoutHeader];
  [self setupCategoriesData];
  [self layoutCollectionView];
}


-(void)layoutHeader {

  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
  self.iconImage.tintColor = UIColor.tertiaryLabelColor;
  self.iconImage.image = [UIImage systemImageNamed:@"switch.2"];
  [self.view addSubview:self.iconImage];

  [self.iconImage size:CGSizeMake(60, 60)];
  [self.iconImage x:self.view.centerXAnchor];
  [self.iconImage top:self.view.topAnchor padding:10];


  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.titleLabel.textColor = UIColor.labelColor;
  self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
  self.titleLabel.text = @"Favourite Filters";
  [self.view addSubview:self.titleLabel];

  [self.titleLabel x:self.view.centerXAnchor];
  [self.titleLabel top:self.iconImage.bottomAnchor padding:10];
}


-(void)setupCategoriesData {
  // [IMPORTANT]
  NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSString *plistPath = [NSString stringWithFormat:@"%@/Categories.plist", aDocumentsDirectory];
  //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];

  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

  self.categoriesArray = [NSMutableArray new];
  for(NSString *key in mutableDict){
    [self.categoriesArray addObject:mutableDict[key]];

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"categoriesName" ascending:YES];
    [self.categoriesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
  }

}


-(void)layoutCollectionView {

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = UIColor.clearColor;
  self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.collectionView setShowsHorizontalScrollIndicator:NO];
  [self.collectionView setShowsVerticalScrollIndicator:NO];
  [self.collectionView registerClass:[FavouriteFilterCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.view addSubview:self.collectionView];

  [self.collectionView top:self.titleLabel.bottomAnchor padding:20];
  [self.collectionView height:75];
  [self.collectionView width:self.view.frame.size.width];
  [self.collectionView x:self.view.centerXAnchor];

  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.categoriesArray.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  FavouriteFilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;

  if (indexPath.row == 0) {

    cell.baseView.backgroundColor = [[[SettingManager sharedInstance] accentColour] colorWithAlphaComponent:0.4];
    cell.titleLabel.text = @"All Favourites";

    if ([cell.titleLabel.text isEqualToString:self.categoriesName]) {
      cell.iconImage.image = [UIImage systemImageNamed:@"checkmark"];
      cell.iconImage.tintColor = UIColor.whiteColor;
    } else {
      cell.iconImage.image = [UIImage systemImageNamed:@"folder.fill.badge.person.crop"];
      cell.iconImage.tintColor = [[SettingManager sharedInstance] accentColour];
    }

  } else {

    cell.baseView.backgroundColor = [[self colorWithHexString:(NSString*)[[self.categoriesArray objectAtIndex:indexPath.row-1 ] objectForKey:@"categoriesColour"]] colorWithAlphaComponent:0.4];
    cell.titleLabel.text = self.categoriesArray[indexPath.row-1][@"categoriesName"];

    if ([cell.titleLabel.text isEqualToString:self.categoriesName]) {
      cell.iconImage.image = [UIImage systemImageNamed:@"checkmark"];
      cell.iconImage.tintColor = UIColor.whiteColor;
    } else {
      cell.iconImage.image = [UIImage systemImageNamed:self.categoriesArray[indexPath.row-1][@"categoriesIcon"]];
      cell.iconImage.tintColor = [self colorWithHexString:(NSString*)[[self.categoriesArray objectAtIndex:indexPath.row-1 ] objectForKey:@"categoriesColour"]];

    }

  }

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(105, 75);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 10.0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0,25,0,25);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.row == 0) {
    self.categoriesName = @"All Favourites";
  } else {
    self.categoriesName = self.categoriesArray[indexPath.row-1][@"categoriesName"];
  }

  self.categoriesIndex = indexPath.row;
  self.didChooseCategories = YES;
  [self.collectionView reloadData];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self applyCategoriesFilter];
  });
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


-(void)applyCategoriesFilter {
  [[SettingManager sharedInstance] setObject:self.categoriesName forKey:@"savedCategoriesName"];
  [self.delegate filterFavouritesWithCategoriesName:self.categoriesName];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
