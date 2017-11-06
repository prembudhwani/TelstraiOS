//
//  CoreDataWrapper.m
//  TelstraiOS
//
//  Created by Prem Budhwani on 06/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import "CoreDataWrapper.h"
#import <CoreData/CoreData.h>

@interface CoreDataWrapper()
{
    NSManagedObjectModel *_objectModel;
    NSPersistentStoreCoordinator *_coordinator;
}

@property (nonatomic, readonly) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

@end

@implementation CoreDataWrapper

#pragma mark - Properties

///
/// Returns the NSURL for the application's documents directory
///
+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)initCoreData
{
    _context = [self context];
}

///
/// The Managed Object Context for this database, automatically setup on first call
/// NOTE: This single context is used for all calls in this system, thus it is only safe to use DB instance from a single thread
///
- (NSManagedObjectContext *)context
{
    if(!_context) {
        NSPersistentStoreCoordinator *coordinator = [self coordinator];
        if (coordinator != nil) {
            _context = [[NSManagedObjectContext alloc] init];
            [_context setPersistentStoreCoordinator:coordinator];
        }
    }
    return _context;
}

///
/// The Managed Object Model for this database, automatically setup on first call
/// NOTE: The value for self.objectModelName must the named of a valid data model (.xcdatamodeld) defined in the project
///
- (NSManagedObjectModel *)objectModel
{
    if(!_objectModel) {
        // WARNING: self.objectModelName must have a value; otherwise, this might blow up!
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.objectModelName withExtension:@"momd"];
        _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _objectModel;
}

///
/// The Persistent Store Coordinator for this database, automatically setup on first call
/// NOTE: The value for self.fileName must be defined (EG: database.sqlite) or this will crash
///
- (NSPersistentStoreCoordinator *)coordinator
{
    if(!_coordinator) {
        
        // WARNING: self.fileName must have a value; otherwise, this might blow up!
        NSURL *storeURL = [[CoreDataWrapper applicationDocumentsDirectory] URLByAppendingPathComponent:self.fileName];
        NSLog(@"Store URL : %@" , [storeURL absoluteString]);
        NSError *error = nil;
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
        if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
            
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
            
            NSLog(@"CoreDataWrapper: Unresolved Persistent Store error %@, %@", error, [error userInfo]);
            
            abort();
        }
        
        NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
        if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:[storeURL path] error:&error])
        {
            NSLog(@"CoreDataWrapper: Unresolved FileProtectionComplete error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    return _coordinator;
}

#pragma mark - Database Methods

///
/// Saves the current object context, flushing to file
/// NOTE: This must be called after all object creation, update, and deletion to persist changes
///
- (void)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self context];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            // Replace this implementation with code to handle the error appropriately.
            
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
            
            NSLog(@"CoreDataWrapper: Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

