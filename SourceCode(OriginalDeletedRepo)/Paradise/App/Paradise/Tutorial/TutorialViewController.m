#import "TutorialViewController.h"

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptionArray = [[NSArray alloc] initWithObjects:
                             @"On the icon area you can use finger gestures to drag around the position of the icon, pinch the icon with two fingers to resize the icon, use two fingers to rotate the icon. Once you edit the icon, you will see the red reset icon, click that if you want to reset the icons position and size.",
                             @"On the top left corner menu button where you can preview the icon on the dummy home screen, save the icon to the theme folder, export the icon, save the icon to your photo library, show the tutorial again and reset the icon so it will revert everything back to default.",
                             @"On top right corner plane button, once you design your icon, click the plane button so that it will save the icon to your preferred theme folder and make sure you have selected which theme folder you want it to be saved to.",
                             @"You can change the icons by using 2000+ SF Symbols, choose the icon from your photo library, colour the icon, add a background image, set a solid background colour or a gradient.",
                             @"Please be advised to create a new theme folder because if you already have the icon for a certain app in theme folder, when you save the new icon it will overwrite onto the existing icon. It’s okay if you don’t have any icons for a certain app in that theme folder, then it will save that to that certain folder, make sure you selected your preferred theme folder or create a new one then once you finish designing your icon then click on the plane button to save the icon and head to your theme engine settings to apply that theme.",
                             nil];
    
    self.imageArray = [[NSArray alloc] initWithObjects:
                       @"hand.tap.fill",
                       @"rectangle.grid.1x2.fill",
                       @"paperplane.fill",
                       @"square.fill",
                       @"folder.fill",
                       nil];
    
    
    self.view.backgroundColor = [UIColor colorNamed:@"Main Background"];
    
    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.image = [UIImage imageNamed:@"paradise-icon"];
    self.iconImage.userInteractionEnabled = YES;
    [self.view addSubview:self.iconImage];
    
    self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.iconImage.heightAnchor constraintEqualToConstant:70].active = YES;
    [self.iconImage.widthAnchor constraintEqualToConstant:70].active = YES;
    [self.iconImage.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10].active = YES;
    [[self.iconImage centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.text = @"Tutorial";
    [self.view addSubview:self.titleLabel];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImage.bottomAnchor constant:10].active = YES;
    [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
    
    self.closeButton = [[UIButton alloc] init];
    self.closeButton.backgroundColor = [UIColor colorNamed:@"Accent"];
    self.closeButton.layer.cornerRadius = 15;
    self.closeButton.layer.cornerCurve = kCACornerCurveContinuous;
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.closeButton];
    
    [self.closeButton size:CGSizeMake(250, 50)];
    [self.closeButton x:self.view.centerXAnchor];
    [self.closeButton bottom:self.view.bottomAnchor padding:-15];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView top:self.titleLabel.bottomAnchor padding:10];
    [self.tableView leading:self.view.leadingAnchor padding:10];
    [self.tableView trailing:self.view.trailingAnchor padding:-10];
    [self.tableView bottom:self.closeButton.topAnchor padding:-10];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TutorialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[TutorialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = UIColor.clearColor;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
    
    cell.backgroundColor = UIColor.clearColor;
    
    NSString *imageString = [self.imageArray objectAtIndex:indexPath.row];
    
    cell.iconImage.image = [[UIImage systemImageNamed:imageString] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.messageLabel.text = [self.descriptionArray objectAtIndex:indexPath.row];
    
    return cell;
    
}


-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[AppManager sharedInstance] setBool:NO forKey:@"showTutorial"];
}


@end
