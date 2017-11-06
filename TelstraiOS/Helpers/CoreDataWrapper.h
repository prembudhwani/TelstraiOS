//
//  CoreDataWrapper.h
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

///
/// Base class for CoreData SQLite, child classes should implement application-specific logic on top if its simplified interface
/// NOTE: This database should only be accessed from the main thread of the application due to it using a singleton NSManagedObjectContext
///
@interface CoreDataWrapper : NSObject

// Properties

///
/// Name of the object model related to this database (Same as the DataModel)
/// Child classes should set this property to indicate the object model
/// EG: AGDataModel, Library
///
@property (nonatomic) NSString *objectModelName;

///
/// The name of the SQLite file
/// Child classes should set this property to indicate the desired filename
/// EG: AGDataModel.sqlite, library_data.sqlite
///
@property (nonatomic) NSString *fileName;

//NSManagedObjectContexy
@property (nonatomic, strong , readwrite) NSManagedObjectContext *context;

// DB Methods
-(void)initCoreData;

- (void)save;

@end

