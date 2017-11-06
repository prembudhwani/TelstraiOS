//
//  Row+CoreDataProperties.m
//  
//
//  Created by Prem Budhwani on 06/11/17.
//
//

#import "Row+CoreDataProperties.h"

@implementation Row (CoreDataProperties)

+ (NSFetchRequest<Row *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Row"];
}

@dynamic rowDescription;
@dynamic rowImageHref;
@dynamic rowNumber;
@dynamic rowTitle;
@dynamic factOfRow;

@end
