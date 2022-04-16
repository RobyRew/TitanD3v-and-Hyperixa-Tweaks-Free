#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TDCyclePagerTransformLayoutType) {
    TDCyclePagerTransformLayoutNormal,
    TDCyclePagerTransformLayoutLinear,
    TDCyclePagerTransformLayoutCoverflow,
};

@class TDCyclePagerTransformLayout;
@protocol TDCyclePagerTransformLayoutDelegate <NSObject>
- (void)pagerViewTransformLayout:(TDCyclePagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;
- (void)pagerViewTransformLayout:(TDCyclePagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;
@end


@interface TDCyclePagerViewLayout : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) TDCyclePagerTransformLayoutType layoutType;
@property (nonatomic, assign) CGFloat minimumScale; // sacle default 0.8
@property (nonatomic, assign) CGFloat minimumAlpha; // alpha default 1.0
@property (nonatomic, assign) CGFloat maximumAngle; // angle is % default 0.2
@property (nonatomic, assign) BOOL isInfiniteLoop;  // infinte scroll
@property (nonatomic, assign) CGFloat rateOfChange; // scale and angle change rate
@property (nonatomic, assign) BOOL adjustSpacingWhenScroling;
@property (nonatomic, assign) BOOL itemVerticalCenter;
@property (nonatomic, assign) BOOL itemHorizontalCenter;
@property (nonatomic, assign, readonly) UIEdgeInsets onlyOneSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets firstSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets lastSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets middleSectionInset;

@end


@interface TDCyclePagerTransformLayout : UICollectionViewFlowLayout
@property (nonatomic, strong) TDCyclePagerViewLayout *layout;
@property (nonatomic, weak, nullable) id<TDCyclePagerTransformLayoutDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
