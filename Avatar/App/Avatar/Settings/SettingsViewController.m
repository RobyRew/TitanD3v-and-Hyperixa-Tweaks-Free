#import "SettingsViewController.h"


@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    [self layoutHeaderView];
    [self layoutTableView];
}


-(void)layoutHeaderView {
    
    self.headerView = [[TDHeaderView alloc] initWithTitle:@"Settings" accent:UIColor.systemBlueColor leftIcon:@"chevron.left" leftAction:@selector(dismissVC)];
    self.headerView.grabberView.alpha = 0;
    self.headerView.leftButton.backgroundColor = [UIColor colorNamed:@"Secondary"];
    [self.view addSubview:self.headerView];
    
    [self.headerView size:CGSizeMake(self.view.frame.size.width, 55)];
    [self.headerView x:self.view.centerXAnchor];
    [self.headerView top:self.view.safeAreaLayoutGuide.topAnchor padding:0];
}


-(void)layoutTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.editing = NO;
    self.tableView.backgroundColor = UIColor.clearColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView top:self.headerView.bottomAnchor padding:20];
    [self.tableView leading:self.view.leadingAnchor padding:0];
    [self.tableView trailing:self.view.trailingAnchor padding:0];
    [self.tableView bottom:self.view.bottomAnchor padding:0];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width -15, 45)];
    sectionHeaderView.backgroundColor = UIColor.clearColor;
    sectionHeaderView.layer.cornerRadius = 15;
    sectionHeaderView.clipsToBounds = true;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, sectionHeaderView.frame.size.height /2 -9, 200, 18)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = UIColor.tertiaryLabelColor;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    [sectionHeaderView addSubview:headerLabel];
    
    if (section == 0) {
        headerLabel.text = @"General";
    } else {
        headerLabel.text = @"Social";
    }
    
    return sectionHeaderView;
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        
        UIView *selectionView = [UIView new];
        selectionView.backgroundColor = UIColor.clearColor;
        [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
        cell.backgroundColor = UIColor.clearColor;
        
        
        cell.iconView.backgroundColor = [UIColor.systemIndigoColor colorWithAlphaComponent:0.4];
        cell.iconImage.image = [UIImage systemImageNamed:@"face.smiling.fill"];
        cell.iconImage.tintColor = UIColor.systemIndigoColor;
        cell.titleLabel.text = @"Memoji";
        cell.subtitleLabel.text = @"Import existing Memoji";
        
        
        return cell;
        
    } else {
        
        SocialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            cell = [[SocialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        UIView *selectionView = [UIView new];
        selectionView.backgroundColor = UIColor.clearColor;
        [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
        cell.backgroundColor = UIColor.clearColor;
        
        
        if (indexPath.row == 0) {
            
            cell.iconView.backgroundColor = [UIColor.systemTealColor colorWithAlphaComponent:0.4];
            cell.iconImage.image = [[UIImage imageNamed:@"twitter"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.iconImage.tintColor = UIColor.systemTealColor;
            cell.titleLabel.text = @"Twitter";
            cell.subtitleLabel.text = @"Follow us on Twitter";
            
        } else if (indexPath.row == 1) {
            
            cell.iconView.backgroundColor = [UIColor.systemYellowColor colorWithAlphaComponent:0.4];
            cell.iconImage.image = [[UIImage imageNamed:@"discord"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.iconImage.tintColor = UIColor.systemYellowColor;
            cell.titleLabel.text = @"Discord";
            cell.subtitleLabel.text = @"Chat with us";
            
        } else if (indexPath.row == 2) {
            
            cell.iconView.backgroundColor = [UIColor.systemOrangeColor colorWithAlphaComponent:0.4];
            cell.iconImage.image = [[UIImage imageNamed:@"paypal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.iconImage.tintColor = UIColor.systemOrangeColor;
            cell.titleLabel.text = @"PayPal";
            cell.subtitleLabel.text = @"Any donation is greatly appreciated";
            
        }
        
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            NSURL *URL = [NSURL URLWithString:@"https://twitter.com/D3vTitan"];
            [application openURL:URL options:@{} completionHandler:nil];
        } else if (indexPath.row == 1) {
            NSURL *URL = [NSURL URLWithString:@"https://discord.gg/Kk4KYpZ528"];
            [application openURL:URL options:@{} completionHandler:nil];
        } else if (indexPath.row == 2) {
            NSURL *URL = [NSURL URLWithString:@"https://paypal.me/southerngirlwhocode"];
            [application openURL:URL options:@{} completionHandler:nil];
        }
        
    }
}


-(void)dismissVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
