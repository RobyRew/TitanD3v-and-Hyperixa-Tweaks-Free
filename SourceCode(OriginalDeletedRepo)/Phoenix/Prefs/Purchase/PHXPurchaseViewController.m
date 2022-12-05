#import "PHXPurchaseViewController.h"

static NSString *UDIDCheckURL = @"https://payments.titand3v.com/api/check_udid.php?udid=";
static NSString *TRIALCheckURL = @"https://payments.titand3v.com/api/check_trial.php?udid=";
static NSString *URL =  @"https://payments.titand3v.com/api/deviceCheck.php?udid=";

static NSString *UDID = nil;
static NSString *tweaknameString = @"Phoenix";
static NSString *priceString = @"$2.00";
static BOOL showConfetti;

static NSInteger helpActionIndex = 0;

@implementation PHXPurchaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [[TDPrefsManager sharedInstance] initWithBundleID:@"com.TitanD3v.PhoenixPrefs"];
  showConfetti = [[TDPrefsManager sharedInstance] boolForKey:@"showConfetti" defaultValue:YES];

  self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
  self.view.clipsToBounds = true;
  UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
  [self checkNetworkStatus];
  [self layoutBannerView];
  [self layoutCollectionView];
  [self layoutViews];
  [self layoutConfetti];

}


-(void)checkNetworkStatus {

  Reachability *_reachability = [Reachability reachabilityForInternetConnection];
  [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleNetworkChange:) name:kReachabilityChangedNotification object: nil];
  _reachability = [Reachability reachabilityForInternetConnection];
  [_reachability startNotifier];
  [self performSelector:@selector(handleNetworkChange:) withObject:nil afterDelay:0];


  self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
  self.activityIndicator.alpha = 1.0;
  self.activityIndicator.color = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
  self.activityIndicator.center = self.view.center;
  [self.view addSubview:self.activityIndicator];

}


-(void)layoutBannerView {

  self.bannerImage = [[UIImageView alloc] init];
  self.bannerImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Payment/purchase-banner.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.bannerImage.tintColor = [UIColor colorWithRed: 0.10 green: 0.10 blue: 0.10 alpha: 0.7];
  [self.view addSubview:self.bannerImage];

  [self.bannerImage height:555];
  [self.bannerImage width:748];
  [self.bannerImage x:self.view.centerXAnchor];
  [self.bannerImage bottom:self.view.topAnchor padding:170];


  self.bannerView = [[UIView alloc] init];
  self.bannerView.clipsToBounds = true;
  self.bannerView.backgroundColor = UIColor.clearColor;
  [self.view addSubview:self.bannerView];

  [self.bannerView top:self.view.topAnchor padding:0];
  [self.bannerView leading:self.view.leadingAnchor padding:0];
  [self.bannerView trailing:self.view.trailingAnchor padding:0];
  [self.bannerView height:170];


  self.iconImage = [[UIImageView alloc] init];
  self.iconImage.image = [[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  self.iconImage.clipsToBounds = true;
  [self.bannerView addSubview:self.iconImage];

  [self.iconImage size:CGSizeMake(50, 50)];
  [self.iconImage x:self.bannerView.centerXAnchor];
  [self.iconImage top:self.bannerView.topAnchor padding:40];


  self.tweaknameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.tweaknameLabel.font = [UIFont boldSystemFontOfSize:14];
  self.tweaknameLabel.textColor = UIColor.whiteColor;
  self.tweaknameLabel.text = tweaknameString;
  self.tweaknameLabel.textAlignment = NSTextAlignmentCenter;
  [self.bannerView addSubview:self.tweaknameLabel];

  [self.tweaknameLabel x:self.bannerView.centerXAnchor];
  [self.tweaknameLabel top:self.iconImage.bottomAnchor padding:5];

}


-(void)layoutCollectionView {

  self.screenshotArray = [[NSMutableArray alloc] initWithObjects:
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss1.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss2.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss3.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss4.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss5.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss6.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss7.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss8.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss9.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss10.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss11.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss12.png"],
  [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PhoenixPrefs.bundle/Assets/Payment/ss13.png"],
  nil];

  self.collectionView = [[TDCyclePagerView alloc]init];
  self.collectionView.isInfiniteLoop = YES;
  self.collectionView.autoScrollInterval = 2.0;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.collectionView.backgroundColor = UIColor.clearColor;
  [self.collectionView registerClass:[PHXPurchaseCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.view addSubview:self.collectionView];

  [self.collectionView width:self.view.frame.size.width];
  [self.collectionView height:300];
  [self.collectionView x:self.view.centerXAnchor];
  [self.collectionView top:self.view.topAnchor padding:130];
}


- (NSInteger)numberOfItemsInPagerView:(TDCyclePagerView *)pageView {
  return self.screenshotArray.count;
}


- (UICollectionViewCell *)pagerView:(TDCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {

  PHXPurchaseCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndex:index];
  cell.screenshotImage.image = [self.screenshotArray objectAtIndex:index];
  return cell;

}


- (TDCyclePagerViewLayout *)layoutForPagerView:(TDCyclePagerView *)pageView {
  TDCyclePagerViewLayout *layout = [[TDCyclePagerViewLayout alloc]init];
  layout.itemSize = CGSizeMake(300, 300);
  layout.itemSpacing = 15;
  layout.minimumAlpha = 0.3;
  layout.itemHorizontalCenter = YES;
  layout.layoutType = 1;
  return layout;
}


- (void)pagerView:(TDCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
  NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}


-(void)pagerView:(TDCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
}


-(void)layoutViews {


  self.cancelButton = [[UIButton alloc] init];
  [self.cancelButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
  [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
  [self.cancelButton setTitleColor:[UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00] forState:UIControlStateNormal];
  self.cancelButton.backgroundColor = UIColor.clearColor;
  self.cancelButton.layer.cornerRadius = 15;
  [self.view addSubview:self.cancelButton];

  [self.cancelButton size:CGSizeMake(250, 50)];
  [self.cancelButton x:self.view.centerXAnchor];
  [self.cancelButton bottom:self.view.bottomAnchor padding:-20];


  NSString *purchaseString = [NSString stringWithFormat:@"Purchase %@", priceString];
  self.purchaseButton = [[UIButton alloc] initWithFrame:CGRectZero];
  [self.purchaseButton addTarget:self action:@selector(purchaseTweak) forControlEvents:UIControlEventTouchUpInside];
  [self.purchaseButton setTitle:purchaseString forState:UIControlStateNormal];
  self.purchaseButton.backgroundColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
  self.purchaseButton.layer.cornerRadius = 15;
  [self.view addSubview:self.purchaseButton];

  [self.purchaseButton size:CGSizeMake(270, 50)];
  [self.purchaseButton x:self.view.centerXAnchor];
  [self.purchaseButton bottom:self.cancelButton.topAnchor padding:-10];


  self.paypalImage = [[UIImageView alloc] init];
  self.paypalImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Payment/PayPal.png"];
  [self.view addSubview:self.paypalImage];

  [self.paypalImage size:CGSizeMake(30, 21)];
  [self.paypalImage x:self.view.centerXAnchor padding:-20];
  [self.paypalImage bottom:self.purchaseButton.topAnchor padding:-5];


  self.stripeImage = [[UIImageView alloc] init];
  self.stripeImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Payment/Stripe.png"];
  [self.view addSubview:self.stripeImage];

  [self.stripeImage size:CGSizeMake(30, 21)];
  [self.stripeImage x:self.view.centerXAnchor padding:20];
  [self.stripeImage bottom:self.purchaseButton.topAnchor padding:-5];


  self.helpImage = [[UIImageView alloc] init];
  self.helpImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Payment/payment-help.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.helpImage.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];
  self.helpImage.userInteractionEnabled = true;
  [self.view addSubview:self.helpImage];

  [self.helpImage size:CGSizeMake(35, 35)];
  [self.helpImage bottom:self.view.bottomAnchor padding:-20];
  [self.helpImage trailing:self.view.trailingAnchor padding:-20];

  [self.helpImage addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(helpTapped)]];
}


-(void)layoutConfetti {

  self.confettiView = [[TDConfettiView alloc] initWithFrame:self.view.bounds];
  self.confettiView.colors = @[
  [UIColor colorWithRed:0.95 green:0.40 blue:0.27 alpha:1.0],
  [UIColor colorWithRed:1.00 green:0.78 blue:0.36 alpha:1.0],
  [UIColor colorWithRed:0.48 green:0.78 blue:0.64 alpha:1.0],
  [UIColor colorWithRed:0.30 green:0.76 blue:0.85 alpha:1.0],
  [UIColor colorWithRed:0.58 green:0.39 blue:0.55 alpha:1.0]];

  self.confettiView.type = TDConfettiTypeConfetti;
  self.confettiView.alpha = 0;
  [self.view addSubview:self.confettiView];

}


- (void)handleNetworkChange:(NSNotification *)notice{

  Reachability *_reachability = [Reachability reachabilityForInternetConnection];
  NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];
  if (remoteHostStatus == NotReachable) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:tweaknameString message:@"The internet connection appears to be offline. Please connect to the internet." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

    [self.activityIndicator startAnimating];

  } else if (remoteHostStatus == ReachableViaWiFi) {

    [self.activityIndicator stopAnimating];

  } else if (remoteHostStatus == ReachableViaWWAN) {

    [self.activityIndicator stopAnimating];

  }
}


-(void)purchaseTweak {

  [[TDUtilities sharedInstance] haptic:0];

  NSString *purchaseURLString = [NSString stringWithFormat:@"https://payments.titand3v.com/?udid=%@&tn=%@", UDID, tweaknameString];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:purchaseURLString]];
  [self dismissVC];
}


- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {

  UDID = (__bridge_transfer NSString *)MGCopyAnswer(kMGUniqueDeviceID);
  NSString *finalURL = [NSString stringWithFormat:@"%@%@&tweak=%@", URL, UDID, tweaknameString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  [request setURL:[NSURL URLWithString:finalURL]];
  [request setHTTPMethod:@"GET"];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(!data){
      dispatch_async(dispatch_get_main_queue(), ^{
        writeToPlist(@"isT", @"NOTHING");
        writeToPlist(@"isU", @"NOTHING");
        writeToPlist(@"mT", @"NOTHING");
        writeToPlist(@"uT", @"NOTHING");
        writeToPlist(@"udd", @"NOTHING");
        writeToPlist(@"stp", @"NOTHING");
      });
      return;
    }
    NSString *resString = decryptString([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    id J = [NSJSONSerialization JSONObjectWithData:[resString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    id T = [NSJSONSerialization JSONObjectWithData:[J[@"trialStatus"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    id U = [NSJSONSerialization JSONObjectWithData:[J[@"udidStatus"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    NSString *isT = T[@"status"];
    NSString *isU = U[@"status"];
    NSString *mT = U[@"msg"];
    NSString *uT = T[@"msg"];
    NSString *udd = T[@"udid"];

    NSString *stp = T[@"stamp"];

    if(([isT isEqual:@"YES"] || [isU isEqual:@"YES"]) && (![mT isEqual:@"Trial not found"] || ![uT isEqual:@"License not found"]) && [udd isEqual:UDID]){
      dispatch_async(dispatch_get_main_queue(), ^{
        if (showConfetti) {
          self.confettiView.alpha = 1;
          [self.confettiView startConfetti];
          [self performSelector:@selector(stopConfetti) withObject:nil afterDelay:5];
          [[TDPrefsManager sharedInstance] setBool:NO forKey:@"showConfetti"];
        }
      });
    }

    writeToPlist(@"isT", T[@"status"]);
    writeToPlist(@"isU", U[@"status"]);
    writeToPlist(@"mT", mT);
    writeToPlist(@"uT", uT);
    writeToPlist(@"udd", udd);
    writeToPlist(@"stp", stp);
  }] resume];

  [controller dismissViewControllerAnimated:YES completion:nil];
}


-(void)helpTapped {

  [[TDUtilities sharedInstance] haptic:0];

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Need some help?" message:@"😟" preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* loadingAction = [UIAlertAction actionWithTitle:@"Not Loading" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    helpActionIndex = 0;
    [self helpAlert];
  }];

  UIAlertAction* trialAction = [UIAlertAction actionWithTitle:@"Can't Activate Trial" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    helpActionIndex = 1;
    [self helpAlert];
  }];

  UIAlertAction* purchaseAction = [UIAlertAction actionWithTitle:@"Can't Purchase" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    helpActionIndex = 2;
    [self helpAlert];
  }];

  UIAlertAction* licenceAction = [UIAlertAction actionWithTitle:@"Licence Transfer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    helpActionIndex = 3;
    [self helpAlert];
  }];

  UIAlertAction* contactAction = [UIAlertAction actionWithTitle:@"Contact Us" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    helpActionIndex = 4;
    [self helpAlert];
  }];

  UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
  }];

  [alert addAction:loadingAction];
  [alert addAction:trialAction];
  [alert addAction:purchaseAction];
  [alert addAction:licenceAction];
  [alert addAction:contactAction];
  [alert addAction:cancelAction];
  [self presentViewController:alert animated:YES completion:nil];
}


-(void)helpAlert {

  if (helpActionIndex == 0) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Not Loading" message:@"Please make sure you are connected to the internet or try using a fast Wi-Fi connection." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (helpActionIndex == 1) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Can't Activate Trial" message:@"If you can't activate trial then it could be that you already used the free trial and it has expired." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (helpActionIndex == 2) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Can't Purchase" message:@"If you can't purchase the tweak, please try to connect to the internet or open the link in your Safari web browser. You can check if PayPal or Stripe is available in your country." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* paypalAction = [UIAlertAction actionWithTitle:@"PayPal available countries list" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://www.paypal.com/uk/webapps/mpp/country-worldwide"];
    }];

    UIAlertAction* stripeAction = [UIAlertAction actionWithTitle:@"Stripe available countries list" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://stripe.com/global"];
    }];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];

    [alert addAction:paypalAction];
    [alert addAction:stripeAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (helpActionIndex == 3) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Licence Transfer" message:@"If you have a new device or want to use the tweak on your other device then please contact us through our social media below, send us proof of your purchase and UDID of the device you want to transfer the licence to. You are entitled to a maxium of 2 licences." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* twitterAction = [UIAlertAction actionWithTitle:@"Contact us via Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://twitter.com/D3vTitan"];
    }];

    UIAlertAction* discordAction = [UIAlertAction actionWithTitle:@"Contact us via Discord" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://discord.com/invite/Kk4KYpZ528"];
    }];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];

    [alert addAction:twitterAction];
    [alert addAction:discordAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

  } else if (helpActionIndex == 4) {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Contact Us" message:@"You can contact us through our social media below" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* twitterAction = [UIAlertAction actionWithTitle:@"Contact us via Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://twitter.com/D3vTitan"];
    }];

    UIAlertAction* discordAction = [UIAlertAction actionWithTitle:@"Contact us via Discord" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
      [self dismissVC];
      [[TDUtilities sharedInstance] launchURL:@"https://discord.com/invite/Kk4KYpZ528"];
    }];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];

    [alert addAction:twitterAction];
    [alert addAction:discordAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

  }

}

-(void)stopConfetti {
  [self.confettiView stopConfetti];
  self.confettiView.alpha = 0;
}


-(void)dismissVC {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
