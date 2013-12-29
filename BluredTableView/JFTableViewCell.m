//
//  JFTableViewCell.m
//  BluredTableView
//
//  Created by Jernej Fijačko on 26. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import "JFTableViewCell.h"
#import "UITableView+Separator.h"

static CGFloat const kCellPadding = 15.f;

@implementation JFTableViewCell
@synthesize bluredLabel = _bluredLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _bluredLabel = [[JFBluredScrollLabel alloc] init];
        _bluredLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_bluredLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    _bluredLabel.frame = CGRectMake(kCellPadding,
                                    0,
                                    bounds.size.width - 2*kCellPadding,
                                    bounds.size.height);
}

#pragma mark - Separators

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UITableView *tableView = [self presentingTableView];
    if (selected) {
        [tableView hideSeparatorsForCell:self];
    }
    else {
        [tableView showSeparatorsForCell:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    UITableView *tableView = [self presentingTableView];
    if (highlighted) {
        [tableView hideSeparatorsForCell:self];
    }
    else {
        [tableView showSeparatorsForCell:self];
    }
}

- (UITableView *)presentingTableView
{
    UITableView *tableView = nil;
    if ([self.superview isKindOfClass:[UITableView class]]) {
        tableView = (UITableView *)self.superview;
    }
    else if ([self.superview.superview isKindOfClass:[UITableView class]]) {
        tableView = (UITableView *)self.superview.superview;
    }
    return tableView;
}

@end
