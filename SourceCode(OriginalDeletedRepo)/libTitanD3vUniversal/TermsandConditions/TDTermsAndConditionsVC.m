#import "TDTermsAndConditionsVC.h"

@implementation TDTermsAndConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed: 0.09 green: 0.09 blue: 0.09 alpha: 1.00];
    
    [self layoutHeaderView];
    [self layoutTextView];
   
}


-(void)layoutHeaderView {
    
    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Terms&Conditions/titand3v.png"];
    [self.view addSubview:self.iconImage];
    
    [self.iconImage size:CGSizeMake(70, 70)];
    [self.iconImage x:self.view.centerXAnchor];
    [self.iconImage top:self.view.topAnchor padding:25];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.whiteColor;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Downloadable Digital Products Terms and Conditions of Sale";
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel x:self.view.centerXAnchor];
    [self.titleLabel top:self.iconImage.bottomAnchor padding:10];
    [self.titleLabel leading:self.view.leadingAnchor padding:20];
    [self.titleLabel trailing:self.view.trailingAnchor padding:-20];
    
}


-(void)layoutTextView {
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.text = @"1.0 Introduction \n\nThese terms and conditions set out the terms and conditions between you, the customer, and TitanD3v (“us”, “we”), governing the use of our repo and our downloadable digital recordings including the content therein (the “products”). Your use of our repo, and purchase, download and use of our products, constitutes your full acceptance of these terms and conditions. If you do not agree with these terms and conditions, you should not use our repo or purchase, download or use any of our products. \n\n2.0 License and Use \n\nYour purchase of one of our products constitutes our granting to you of a non-exclusive, non-sublicensable, non-transferable license to download and access that product for the purpose of your own personal use and reference, and print or convert the product to an image or vector format for your own storage, retention and reference (the “purpose”). You agree that under no circumstances shall you use, or permit to be used, any product other than for the aforesaid purpose. For the avoidance of doubt, you shall not copy, re-sell, sublicense, rent out, share or otherwise distribute any of our products, whether modified or not, to any third party. You agree not to use any of our products in a way which might be detrimental to us or damage our reputation. \n\n3.0 Intellectual Property \n\nThe products, whether modified or not, and all intellectual property and copyright contained therein, are and shall at all times remain our sole and exclusive property. You agree that under no circumstances, whether the product has been modified or not, shall you have or attempt to claim ownership of any intellectual property rights or copyright in the product. \n\n4.0 Refunds and Chargebacks \n\nOnce a product has been purchased by you, no right of cancellation or refund exists under the Consumer Protection (Distance Selling) Regulations 2000 due to the electronic nature of our products. Any refunds shall be at our sole and absolute discretion. You agree that under no circumstances whatsoever shall you initiate any chargebacks via your payment provider. You agree that any payments made by you for any of our products are final and may not be charged back. We reserve the right to alter any of our prices from time to time. \n\n5.0 Warranties and Liability \n\nWe make every effort to ensure that our products are accurate, authoritaive and fit for the use of our customers. However, we take no responsibility whatsoever for the suitability of the product, and we provide no warranties as to the function or use of the product, whether express, implied or statutory, including without limitation any warranties of merchantability or fitness for particular purpose. You agree to indemnify us against all liabilities, claims, demands, expenses, actions, costs, damages, or loss arising out of your breach of these terms and conditions. Furthermore, we shall not be liable to you or any party for consequential, indirect, special or exemplary damages including but not limited to damages for loss of profits, business or anticipated benefits whether arising under tort, contract, negligence or otherwise whether or not foreseen, reasonably foreseeable or advised of the possibility of such damages. \n\n6.0 General \n\nThese terms and conditions constitute the entire agreement and understanding between you and us for the supply of downloadable digital products, and shall supersede any prior agreements whether made in writing, orally, implied or otherwise. The failure by us to exercise or enforce any right(s) under these terms and conditions shall not be deemed to be a waiver of any such right(s) or operate so as to bar the exercise or enforcement thereof at any time(s) thereafter, as a waiver of another or constitute a continuing waiver. You agree that monetary damages may not be a sufficient remedy for the damage which may accrue to us by reason of your breach of these terms and conditions, therefore we shall be entitled to seek injunctive relief to enforce the obligations contained herein. The unenforceability of any single provision within these terms and conditions shall not affect any other provision hereof. These terms and conditions, your acceptance thereof, and our relationship with you shall be governed by and construed in accordance with English law and both us and you irrevocably submit to the exclusive jurisdiction of the English courts over any claim, dispute or matter arising under or in connection with these terms and conditions or our relationship with you. \n\nContacting Us \n\nPlease do not hesitate to contact us regarding any matter relating to this Downloadable Digital Products Terms and Conditions of Sale Policy via email support@titand3v.com";
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.backgroundColor = UIColor.clearColor;
    self.textView.textColor = UIColor.whiteColor;
    [self.view addSubview:self.textView];
    
    [self.textView top:self.titleLabel.bottomAnchor padding:20];
    [self.textView leading:self.view.leadingAnchor padding:10];
    [self.textView trailing:self.view.trailingAnchor padding:-10];
    [self.textView bottom:self.view.bottomAnchor padding:0];
   
}


@end
