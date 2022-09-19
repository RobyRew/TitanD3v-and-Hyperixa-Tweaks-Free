//#import "AccessoriesViewController.h"
//
//@implementation AccessoriesViewController
//
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.navigationItem.title = @"Accessories";
//    self.navigationController.navigationBar.prefersLargeTitles = YES;
//    
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
//    
//    [self layoutTableView];
//}
//
//
//-(void)layoutTableView {
//    
//    self.titleArray = [[NSArray alloc] initWithObjects:@"Icon Mask", @"Icon Badge", @"Badge Colour", nil];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.tableView.editing = NO;
//    self.tableView.backgroundColor = UIColor.clearColor;
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.tableView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.tableView];
//    
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//}
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  return 3;
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    } else if (section == 1) {
//        return 1;
//    } else {
//        return 1;
//    }
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//  return 25.0f;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//  UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width -15, 45)];
//  sectionHeaderView.backgroundColor = UIColor.clearColor;
//  sectionHeaderView.clipsToBounds = true;
//
//  UILabel *headerLabel = [[UILabel alloc] init];
//  headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.textColor = UIColor.labelColor;
//  headerLabel.textAlignment = NSTextAlignmentLeft;
//  headerLabel.font = [UIFont boldSystemFontOfSize:16];
//  headerLabel.text = [self.titleArray objectAtIndex:section];
//  [sectionHeaderView addSubview:headerLabel];
//    
//    [headerLabel leading:sectionHeaderView.leadingAnchor padding:10];
//  [headerLabel y:sectionHeaderView.centerYAnchor];
//
//  return sectionHeaderView;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  UIView *selectionView = [UIView new];
//  selectionView.backgroundColor = UIColor.clearColor;
//  [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
//    
//    //if (indexPath.section == 0) {
//
//      CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
//
//      if (cell == nil) {
//        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
//      }
//    
//    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    self.maskCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    self.maskCollectionView.backgroundColor = UIColor.clearColor;
//    self.maskCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.maskCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.maskCollectionView setShowsHorizontalScrollIndicator:NO];
//    [self.maskCollectionView setShowsVerticalScrollIndicator:NO];
//    [self.maskCollectionView registerClass:[AddFolderCell class] forCellWithReuseIdentifier:@"addCell"];
//    [self.view addSubview:self.maskCollectionView];
//    
//    self.maskCollectionView.delegate = self;
//    self.maskCollectionView.dataSource = self;
//    
//    [self.maskCollectionView top:cell.baseView.topAnchor padding:5];
//    [self.maskCollectionView leading:cell.baseView.leadingAnchor padding:5];
//    [self.maskCollectionView trailing:cell.baseView.trailingAnchor padding:-5];
//    [self.maskCollectionView bottom:cell.baseView.bottomAnchor padding:-5];
//        
//        return cell;  
//        
////    } else {
////        return nil;
////    }
//
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  return 150;
//}
//
//@end
