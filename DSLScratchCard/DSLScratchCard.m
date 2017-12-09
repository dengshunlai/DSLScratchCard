//
//  DSLScratchCard.m
//  DSLScratchCard
//
//  Created by 邓顺来 on 16/11/28.
//  Copyright © 2016年 邓顺来. All rights reserved.
//

#import "DSLScratchCard.h"

@interface DSLScratchCard ()

@property (strong, nonatomic) UIImageView *hiddenImageView;
@property (strong, nonatomic) UIImageView *coverImageView;

@end

@implementation DSLScratchCard

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.backgroundColor = [UIColor clearColor];
    _hiddenImageView = [[UIImageView alloc] init];
    _hiddenImageView.contentMode = UIViewContentModeScaleAspectFill;
    _hiddenImageView.clipsToBounds = YES;
    _hiddenImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _coverImageView = [[UIImageView alloc] init];
    _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_hiddenImageView];
    [self addSubview:_coverImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hiddenImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hiddenImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hiddenImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hiddenImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_coverImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_coverImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_coverImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_coverImageView)]];
    
    _lineWidth = 25;
    self.coverColor = [UIColor lightGrayColor];
}

+ (instancetype)scratchCardWithHiddenView:(UIView *)hiddenView
                              hiddenImage:(UIImage *)hiddenImage
                               coverColor:(UIColor *)coverColor
                               coverImage:(UIImage *)coverImage
{
    DSLScratchCard *card = [[DSLScratchCard alloc] init];
    card.hiddenView = hiddenView;
    card.hiddenImage = hiddenImage;
    card.coverColor = coverColor;
    card.coverImage = coverImage;
    return card;
}

#pragma mark - Set method

- (void)setHiddenView:(UIView *)hiddenView
{
    if (_hiddenView != hiddenView) {
        [_hiddenView removeFromSuperview];
        _hiddenView = hiddenView;
        [self setup];
    }
}

- (void)setHiddenImage:(UIImage *)hiddenImage
{
    _hiddenImage = hiddenImage;
    [self setup];
}

- (void)setCoverColor:(UIColor *)coverColor
{
    _coverColor = coverColor;
    [self setup];
}

- (void)setCoverImage:(UIImage *)coverImage
{
    _coverImage = coverImage;
    [self setup];
}

#pragma mark - API

- (void)reset
{
    if (_coverImage) {
        _coverImageView.image = _coverImage;
    } else {
        _coverImageView.image = [self imageWithColor:_coverColor];
    }
}

#pragma mark - Other

- (void)setup {
    if (_hiddenView) {
        if (![self.subviews containsObject:_hiddenView]) {
            [self insertSubview:_hiddenView belowSubview:_coverImageView];
            _hiddenView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hiddenView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hiddenView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hiddenView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hiddenView)]];
        }
    } else {
        _hiddenImageView.image = _hiddenImage;
    }
    if (_coverImage) {
        _coverImageView.image = _coverImage;
    } else {
        _coverImageView.image = [self imageWithColor:_coverColor];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(4, 4), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 4, 4));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Touch method

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pre = [touch previousLocationInView:self];
    CGPoint current = [touch locationInView:self];
    if (pow(current.x - pre.x, 2) + pow(current.y - pre.y, 2) < pow(2, 2)) {
        return;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(_coverImageView.bounds.size.width, _coverImageView.bounds.size.height), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_coverImageView.image drawInRect:_coverImageView.bounds];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextMoveToPoint(context, pre.x, pre.y);
    CGContextAddLineToPoint(context, current.x, current.y);
    CGContextStrokePath(context);
    _coverImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end

