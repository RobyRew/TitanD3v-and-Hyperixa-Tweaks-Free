#import "ColourSectionViewController.h"

@implementation ColourSectionViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Colours";
    self.navigationController.navigationBar.prefersLargeTitles = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    [self addTabPageBar];
    [self addPagerController];
    [self loadData];
}


- (void)addTabPageBar {
    _tabBar = [[TYTabPagerBar alloc]init];
    _tabBar.backgroundColor = UIColor.clearColor;
    _tabBar.layout.barStyle = TYPagerBarStyleCoverView;
    _tabBar.layout.progressColor = [UIColor colorNamed:@"Accent"];
    _tabBar.layout.selectedTextColor = UIColor.whiteColor;
    _tabBar.layout.normalTextColor = UIColor.labelColor;
    _tabBar.layout.adjustContentCellsCenter = YES;
    _tabBar.dataSource = self;
    _tabBar.delegate = self;
    [_tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:_tabBar];
}


- (void)addPagerController {
    _pagerController = [[TYPagerController alloc]init];
    _pagerController.layout.prefetchItemCount = 1;
    _pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    _pagerController.dataSource = self;
    _pagerController.delegate = self;
    _pagerController.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 5, CGRectGetWidth(self.view.frame), 36);
    _pagerController.view.frame = CGRectMake(0, CGRectGetMaxY(_tabBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- CGRectGetMaxY(_tabBar.frame));
}


- (void)loadData {
    _datas = [[NSArray alloc] initWithObjects:@"System Colour", @"Multi Colour", @"Shades of Black", @"Shades of Blue", @"Shades of Brown", @"Shades of Grey", @"Shades of Green", @"Shades of Orange", @"Shades of Pink", @"Shades of Purple", @"Shades of Red", @"Shades of White", @"Shades of Yellow", nil];
    [self reloadData];
}


- (NSInteger)numberOfItemsInPagerTabBar {
    return _datas.count;
}


- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _datas[index];
    return cell;
}


- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = _datas[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}


- (NSInteger)numberOfControllersInPagerController {
    return _datas.count;
}


- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        SystemColourViewController *systemVC = [[SystemColourViewController alloc]init];
        return systemVC;
    } else if (index == 1) {
        MultiColourViewController *multiVC = [[MultiColourViewController alloc] init];
        return multiVC;
    } else if (index == 2) {
        BlackColourViewController *customVC = [[BlackColourViewController alloc] init];
        return customVC;
    } else if (index == 3) {
        BlueColourViewController *customVC = [[BlueColourViewController alloc] init];
        return customVC;
    } else if (index == 4) {
        BrownColourViewController *customVC = [[BrownColourViewController alloc] init];
        return customVC;
    } else if (index == 5) {
        GreyColourViewController *customVC = [[GreyColourViewController alloc] init];
        return customVC;
    } else if (index == 6) {
        GreenColourViewController *customVC = [[GreenColourViewController alloc] init];
        return customVC;
    } else if (index == 7) {
        OrangeColourViewController *customVC = [[OrangeColourViewController alloc] init];
        return customVC;
    } else if (index == 8) {
        PinkColourViewController *customVC = [[PinkColourViewController alloc] init];
        return customVC;
    } else if (index == 9) {
        PurpleColourViewController *customVC = [[PurpleColourViewController alloc] init];
        return customVC;
    } else if (index == 10) {
        RedColourViewController *customVC = [[RedColourViewController alloc] init];
        return customVC;
    } else if (index == 11) {
        WhiteColourViewController *customVC = [[WhiteColourViewController alloc] init];
        return customVC;
    } else {
        YellowColourViewController *customVC = [[YellowColourViewController alloc] init];
        return customVC;
    }
}


- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)reloadData {
    [_tabBar reloadData];
    [_pagerController reloadData];
}


@end
