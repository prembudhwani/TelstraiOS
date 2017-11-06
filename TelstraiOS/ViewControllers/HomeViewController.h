//
//  HomeViewController.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 04/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface HomeViewController : UIViewController<UITableViewDataSource, DataManagerDelegate>
@property (nonatomic, strong) UITableView * _Nonnull tableView;
@property (nonnull, strong) UIActivityIndicatorView *loaderView;
@property (nonnull,strong) NSArray *arrTableData;
@end
