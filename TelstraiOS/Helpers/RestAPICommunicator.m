//
//  RestAPICommunicator.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "RestAPICommunicator.h"

@implementation RestAPICommunicator

- (void)fetchDataFromURL:(NSString *)urlString completionHandler:(void(^)(NSDictionary *dictionaryDataObject, NSError *error))completionBlock
{
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError)
        {
            if(completionBlock)
            {
                //Send back the connectionError object
                completionBlock(nil , connectionError);
            }
        }
        else
        {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSInteger responseCode = [httpResponse statusCode];
            
            if( (responseCode == 200 || responseCode == 201) && [data length] > 0)
            {
                NSError* error;
                
                NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dictProduct = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
                
                if(completionBlock)
                {
                    //Send back the dictionary Object and error object
                    completionBlock(dictProduct , error);
                }
            }
            else
            {
                if(completionBlock)
                {
                    //Send back a custom error with error code = 444
                    completionBlock(nil , [NSError errorWithDomain:[[NSBundle mainBundle]bundleIdentifier] code:444 userInfo:nil]);
                }
            }
        }
    }];
}
@end


