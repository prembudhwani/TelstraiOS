//
//  Row+CoreDataProperties.h
//  
//
//  Created by Prem Budhwani on 06/11/17.
//
//

#import "Row+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Row (CoreDataProperties)

+ (NSFetchRequest<Row *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *rowDescription;
@property (nullable, nonatomic, copy) NSString *rowImageHref;
@property (nonatomic) int64_t rowNumber;
@property (nullable, nonatomic, copy) NSString *rowTitle;
@property (nullable, nonatomic, retain) Fact *factOfRow;

@end

NS_ASSUME_NONNULL_END
