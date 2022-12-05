#import "FavouriteViewController.h"

static NSMutableDictionary *mutableDict;
static NSMutableArray *allDataArray;

 static void deleteDataForID(NSString *idToRemove){
     
     NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSString *prefPath = [NSString stringWithFormat:@"%@/Favourites.plist", aDocumentsDirectory];
     
     NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
     mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
     [mutableDict removeObjectForKey:idToRemove];
     [mutableDict writeToFile:prefPath atomically:YES];
     
}


@implementation FavouriteViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Themes";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"folder.fill.badge.plus"] style:UIBarButtonItemStylePlain target:self action:@selector(createThemeFolder)];
    self.navigationItem.rightBarButtonItem = createButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Favourites.plist", aDocumentsDirectory];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefPath];
    mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    allDataArray = [NSMutableArray new];
    for(NSString *key in mutableDict){
    [allDataArray addObject:mutableDict[key]];
    }
    
    NSLog(@"%@",allDataArray);
    
    [self layoutTableView];
}


-(void)layoutTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allDataArray.count;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ColourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[ColourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    cell.backgroundColor = UIColor.clearColor;
        

    cell.nameLabel.text = allDataArray[indexPath.row][@"BackgroundColour"];

    NSData *colorData = allDataArray[indexPath.row][@"Icon Colour"];
    UIColor *testColour = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    
    cell.colourView.backgroundColor = testColour;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


-(void)deleteButtonTappedForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    deleteDataForID(allDataArray[indexPath.row][@"id"]);
}


-(void)createThemeFolder {
    
    
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *prefPath = [NSString stringWithFormat:@"%@/Favourites.plist", aDocumentsDirectory];


    UIColor *testColour = UIColor.blueColor;

    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:testColour];

    //long long savedStateCount = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    NSString *withID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
    NSDictionary *data = @{@"id" : withID, @"Icon Colour" : colorData, @"BackgroundColour" : @"Cool", @"Icon Size" : @"sup"};
    [mutableDict setValue:data forKey:withID];
    [mutableDict writeToFile:prefPath atomically:YES];
    
    
    //deleteDataForID(allDataArray[0][@"id"]);
    

}


@end
