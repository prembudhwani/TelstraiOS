//
//  FactBuilder.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "FactBuilder.h"
#import "Fact+CoreDataProperties.h"
#import "Row+CoreDataProperties.h"
#import "CoreDataWrapper.h"
#import "AppDelegate.h"

@implementation FactBuilder

+ (Fact *)BuildFactFromDictionary:(NSDictionary *)dictionaryObject
{
    if (dictionaryObject == nil)
    {
        return nil;
    }
    
    NSString *strTitle = ([dictionaryObject objectForKey:@"title"] == [NSNull null] ? @"" : [dictionaryObject objectForKey:@"title"]);
    NSArray *arrRows = ([dictionaryObject objectForKey:@"rows"] == [NSNull null]) ? nil : [dictionaryObject objectForKey:@"rows"];
    
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    //First, Delete old rows of Fact Entity from Core Data, and it's related Row entities should be deleted automatically due to Cascade Rule
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Fact"];
    NSAsynchronousFetchResult *objFactList = [appDel.databaseObject.context executeRequest:fetchRequest error:&error];
    
    if (!error && objFactList.finalResult.count > 0) {
        for(NSManagedObject *managedObject in objFactList.finalResult){
            [appDel.databaseObject.context deleteObject:managedObject];
        }
        //Save context to write to store
        [appDel.databaseObject save];
    }
    
    
    //Insert the Fact object and it's related Row objects in Core Data
    Fact *factObj = [NSEntityDescription insertNewObjectForEntityForName:@"Fact" inManagedObjectContext:appDel.databaseObject.context];
    factObj.factTitle = strTitle;
    
    //Traverse the Rows array of this fact and insert the Row objects in Core Data
    [arrRows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dictRow = (NSDictionary *) obj;
        
        Row * rowObj = [NSEntityDescription insertNewObjectForEntityForName:@"Row" inManagedObjectContext:appDel.databaseObject.context];
        rowObj.rowTitle = ([dictRow objectForKey:@"title"] == [NSNull null] ? @"" : [dictRow objectForKey:@"title"]);
        rowObj.rowDescription = ([dictRow objectForKey:@"description"] == [NSNull null]) ? @"" : [dictRow objectForKey:@"description"];
        rowObj.rowImageHref = ([dictRow objectForKey:@"imageHref"] == [NSNull null]) ? @"" : [dictRow objectForKey:@"imageHref"];
        rowObj.rowNumber = idx;
        
        //Associate this Row object to the Fact Object in Core Data
        [factObj addRowsOfFactObject:rowObj];
    }];
    
    //Save changes to Core Data
    [appDel.databaseObject save];
    
    return factObj;
}
@end

