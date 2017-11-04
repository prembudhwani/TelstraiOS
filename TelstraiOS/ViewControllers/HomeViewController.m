//
//  HomeViewController.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 04/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "HomeViewController.h"

#define TOP_MARGIN 20.0
#define RIGHT_MARGIN -10.0
#define BOTTOM_MARGIN -10.0
#define LEFT_MARGIN 10.0

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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

