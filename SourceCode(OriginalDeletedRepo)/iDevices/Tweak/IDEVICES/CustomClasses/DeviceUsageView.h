@import UIKit;

@interface DeviceUsageView : UIView
@property (nonatomic,assign) BOOL showValueString;
@property (nonatomic,assign) CGFloat value;
@property (nonatomic,assign) CGFloat maxValue;
@property (nonatomic,assign) CGFloat borderPadding;
@property (nonatomic,assign) NSInteger decimalPlaces;
@property (nonatomic,copy) NSString *valueFontName;
@property (nonatomic,assign) CGFloat valueFontSize;
@property (nonatomic,assign) CGFloat valueDecimalFontSize;
@property (nonatomic,assign) BOOL showUnitString;
@property (nonatomic,copy) NSString *unitFontName;
@property (nonatomic,assign) CGFloat unitFontSize;
@property (nonatomic,copy) NSString *unitString;
@property (nonatomic,strong) UIColor *fontColor;
@property (nonatomic,assign) NSInteger progressAppearanceType;
@property (nonatomic,assign) CGFloat progressRotationAngle;
@property (nonatomic,assign) CGFloat progressAngle;
@property (nonatomic,assign) CGFloat progressLineWidth;
@property (nonatomic,strong) UIColor *progressColor;
@property (nonatomic,strong) UIColor *progressStrokeColor;
@property (nonatomic,assign) NSInteger progressCapType;
@property (nonatomic,assign) CGFloat emptyLineWidth;
@property (nonatomic,strong) UIColor *emptyLineColor;
@property (nonatomic,strong) UIColor *emptyLineStrokeColor;
@property (nonatomic,assign) NSInteger emptyCapType;
@property (nonatomic,assign) CGPoint textOffset;
@property (nonatomic,assign) BOOL countdown;

@end
