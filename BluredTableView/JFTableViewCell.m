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
    if ([self.superview.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview.superview;
        if (selected) {
            [tableView cellDidSelect:self];
        }
        else {
            [tableView cellDidDeselect:self];
        }
    }
}

@end
