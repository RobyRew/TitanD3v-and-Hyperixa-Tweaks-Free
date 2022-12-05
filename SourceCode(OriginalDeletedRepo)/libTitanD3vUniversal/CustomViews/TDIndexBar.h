#import <UIKit/UIKit.h>

@class TDIndexBar;
@protocol TDIndexBarDelegate<NSObject>
- (void)indexDidChanged:(TDIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title;
@end


@interface TDIndexBar : UIView
@property (nonatomic, weak) id <TDIndexBarDelegate> delegate;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *detailViewDrawColor;
@property (nonatomic, strong) UIColor *detailViewTextColor;
@property (nonatomic, assign) BOOL onTouch;
@property (nonatomic, assign) BOOL hideDetailView;
@property (nonatomic, assign) CGFloat sectionHeight;
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)setIndexes:(NSArray *)indexes;
- (void)setSelectedLabel:(NSInteger)index;
@end







