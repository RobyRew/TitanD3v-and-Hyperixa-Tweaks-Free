#import "ThemesViewController.h"

static NSString *themePath = @"/Library/Themes/";
static NSMutableArray *themeArrays;
static NSString *selectedThemeName;

@implementation ThemesViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Themes";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    createButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"folder.fill.badge.plus"] style:UIBarButtonItemStylePlain target:self action:@selector(createThemeFolder)];
    self.navigationItem.rightBarButtonItem = nil;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* directory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:themePath error:NULL];
    themeArrays = [[NSMutableArray alloc] init];
    [directory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"theme"]) {
            [themeArrays addObject:filename];
        }
    }];
    
    [themeArrays sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[AddFolderCell class] forCellWithReuseIdentifier:@"addCell"];
    [self.collectionView registerClass:[ThemesCell class] forCellWithReuseIdentifier:@"themeCell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveThemeNotification:) name:@"AddedNewThemeNotification" object:nil];
    
}


- (void)receiveThemeNotification:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"AddedNewThemeNotification"]) {
        
        [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.5];
    }
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return themeArrays.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        AddFolderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.gradientImage.image = [UIImage imageNamed:@"gradient"];
        
        return cell;
        
    } else {
        
        ThemesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"themeCell" forIndexPath:indexPath];
        
        cell.backgroundColor = UIColor.clearColor;
        cell.gradientImage.image = [UIImage imageNamed:@"gradient"];
        cell.themeLabel.text = [themeArrays objectAtIndex:indexPath.row -1];
        
        NSString *iconString = [NSString stringWithFormat:@"/Library/Themes/%@/IconBundles/", [themeArrays objectAtIndex:indexPath.row -1]];
        NSUInteger iconCount = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:iconString error:nil] count];
        cell.countLabel.text = [NSString stringWithFormat: @"%ld Icons", (long)iconCount];
        
        
        selectedThemeName = [[AppManager sharedInstance] objectForKey:@"selectedThemesName"];
        
        if (!self.checkedIndexPath) {
            
            if ([[themeArrays objectAtIndex:indexPath.row -1] isEqualToString:selectedThemeName]) {
                
                self.checkedIndexPath = indexPath;
                
            }
            
        }
        
        
        if ([indexPath isEqual:self.checkedIndexPath]) {
            
            cell.checkedImage.image = [UIImage systemImageNamed:@"checkmark.circle.fill"];
            
        } else {
            
            cell.checkedImage.image = nil;
            
        }
        
        return cell;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width  = self.view.frame.size.width /2 -15;
    return CGSizeMake(width, 130);
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self createThemeFolder];
    } else {
        self.checkedIndexPath = indexPath;
        self.selectedTheme = themeArrays[indexPath.row -1];
        [[AppManager sharedInstance] setObject:self.selectedTheme forKey:@"selectedThemesName"];
        [self.collectionView reloadData];
    }
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


-(void)createThemeFolder {
    
    CreateThemeFolderVC *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateThemeFolderVC"];
    createVC.modalInPresentation = YES;
    [self presentViewController:createVC animated:YES completion:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        self.navigationItem.rightBarButtonItem = nil;
    } else if (scrollView.contentOffset.y > 0) {
        self.navigationItem.rightBarButtonItem = createButton;
    }
    
}


-(void)refreshData {
    
    NSArray* directory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:themePath error:NULL];
    themeArrays = [[NSMutableArray alloc] init];
    [directory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"theme"]) {
            [themeArrays addObject:filename];
        }
    }];
    
    [themeArrays sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    selectedThemeName = [[AppManager sharedInstance] objectForKey:@"selectedThemesName"];
    
    self.checkedIndexPath = nil;
    
    [self.collectionView reloadData];
    
}

@end
