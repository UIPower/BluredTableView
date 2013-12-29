//
//  JFTableViewCell.h
//  BluredTableView
//
//  Created by Jernej Fijačko on 26. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFBluredScrollLabel.h"

@interface JFTableViewCell : UITableViewCell

@property (nonatomic, readonly) JFBluredScrollLabel *bluredLabel;

@end
