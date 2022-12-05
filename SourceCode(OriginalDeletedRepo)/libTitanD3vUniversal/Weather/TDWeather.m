#import "TDWeather.h"
#import <objc/runtime.h>

@interface WFTemperature : NSObject
@property (assign,nonatomic) double celsius;
@property (assign,nonatomic) double fahrenheit;
@property (assign,nonatomic) double kelvin;
@end

@interface WADayForecast : NSObject
@property (nonatomic,copy) WFTemperature * high;
@property (nonatomic,copy) WFTemperature * low;
@end

@interface WACurrentForecast : NSObject
-(WFTemperature *)feelsLike;
@end

@interface WAForecastModel : NSObject
-(NSDate *)sunrise;
-(NSDate *)sunset;
-(NSArray *)dailyForecasts;
@end

@interface WALockscreenWidgetViewController : UIViewController
-(WAForecastModel *)currentForecastModel;
-(id)_temperature;
-(id)_conditionsLine;
-(id)_locationName;
-(id)_conditionsImage;
-(void)_updateTodayView;
-(void)updateWeather;
@end

@interface TDWeather()
@property (nonatomic, retain, readonly) WALockscreenWidgetViewController *weatherWidget;
@end

@implementation TDWeather
@dynamic currentTemperature;
@dynamic currentConditions;
@dynamic currentLocation;
@dynamic currentConditionsImage;
@dynamic sunrise;
@dynamic sunset;
@dynamic weatherData;
@synthesize weatherWidget = _weatherWidget;

+ (instancetype)sharedInstance {
	static dispatch_once_t p = 0;
	static __strong TDWeather *_sharedSelf = nil;
	dispatch_once(&p, ^{
		_sharedSelf = [[TDWeather alloc] init];
	});
	return _sharedSelf;
}

- (WALockscreenWidgetViewController *)weatherWidget {
	if (_weatherWidget) {
		return _weatherWidget;
	}
	_weatherWidget = [[objc_getClass("WALockscreenWidgetViewController") alloc] init];
	return _weatherWidget;
}

-(void)refreshWeatherData {
	if ([self.weatherWidget respondsToSelector:@selector(updateWeather)]) {
		[self.weatherWidget updateWeather];
	}
	if ([self.weatherWidget respondsToSelector:@selector(_updateTodayView)]) {
		[self.weatherWidget _updateTodayView];
	}
}

-(NSDictionary *)weatherData {
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	if (self.currentTemperature) [data setObject:self.currentTemperature forKey:@"temperature"]; else [data setObject:@"N/A" forKey:@"temperature"];
	if (self.currentConditions) [data setObject:self.currentConditions forKey:@"conditions"]; else [data setObject:@"N/A" forKey:@"conditions"];
	if (self.currentLocation) [data setObject:self.currentLocation forKey:@"location"]; else [data setObject:@"N/A" forKey:@"location"];
	if (self.sunrise) [data setObject:self.sunrise forKey:@"sunrise"];
	if (self.sunset) [data setObject:self.sunset forKey:@"sunset"];
	UIImage *currentConditionsImage = self.currentConditionsImage;
	if (currentConditionsImage) {
		[data setObject:currentConditionsImage forKey:@"conditionsImage"];
	}
	return data;
}

-(NSString *)currentTemperature {
	if ([self.weatherWidget respondsToSelector:@selector(_temperature)]) {
		return [self.weatherWidget _temperature];
	}
	return @"N/A";
}

-(NSString *)currentConditions {
	if ([self.weatherWidget respondsToSelector:@selector(_conditionsLine)]) {
		return [self.weatherWidget _conditionsLine];
	}
	return @"N/A";
}

-(NSString *)currentLocation {
	if ([self.weatherWidget respondsToSelector:@selector(_locationName)]) {
		return [self.weatherWidget _locationName];
	}
	return @"N/A";
}

-(UIImage *)currentConditionsImage {
	if ([self.weatherWidget respondsToSelector:@selector(_conditionsImage)]) {
		return [self.weatherWidget _conditionsImage];
	}
	return NULL;
}

-(NSDate *)sunrise {
	if ([self.weatherWidget respondsToSelector:@selector(currentForecastModel)]) {
		if ([self.weatherWidget currentForecastModel]) {
			return [[self.weatherWidget currentForecastModel] sunrise];
		}
	}
	return NULL;
}

-(NSDate *)sunset {
	if ([self.weatherWidget respondsToSelector:@selector(currentForecastModel)]) {
		if ([self.weatherWidget currentForecastModel]) {
			return [[self.weatherWidget currentForecastModel] sunset];
		}
	}
	return NULL;
}

-(NSString *)highestTemperatureIn:(int)type {
	/*
	0: celsius
	1: fahrenheit
	2: kelvin
	*/
	if ([self.weatherWidget respondsToSelector:@selector(currentForecastModel)]) {
		if ([self.weatherWidget currentForecastModel]) {
			WADayForecast *dailyForecast = [[self.weatherWidget currentForecastModel] dailyForecasts][0];
			if (type == 0) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.high.celsius];
			} else if (type == 1) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.high.fahrenheit];
			} else if (type == 2) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.high.kelvin];
			} else {
				return @"BAD TYPE";
			}
		}
	}
	return NULL;
}

-(NSString *)lowestTemperatureIn:(int)type {
	/*
	0: celsius
	1: fahrenheit
	2: kelvin
	*/
	if ([self.weatherWidget respondsToSelector:@selector(currentForecastModel)]) {
		if ([self.weatherWidget currentForecastModel]) {
			WADayForecast *dailyForecast = [[self.weatherWidget currentForecastModel] dailyForecasts][0];
			if (type == 0) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.low.celsius];
			} else if (type == 1) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.low.fahrenheit];
			} else if (type == 2) {
				return [NSString stringWithFormat:@"%.0f°", dailyForecast.low.kelvin];
			} else {
				return @"BAD TYPE";
			}
		}
	}
	return NULL;
}

@end
