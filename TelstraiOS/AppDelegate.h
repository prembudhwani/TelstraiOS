//
//  AppDelegate.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 03/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataWrapper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) CoreDataWrapper *databaseObject;

@end

