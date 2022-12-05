#import <UIKit/UIKit.h>

@protocol StickerViewDelegate;

@interface StickerView : UIView
@property (assign, nonatomic) BOOL enabledControl;
@property (assign, nonatomic) BOOL enabledDeleteControl;
@property (assign, nonatomic) BOOL enabledShakeAnimation;
@property (assign, nonatomic) BOOL enabledBorder;
@property (strong, nonatomic) UIImage *contentImage;
@property (assign, nonatomic) id<StickerViewDelegate> delegate;
- (instancetype)initWithContentFrame:(CGRect)frame contentImage:(UIImage *)contentImage;
- (void)performTapOperation;
@end


@protocol StickerViewDelegate <NSObject>
@optional
- (void)stickerViewDidTapContentView:(StickerView *)stickerView;
- (void)stickerViewDidTapDeleteControl:(StickerView *)stickerView;
- (UIImage *)stickerView:(StickerView *)stickerView imageForRightTopControl:(CGSize)recommendedSize;
- (void)stickerViewDidTapRightTopControl:(StickerView *)stickerView;
- (UIImage *)stickerView:(StickerView *)stickerView imageForLeftBottomControl:(CGSize)recommendedSize;
- (void)stickerViewDidTapLeftBottomControl:(StickerView *)stickerView; 
@end
