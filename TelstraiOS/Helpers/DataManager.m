//
//  DataManager.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "DataManager.h"
#import "RestAPICommunicator.h"
#import "FactBuilder.h"
#import "Fact+CoreDataProperties.h"
#import "Row+CoreDataProperties.h"

@implementation DataManager

- (void)fetchDataFromURL:(NSString *)urlString
{
    RestAPICommunicator *webServiceObject = [[RestAPICommunicator alloc]init];
    [webServiceObject fetchDataFromURL:urlString completionHandler:^(NSDictionary *dictionaryDataObject, NSError *error) {
        if (dictionaryDataObject != nil && error == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                Fact *factToShow = [FactBuilder BuildFactFromDictionary:dictionaryDataObject];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveFact:)])
                {
                    [self.delegate didReceiveFact:factToShow];
                }
            });
        }
        else
        {
            //Failure condition. Report to the delegate class
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFailWhenFetchingFact:)])
            {
                [self.delegate didFailWhenFetchingFact:error];
            }
        }
    }];
}
@end

