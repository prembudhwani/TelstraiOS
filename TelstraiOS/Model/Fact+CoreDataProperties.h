//
//  Fact+CoreDataProperties.h
//  
//
//  Created by Prem Budhwani on 06/11/17.
//
//

#import "Fact+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Fact (CoreDataProperties)

+ (NSFetchRequest<Fact *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *factTitle;
@property (nullable, nonatomic, retain) NSSet<Row *> *rowsOfFact;

@end

@interface Fact (CoreDataGeneratedAccessors)

- (void)addRowsOfFactObject:(Row *)value;
- (void)removeRowsOfFactObject:(Row *)value;
- (void)addRowsOfFact:(NSSet<Row *> *)values;
- (void)removeRowsOfFact:(NSSet<Row *> *)values;

@end

NS_ASSUME_NONNULL_END
