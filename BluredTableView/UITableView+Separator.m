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

- (void)configureSeparatorForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
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
    separator.alpha = !cell.selected;
    NSIndexPath *cellPath = indexPath;
    if (separator.alpha) {
        if (cellPath.row < [self numberOfRowsInSection:cellPath.section] - 1) {
            NSIndexPath *belowPath = [NSIndexPath indexPathForRow:cellPath.row + 1 inSection:cellPath.section];
            UITableViewCell *belowCell = [self cellForRowAtIndexPath:belowPath];
            separator.alpha = !belowCell.selected;
        }
    }
    separator.frame = CGRectMake(cell.separatorInset.left,
                                 CGRectGetHeight(cell.frame) - hairlineHeight,
                                 CGRectGetWidth(cell.frame) - cell.separatorInset.left - cell.separatorInset.right,
                                 hairlineHeight);
}

- (void)cellDidSelect:(UITableViewCell *)cell
{
    JFBluredScrollSubview *separator = (JFBluredScrollSubview *)[cell viewWithTag:kSeparatorTag];
    separator.alpha = 0.f;
    NSIndexPath *cellPath = [self indexPathForCell:cell];
    if (cellPath.row > 0) {
        NSIndexPath *upperPath = [NSIndexPath indexPathForRow:cellPath.row - 1 inSection:cellPath.section];
        UITableViewCell *upperCell = [self cellForRowAtIndexPath:upperPath];
        JFBluredScrollSubview *separator = (JFBluredScrollSubview *)[upperCell viewWithTag:kSeparatorTag];
        separator.alpha = 0.f;
    }
}

- (void)cellDidDeselect:(UITableViewCell *)cell
{
    JFBluredScrollSubview *separator = (JFBluredScrollSubview *)[cell viewWithTag:kSeparatorTag];
    separator.alpha = 1.f;
    NSIndexPath *cellPath = [self indexPathForCell:cell];
    if (cellPath.row > 0) {
        NSIndexPath *upperPath = [NSIndexPath indexPathForRow:cellPath.row - 1 inSection:cellPath.section];
        UITableViewCell *upperCell = [self cellForRowAtIndexPath:upperPath];
        JFBluredScrollSubview *separator = (JFBluredScrollSubview *)[upperCell viewWithTag:kSeparatorTag];
        separator.alpha = 1.f;
    }
}

@end
