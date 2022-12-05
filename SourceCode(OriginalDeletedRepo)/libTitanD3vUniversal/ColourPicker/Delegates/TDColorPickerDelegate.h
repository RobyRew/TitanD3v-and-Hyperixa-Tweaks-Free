#ifndef TDColorPickerDelegate_h
#define TDColorPickerDelegate_h

@protocol TDColorPickerDelegate <NSObject>

@optional
- (void)colorPickerDismissedWithColor:(UIColor *)color;
- (void)colorPickerDidUpdateColor:(UIColor *)color;
- (void)colorPickerDidChangeColor:(UIColor *)color;

@end

#endif /* TDColorPickerDelegate_h */
