#import "TDScrollView.h"

@interface TDScrollView () <UIScrollViewDelegate>
@end

@implementation TDScrollView {
    UIScrollView *scrollView;
}

- (void)configure {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat circumference = 2 * M_PI * radius;
    CGFloat initialOffset = M_PI_4 / (2 * M_PI) * circumference;
    CGRect frame = self.bounds;
    frame.size.width = initialOffset;
    scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.clipsToBounds = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.contentSize = CGSizeMake(100000, self.bounds.size.height);
    [scrollView setContentOffset:CGPointMake(initialOffset * 200, 0)];
    [self addSubview:scrollView];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        if ([self.subviews count] == 0) return nil;
        else return [self.subviews lastObject];
    }
    return nil;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat circumference = 2 * M_PI * radius;
    CGFloat offset = fmod(scrollView.contentOffset.x, circumference);
    [self.delegate scrollViewDidChangeProgress:offset / circumference];
}


@end
