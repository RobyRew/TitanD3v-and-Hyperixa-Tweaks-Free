@class UIImage;

@interface TDWeather : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, copy, readonly) NSString *currentTemperature;
@property (nonatomic, copy, readonly) NSString *currentConditions;
@property (nonatomic, copy, readonly) NSString *currentLocation;
@property (nonatomic, strong, readonly) UIImage *currentConditionsImage;
@property(nonatomic, strong, readonly) NSDate *sunrise;
@property(nonatomic, strong, readonly) NSDate *sunset;
@property (nonatomic, strong, readonly) NSDictionary *weatherData;
- (void)refreshWeatherData;

-(NSString *)highestTemperatureIn:(int)type;
-(NSString *)lowestTemperatureIn:(int)type;
@end