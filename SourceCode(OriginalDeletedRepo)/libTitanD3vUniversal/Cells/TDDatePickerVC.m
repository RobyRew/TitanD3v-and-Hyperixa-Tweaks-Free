#import "TDDatePickerVC.h"

@implementation TDDatePickerVC

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = UIColor.clearColor;

	self.blurEffectView = [[UIVisualEffectView alloc] init];
	self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	self.blurEffectView.alpha = 0;
	self.blurEffectView.userInteractionEnabled = true;
	[self.view insertSubview:self.blurEffectView atIndex:0];

	self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
	[self.blurEffectView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;


	UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
	dismissGesture.delegate = self;
	[self.blurEffectView addGestureRecognizer:dismissGesture];


	[self performSelector:@selector(setDimming) withObject:nil afterDelay:0.3];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}


-(void)setDimming {
	[UIView animateWithDuration:0.4 animations:^ {
		self.blurEffectView.alpha = 1;
	}];
}


-(void)tapGestureFired {
	[[TDUtilities sharedInstance] haptic:0];

	[UIView animateWithDuration:0.2 animations:^ {
		self.blurEffectView.alpha = 0;
	}];
	[self performSelector:@selector(dismissVC) withObject:nil afterDelay:0.1];
}


-(void)dismissVC {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
