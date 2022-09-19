#import "CreateCategoryDataSource.h"

@implementation CategoriesIconModel
-(id)initWithImageName:(NSString *)name {
  self = [super init];
  if(self) {
    self.imageName = name;
  }
  return self;
}
@end


@implementation CategoriesColourModel
-(id)initWithColourHex:(NSString *)hex {
  self = [super init];
  if(self) {
    self.colourHEX = hex;
  }
  return self;
}
@end


@implementation CreateCategoryDataSource

+(instancetype)sharedInstance {
  static CreateCategoryDataSource *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[CreateCategoryDataSource alloc] init];
  });
  return sharedInstance;
}


-(id)init {
  return self;
}


-(NSMutableArray *)iconData {

  NSMutableArray *array = [[NSMutableArray alloc] init];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"airplane"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"airpods"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"alarm.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"ant.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"arrow.3.trianglepath"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"arrowtriangle.forward"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bag"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"barcode"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"book"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"books.vertical"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"building.columns"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bus"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"camera"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"cart"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"comb.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"cross"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"desktopcomputer"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"ellipsis"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"envelope"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"face.dashed"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"graduationcap"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"gamecontroller.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"greetingcard"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"guitars"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hare"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"lightbulb"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"mouth"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"radio"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"sportscourt"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"appletv.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hifispeaker"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"keyboard"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"tv.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bicycle"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"figure.walk"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"car"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"tram"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"eye"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"mustache"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"person"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"number"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"percent.ar"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"creditcard"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"giftcard"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"infinity"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"pause"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"play"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"playpause"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"stop"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"heart.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"pills.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"cross.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"staroflife.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"clock.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hourglass.tophalf.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bag.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"cart.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"creditcard.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"giftcard.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"textformat.alt"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"scribble"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"paintbrush.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"paintbrush.pointed.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hare.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bolt.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"flame.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"drop.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"person.crop.circle.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"eye.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"nose.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"mustache.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"mouth.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"face.smiling.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hand.raised.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"ear.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hand.thumbsup.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hand.thumbsdown.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hand.wave.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"car.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"bicycle"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"icloud.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"dpad.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"macpro.gen1"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"laptopcomputer.and.iphone"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"headphones"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"binoculars.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"paintpalette.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"moon.circle.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"moon.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"cloud.moon.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"message.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"phone.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"video.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"sparkles"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"sparkle"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"crown.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"comb.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"briefcase.fill"]];
  [array addObject:[[CategoriesIconModel alloc] initWithImageName:@"hands.sparkles.fill"]];

  return array;
}


-(NSMutableArray *)colourData {

  NSMutableArray *array = [[NSMutableArray alloc] init];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"007AFF"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"31ADE6"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"30B1C7"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"04C7BE"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"35C759"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FFCC01"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FF9500"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FF3C2F"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FF2C55"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"AF52DE"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"5956D5"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"251E3E"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"03396C"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"EEC9D2"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"F27737"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FCF498"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"7BC043"]];
  [array addObject:[[CategoriesColourModel alloc] initWithColourHex:@"FFBBEE"]];
  return array;

}

@end
