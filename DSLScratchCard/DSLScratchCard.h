//
//  DSLScratchCard.h
//  DSLScratchCard
//
//  Created by 邓顺来 on 16/11/28.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLScratchCard : UIView

/**
 隐藏的image
 */
@property (strong, nonatomic) IBInspectable UIImage *hiddenImage;

/**
 覆盖层的颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *coverColor;

/**
 覆盖层image，设置了这个属性后，coverColor将不起作用
 */
@property (strong, nonatomic) IBInspectable UIImage *coverImage;

/**
 划线粗细，默认15
 */
@property (assign, nonatomic) IBInspectable CGFloat lineWidth;

/**
 便利构造器

 @param hiddenImage 隐藏的image
 @param coverColor  覆盖层的颜色
 @param coverImage  覆盖层的image，设置了这个参数后，coverColor将不起作用

 @return DSLScratchCard 实例
 */
+ (instancetype)scratchCardWithHiddenImage:(UIImage *)hiddenImage
                                coverColor:(UIColor *)coverColor
                                coverImage:(UIImage *)coverImage;

/**
 重置
 */
- (void)reset;

@end
