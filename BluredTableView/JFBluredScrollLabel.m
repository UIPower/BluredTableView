//
//  JFBluredScrollLabel.m
//  BluredTableView
//
//  Created by Jernej Fijačko on 29. 12. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import "JFBluredScrollLabel.h"
#import "UIScrollView+BluredBackground.h"

@implementation JFBluredScrollLabel  {
    __unsafe_unretained UIScrollView *_scrollView;
}

@synthesize scrollView = _scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    self.scrollView = nil;
}

#pragma mark - ScrollView setter

- (void)setScrollView:(UIScrollView *)scrollView
{
    [self unregisterObserver];
    _scrollView = scrollView;
    [self registerObserver];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self repositionBluredBackground];
}

#pragma mark - Key/value observing

- (void)registerObserver
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unregisterObserver
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        [self repositionBluredBackground];
    }
}

#pragma mark - Blured background

- (void)repositionBluredBackground
{
    CGRect subFrame = [self.superview convertRect:self.frame toView:_scrollView.superview];
    CGPoint newOrigin = CGPointMake(subFrame.origin.x,
                                    subFrame.origin.y);
    UIImage *image = [_scrollView lightBluredBackground];
    CGFloat imgScale = image.scale;
    CGRect labelFrame = self.frame;
    CGRect realRect = CGRectMake(newOrigin.x * imgScale, newOrigin.y * imgScale, labelFrame.size.width * imgScale, labelFrame.size.height * imgScale);
    CGImageRef labelPatternImage = CGImageCreateWithImageInRect(image.CGImage, realRect);
    self.textColor = [UIColor colorWithPatternImage:[UIImage imageWithCGImage:labelPatternImage scale:imgScale orientation:UIImageOrientationUp]];
    CGImageRelease(labelPatternImage);
}

@end
