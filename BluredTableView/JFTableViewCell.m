//
//  JFTableViewCell.m
//  BluredTableView
//
//  Created by Jernej Fijačko on 26. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import "JFTableViewCell.h"
#import "UITableView+Separator.h"

@implementation JFTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
