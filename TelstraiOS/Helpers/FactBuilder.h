//
//  FactBuilder.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fact+CoreDataProperties.h"

@interface FactBuilder : NSObject
+ (Fact *)BuildFactFromDictionary:(NSDictionary *)dictionaryObject;
@end
