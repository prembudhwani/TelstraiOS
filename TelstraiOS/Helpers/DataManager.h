//
//  DataManager.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fact+CoreDataProperties.h"

//Protocol required to be immplemented in the delegate class, if want to listen the success / failure callbacks
@protocol DataManagerDelegate <NSObject>

@required
- (void)didReceiveFact:(Fact *)factObject;
- (void)didFailWhenFetchingFact:(NSError *)error;
@end


@interface DataManager : NSObject

//Delegage Property to handle the success and failure callbacks
@property (nonatomic,weak) id <DataManagerDelegate> delegate;

//Method to fetch the Data from REST URL
- (void)fetchDataFromURL:(NSString *)urlString;
@end

