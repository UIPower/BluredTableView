//
//  UITableView+Separator.h
//  BluredTableView
//
//  Created by Jernej Fijačko on 20. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Separator)

- (void)configureSeparatorForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)hideSeparatorsForCell:(UITableViewCell *)cell;
- (void)showSeparatorsForCell:(UITableViewCell *)cell;

@end
