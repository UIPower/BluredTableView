//
//  UITableView+Separator.m
//  BluredTableView
//
//  Created by Jernej Fijačko on 20. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import "UITableView+Separator.h"
#import "JFBluredScrollSubview.h"

static NSInteger const kSeparatorTag = 123;

@implementation UITableView (Separator)

- (void)configureSeparatorForCell:(UITableViewCell *)cell
{
    JFBluredScrollSubview *separator = (JFBluredScrollSubview *)[cell viewWithTag:kSeparatorTag];
    if (!separator) {
        separator = [[JFBluredScrollSubview alloc] initWithFrame:CGRectZero];
        separator.tag = kSeparatorTag;
        separator.scrollView = self;
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [cell addSubview:separator];
    }
    CGFloat hairlineHeight = 1.f / [[UIScreen mainScreen] scale];
    separator.frame = CGRectMake(cell.separatorInset.left,
                                 CGRectGetHeight(cell.frame) - hairlineHeight,
                                 CGRectGetWidth(cell.frame) - cell.separatorInset.left - cell.separatorInset.right,
                                 hairlineHeight);
}

@end
