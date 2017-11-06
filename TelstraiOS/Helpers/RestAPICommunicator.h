//
//  RestAPICommunicator.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestAPICommunicator : NSObject
- (void)fetchDataFromURL:(NSString *)urlString completionHandler:(void(^)(NSDictionary *dictionaryDataObject, NSError *error))completionBlock;
@end

