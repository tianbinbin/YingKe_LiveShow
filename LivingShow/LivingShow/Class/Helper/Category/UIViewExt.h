/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;                    //  中心点
@property CGSize size;                       //  大小

@property (readonly) CGPoint bottomLeft;     //  左下
@property (readonly) CGPoint bottomRight;    //  右下
@property (readonly) CGPoint topRight;       //  右上

@property CGFloat height;                    // 高度
@property CGFloat width;                     // 宽度

@property CGFloat top;                       // 上边
@property CGFloat left;                      // 左边

@property CGFloat bottom;                    // 下边
@property CGFloat right;                     // 右边

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end