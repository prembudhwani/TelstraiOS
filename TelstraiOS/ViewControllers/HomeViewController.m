//
//  HomeViewController.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 04/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIView+WebCache.h>
#import "Row+CoreDataProperties.h"

#define TOP_MARGIN 20.0
#define RIGHT_MARGIN -10.0
#define BOTTOM_MARGIN -10.0
#define LEFT_MARGIN 10.0

#define CellID @"cellidentifier1"
#define REST_API_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillLayoutSubviews {
    [self setUpAutoLayoutConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Add TableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //Properties to set the cells as self sizing cells
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    
    //Register the HomeTableViewCell to tableView
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:CellID];
    self.tableView.dataSource = self;
    
    //Add Refresh button to the navigation bar
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshList)]];
    
    //Add an ActivityIndicatorView for showing loader while data is being fetched from URL
    self.loaderView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loaderView.hidesWhenStopped = YES;
    [self.view addSubview:self.loaderView];
    [self.view bringSubviewToFront:self.loaderView];
    
    [self refreshList];
}

//Method to fetch list of Rows along with Fact from the REST API URL
- (void)refreshList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIBarButtonItem *refreshBtn = self.navigationItem.rightBarButtonItem;
        refreshBtn.enabled = NO;
        [self.loaderView startAnimating];
    });
    
    DataManager *dataManager = [[DataManager alloc]init];
    dataManager.delegate = self;
    [dataManager fetchDataFromURL:REST_API_URL];
}

- (void)setUpAutoLayoutConstraints
{
    //Set up AutoLayout Constraints for tableView
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view removeConstraints:self.view.constraints];        //Remove all constraints first
    
    //Top Margin Constraint
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.navigationController.navigationBar.frame.size.height + TOP_MARGIN];
    
    //Right Margin Constraint
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:RIGHT_MARGIN];
    
    //Bottom Margin Constraint
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:BOTTOM_MARGIN];
    
    //Left Margin Constraint
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:LEFT_MARGIN];
    
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:rightConstraint];
    [self.view addConstraint:bottomConstraint];
    [self.view addConstraint:leftConstraint];
    
    //Set up AutoLayout Constraints for ActivityIndicatorView
    self.loaderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Center align constraint for ActivityIndicatorView
    NSLayoutConstraint *centerAlignConstraintHorizontal = [NSLayoutConstraint constraintWithItem:self.loaderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    NSLayoutConstraint *centerAlignConstraintVertical = [NSLayoutConstraint constraintWithItem:self.loaderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self.view addConstraint:centerAlignConstraintHorizontal];
    [self.view addConstraint:centerAlignConstraintVertical];
    
}


#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    Row *rowObject = [self.arrTableData objectAtIndex:indexPath.row];
    
    cell.lblHeading.text = rowObject.rowTitle;
    cell.lblDescription.text = rowObject.rowDescription;
    
    if([rowObject.rowImageHref isEqualToString:@""])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgThumbnail.image = [UIImage imageNamed:@"no_image_icon"];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.imgThumbnail sd_setShowActivityIndicatorView:YES];
            [cell.imgThumbnail sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.imgThumbnail sd_setImageWithURL:[NSURL URLWithString:rowObject.rowImageHref] placeholderImage:[UIImage imageNamed:@"no_image_icon"] options:SDWebImageRefreshCached];
        });
    }
    
    return cell;
}

#pragma mark DataManagerDelegate methods
- (void)didReceiveFact:(Fact *)factObject
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView setContentOffset:CGPointMake(0.0f, -self.tableView.contentInset.top) animated:YES];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        
        self.navigationItem.title = factObject.factTitle;
        NSArray *originalArray = [factObject.rowsOfFact allObjects];
        self.arrTableData = [originalArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"rowNumber" ascending:YES]]];
        [self.tableView reloadData];
        
        UIBarButtonItem *refreshBtn = self.navigationItem.rightBarButtonItem;
        refreshBtn.enabled = YES;
        [self.loaderView stopAnimating];
    });
}

- (void)didFailWhenFetchingFact:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        UIBarButtonItem *refreshBtn = self.navigationItem.rightBarButtonItem;
        refreshBtn.enabled = YES;
        [self.loaderView stopAnimating];
    });
}

@end
