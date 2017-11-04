//
//  HomeViewController.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 04/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource>
@property (nonatomic, strong) UITableView * _Nonnull tableView;
@property (nonnull,strong) NSArray *arrTableData;
@end
