#import <UIKit/UIKit.h>
#import "TDCyclePagerTransformLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSInteger index;
    NSInteger section;
}TDIndexSection;


typedef NS_ENUM(NSUInteger, TDPagerScrollDirection) {
    TDPagerScrollDirectionLeft,
    TDPagerScrollDirectionRight,
};

@class TDCyclePagerView;
@protocol TDCyclePagerViewDataSource <NSObject>
- (NSInteger)numberOfItemsInPagerView:(TDCyclePagerView *)pageView;
- (__kindof UICollectionViewCell *)pagerView:(TDCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;
- (TDCyclePagerViewLayout *)layoutForPagerView:(TDCyclePagerView *)pageView;

@end

@protocol TDCyclePagerViewDelegate <NSObject>
@optional

- (void)pagerView:(TDCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
- (void)pagerView:(TDCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;
- (void)pagerView:(TDCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndexSection:(TDIndexSection)indexSection;
- (void)pagerView:(TDCyclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;
- (void)pagerView:(TDCyclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;
- (void)pagerViewDidScroll:(TDCyclePagerView *)pageView;
- (void)pagerViewWillBeginDragging:(TDCyclePagerView *)pageView;
- (void)pagerViewDidEndDragging:(TDCyclePagerView *)pageView willDecelerate:(BOOL)decelerate;
- (void)pagerViewWillBeginDecelerating:(TDCyclePagerView *)pageView;
- (void)pagerViewDidEndDecelerating:(TDCyclePagerView *)pageView;
- (void)pagerViewWillBeginScrollingAnimation:(TDCyclePagerView *)pageView;
- (void)pagerViewDidEndScrollingAnimation:(TDCyclePagerView *)pageView;

@end


@interface TDCyclePagerView : UIView

@property (nonatomic, strong, nullable) UIView *backgroundView;
@property (nonatomic, weak, nullable) id<TDCyclePagerViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id<TDCyclePagerViewDelegate> delegate;
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) TDCyclePagerViewLayout *layout;
@property (nonatomic, assign) BOOL isInfiniteLoop;
@property (nonatomic, assign) CGFloat autoScrollInterval;
@property (nonatomic, assign) BOOL reloadDataNeedResetIndex;
@property (nonatomic, assign, readonly) NSInteger curIndex;
@property (nonatomic, assign, readonly) TDIndexSection indexSection;
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;
- (void)reloadData;
- (void)updateData;
- (void)setNeedUpdateLayout;
- (void)setNeedClearLayout;
- (__kindof UICollectionViewCell * _Nullable)curIndexCell;
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;
- (void)scrollToItemAtIndexSection:(TDIndexSection)indexSection animate:(BOOL)animate;
- (void)scrollToNearlyIndexAtDirection:(TDPagerScrollDirection)direction animate:(BOOL)animate;
- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
