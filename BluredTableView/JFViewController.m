//
//  JFViewController.m
//  BluredTableView
//
//  Created by Jernej Fijačko on 20. 10. 13.
//  Copyright (c) 2013 Jernej Fijačko. All rights reserved.
//

#import "JFViewController.h"
#import "UIScrollView+BluredBackground.h"
#import "JFBluredScrollSubview.h"
#import "UIImage+ImageEffects.h"
#import "UITableView+Separator.h"
#import "JFTableViewCell.h"

@interface JFViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JFViewController

@synthesize tableView = _tableView;

- (void)loadView
{
    [super loadView];
    UIImage *backgroundImage = [[UIImage imageNamed:@"BackgroundImage"] applyDarkEffect];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    UIImage *lightBackground = [[UIImage imageNamed:@"BackgroundImage"] applyLightEffect];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.backgroundView = backgroundView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setDarkBluredBackground:backgroundImage];
    [_tableView setLightBluredBackground:lightBackground];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[JFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        JFBluredScrollSubview *subView = [[JFBluredScrollSubview alloc] initWithFrame:cell.bounds];
        subView.scrollView = _tableView;
        cell.selectedBackgroundView = subView;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    return cell;
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.selectedBackgroundView setNeedsLayout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView configureSeparatorForCell:cell atIndexPath:indexPath];
}

#pragma mark - Status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
