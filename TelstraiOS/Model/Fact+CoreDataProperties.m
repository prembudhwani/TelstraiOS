//
//  Fact+CoreDataProperties.m
//  
//
//  Created by Prem Budhwani on 06/11/17.
//
//

#import "Fact+CoreDataProperties.h"

@implementation Fact (CoreDataProperties)

+ (NSFetchRequest<Fact *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Fact"];
}

@dynamic factTitle;
@dynamic rowsOfFact;

@end
