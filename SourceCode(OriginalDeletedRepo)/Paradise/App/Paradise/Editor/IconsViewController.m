#import "IconsViewController.h"

@implementation IconsViewController
@synthesize iconDelegate;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Icons";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSymbolCollectionView];
   
}


- (NSArray *)iconsArray {
  NSMutableDictionary *iconsDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Icons" ofType:@"plist"]];
  return [iconsDict objectForKey:@"iconsList"];
}


-(void)layoutSymbolCollectionView {
    
    UICollectionViewFlowLayout *iconLayout = [[UICollectionViewFlowLayout alloc] init];
    self.symbolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:iconLayout];
    self.symbolCollectionView.backgroundColor = UIColor.clearColor;
    self.symbolCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.symbolCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.symbolCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.symbolCollectionView setShowsVerticalScrollIndicator:NO];
    [self.symbolCollectionView registerClass:[GlyphCell class] forCellWithReuseIdentifier:@"GlyphCell"];
    [self.view addSubview:self.symbolCollectionView];

    self.symbolCollectionView.delegate = self;
    self.symbolCollectionView.dataSource = self;
    
    [self.symbolCollectionView top:self.view.topAnchor padding:0];
    [self.symbolCollectionView leading:self.view.leadingAnchor padding:10];
    [self.symbolCollectionView trailing:self.view.trailingAnchor padding:-10];
    [self.symbolCollectionView bottom:self.view.bottomAnchor padding:-10];
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [[self iconsArray] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

  GlyphCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GlyphCell" forIndexPath:indexPath];

  cell.backgroundColor = UIColor.clearColor;
  cell.iconImage.image = [[UIImage systemImageNamed:[[self iconsArray] objectAtIndex:indexPath.row]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.iconImage.tintColor = UIColor.labelColor;
  cell.iconImage.contentMode = UIViewContentModeScaleAspectFit;

  return cell;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [iconDelegate sendDataToEditor:[UIImage systemImageNamed:[[self iconsArray] objectAtIndex:indexPath.row]]];
    [self dismissVC];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return CGSizeMake(50, 50);

}


-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
