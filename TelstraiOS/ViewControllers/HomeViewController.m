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

#define TOP_MARGIN 20.0
#define RIGHT_MARGIN -10.0
#define BOTTOM_MARGIN -10.0
#define LEFT_MARGIN 10.0

#define CellID @"cellidentifier1"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //Properties to set the cells as self sizing cells
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    
    self.arrTableData = @[
                          @{
                              @"title": @"Beavers",
                              @"description": @"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                              @"imageHref": @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
                              },
                          @{
                              @"title": @"Flag",
                              @"description": [NSNull null],
                              @"imageHref": @"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
                              },
                          @{
                              @"title": @"Transportation",
                              @"description": @"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
                              @"imageHref": @"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"
                              },
                          @{
                              @"title": @"Hockey Night in Canada",
                              @"description": @"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.",
                              @"imageHref": @"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
                              },
                          @{
                              @"title": @"Eh",
                              @"description": @"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.",
                              @"imageHref": [NSNull null]
                              },
                          @{
                              @"title": @"Housing",
                              @"description": @"Warmer than you might think.",
                              @"imageHref": @"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
                              },
                          @{
                              @"title": @"Public Shame",
                              @"description": @"Sadly it's true.",
                              @"imageHref": @"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg"
                              },
                          @{
                              @"title": [NSNull null],
                              @"description": [NSNull null],
                              @"imageHref": [NSNull null]
                              },
                          @{
                              @"title": @"Space Program",
                              @"description": @"Canada hopes to soon launch a man to the moon.",
                              @"imageHref": @"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg"
                              },
                          @{
                              @"title": @"Meese",
                              @"description": @"A moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you.",
                              @"imageHref": @"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg"
                              },
                          @{
                              @"title": @"Geography",
                              @"description": @"It's really big.",
                              @"imageHref": [NSNull null]
                              },
                          @{
                              @"title": @"Kittens...",
                              @"description": @"Éare illegal. Cats are fine.",
                              @"imageHref": @"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg"
                              },
                          @{
                              @"title": @"Mounties",
                              @"description": @"They are the law. They are also Canada's foreign espionage service. Subtle.",
                              @"imageHref": @"http://3.bp.blogspot.com/__mokxbTmuJM/RnWuJ6cE9cI/AAAAAAAAATw/6z3m3w9JDiU/s400/019843_31.jpg"
                              },
                          @{
                              @"title": @"Language",
                              @"description": @"Nous parlons tous les langues importants.",
                              @"imageHref": [NSNull null]
                              }
                          ];
    
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:CellID];
    self.tableView.dataSource = self;
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


#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    NSDictionary *dictData = [self.arrTableData objectAtIndex:indexPath.row];
    
    cell.lblHeading.text = ([dictData objectForKey:@"title"] == [NSNull null]) ? @"" : [dictData objectForKey:@"title"];
    cell.lblDescription.text = ([dictData objectForKey:@"description"] == [NSNull null]) ? @"" : [dictData objectForKey:@"description"];
    
    if([dictData objectForKey:@"imageHref"] == [NSNull null])
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
            [cell.imgThumbnail sd_setImageWithURL:[dictData objectForKey:@"imageHref"] placeholderImage:[UIImage imageNamed:@"no_image_icon"] options:SDWebImageRefreshCached];
        });
    }
    
    return cell;
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

