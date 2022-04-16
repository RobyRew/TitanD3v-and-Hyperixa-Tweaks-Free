#import "DrawerViewController.h"

static NSInteger categoriesSelectedIndex = 0;

@implementation DrawerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tintColour = [[TDAppearance sharedInstance] tintColour];

  self.view.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.11 alpha: 1.00];
  
  [self layoutCollectionView];
  [self checkCategoriesIndex];
  [self layoutSocialVC];
  [self layoutChangelogVC];
  [self layoutBackupVC];
  [self layoutTweakVC];
  [self layoutProfileVC];
  [self layoutCrewVC];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDrawerNotification:) name:@"ResetDrawer" object:nil];
}


- (void)resetDrawerNotification:(NSNotification *) notification {

  if ([[notification name] isEqualToString:@"ResetDrawer"]){
    [self resetIndex];
  }
}


-(void)resetIndex {

  categoriesSelectedIndex = 0;
  [self.collectionView reloadData];
  [self checkCategoriesIndex];

}


-(void)layoutCollectionView {

    self.categoriesArray = [[NSMutableArray alloc] init];
    [self.categoriesArray addObject:@"Social"];
    [self.categoriesArray addObject:@"Changelog"];
    [self.categoriesArray addObject:@"Backup/Restore"];
    [self.categoriesArray addObject:@"Tweaks"];
    [self.categoriesArray addObject:@"Profile"];
    [self.categoriesArray addObject:@"Crew"];
    
    self.imageArray = [[NSArray alloc] initWithObjects:@"link.circle.fill", @"list.bullet.rectangle", @"archivebox.fill", @"hammer.fill", @"person.crop.circle.fill", @"person.2.circle.fill", nil];
      
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView registerClass:[CategoriesCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView height:80];
    [self.collectionView leading:self.view.leadingAnchor padding:20];
    [self.collectionView trailing:self.view.trailingAnchor padding:-20];
    [self.collectionView bottom:self.view.bottomAnchor padding:0];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.categoriesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  CategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.titleLabel.text = [self.categoriesArray objectAtIndex:indexPath.row];
    cell.iconImage.image = [UIImage systemImageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    
    if (indexPath.row == categoriesSelectedIndex) {
        cell.selectedView.alpha = 1;
        cell.gradientView.alpha = 1;
        cell.iconImage.tintColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
        cell.titleLabel.alpha = 1;
    } else {
        cell.gradientView.alpha = 0;
        cell.selectedView.alpha = 0;
        cell.iconImage.tintColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.5];
        cell.titleLabel.alpha = 0;
    }

  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(80, 80);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  invokeHapticFeedback();

    categoriesSelectedIndex = indexPath.row;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
  [self checkCategoriesIndex];

}


-(void)checkCategoriesIndex {

  if (categoriesSelectedIndex == 0) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 1;
      self.changelogVC.view.alpha = 0;
      self.backupVC.view.alpha = 0;
      self.tweakVC.view.alpha = 0;
      self.profileVC.view.alpha = 0;
      self.crewVC.view.alpha = 0;
    }];
  } else if (categoriesSelectedIndex == 1) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 0;
      self.changelogVC.view.alpha = 1;
      self.backupVC.view.alpha = 0;
      self.tweakVC.view.alpha = 0;
      self.profileVC.view.alpha = 0;
      self.crewVC.view.alpha = 0;
    }];
  } else if (categoriesSelectedIndex == 2) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 0;
      self.changelogVC.view.alpha = 0;
      self.backupVC.view.alpha = 1;
      self.tweakVC.view.alpha = 0;
      self.profileVC.view.alpha = 0;
      self.crewVC.view.alpha = 0;
    }];
  } else if (categoriesSelectedIndex == 3) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 0;
      self.changelogVC.view.alpha = 0;
      self.backupVC.view.alpha = 0;
      self.tweakVC.view.alpha = 1;
      self.profileVC.view.alpha = 0;
      self.crewVC.view.alpha = 0;
    }];
  } else if (categoriesSelectedIndex == 4) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 0;
      self.changelogVC.view.alpha = 0;
      self.backupVC.view.alpha = 0;
      self.tweakVC.view.alpha = 0;
      self.profileVC.view.alpha = 1;
      self.crewVC.view.alpha = 0;
    }];
  } else if (categoriesSelectedIndex == 5) {
    [UIView animateWithDuration:0.2 animations:^ {
      self.socialVC.view.alpha = 0;
      self.changelogVC.view.alpha = 0;
      self.backupVC.view.alpha = 0;
      self.tweakVC.view.alpha = 0;
      self.profileVC.view.alpha = 0;
      self.crewVC.view.alpha = 1;
    }];
  }

}


-(void)layoutSocialVC {

  self.socialVC = [[SocialViewController alloc] init];
  [self addChildViewController:self.socialVC];
  [self.view addSubview:self.socialVC.view];

  self.socialVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.socialVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.socialVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.socialVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.socialVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;
}


-(void)layoutChangelogVC {

  self.changelogVC = [[ChangelogViewController alloc] init];
  self.changelogVC.view.alpha = 0;
  [self addChildViewController:self.changelogVC];
  [self.view addSubview:self.changelogVC.view];

  self.changelogVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.changelogVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.changelogVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.changelogVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.changelogVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;
}


-(void)layoutBackupVC {

  self.backupVC = [[BackupViewController alloc] init];
  self.backupVC.view.alpha = 0;
  [self addChildViewController:self.backupVC];
  [self.view addSubview:self.backupVC.view];

  self.backupVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.backupVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.backupVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.backupVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.backupVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;

}


-(void)layoutTweakVC {

  self.tweakVC = [[TweakViewController alloc] init];
  self.tweakVC.view.alpha = 0;
  [self addChildViewController:self.tweakVC];
  [self.view addSubview:self.tweakVC.view];

  self.tweakVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.tweakVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.tweakVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.tweakVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.tweakVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;
}


-(void)layoutProfileVC {

  self.profileVC = [[ProfileViewController alloc] init];
  self.profileVC.view.alpha = 0;
  [self addChildViewController:self.profileVC];
  [self.view addSubview:self.profileVC.view];

  self.profileVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.profileVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.profileVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.profileVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.profileVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;

}


-(void)layoutCrewVC {

  self.crewVC = [[CrewViewController alloc] init];
  self.crewVC.view.alpha = 0;
  [self addChildViewController:self.crewVC];
  [self.view addSubview:self.crewVC.view];

  self.crewVC.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.crewVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
  [self.crewVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.crewVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
  [self.crewVC.view.bottomAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:-10].active = YES;

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];  
    [self resetIndex];
}


-(BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

@end
