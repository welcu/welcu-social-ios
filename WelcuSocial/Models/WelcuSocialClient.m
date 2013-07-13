//
//  WelcuSocialClient.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuSocialClient.h"

#import "WelcuEvent.h"

//static NSString * const kWelcuSocialClientAPIBaseURLString = @"https://api.welcu.com/social/v1/";
static NSString * const kWelcuSocialClientAPIBaseURLString = @"http://api.welcu.dev/social/v1/";

@implementation WelcuSocialClient

- (instancetype)initWithAccount:(WelcuAccount *)account
{
    self = [super initWithBaseURL:[NSURL URLWithString:kWelcuSocialClientAPIBaseURLString]];
    if (self) {
        self.account = account;
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", @"ASDF"]];
    }
    return self;
}

#pragma mark - AFIncrementalStore


/**
 Returns an `NSDictionary` containing the representations of associated objects found within the representation of a response object, keyed by their relationship name.
 
 @discussion For example, if `GET /albums/123` returned the representation of an album, including the tracks as sub-entities, keyed under `"tracks"`, this method would return a dictionary with an array of representations for those objects, keyed under the name of the relationship used in the model (which is likely also to be `"tracks"`). Likewise, if an album also contained a representation of its artist, that dictionary would contain a dictionary representation of that artist, keyed under the name of the relationship used in the model (which is likely also to be `"artist"`).
 
 @param representation The resource representation.
 @param entity The entity for the representation.
 @param response The HTTP response for the resource request.
 
 @return An `NSDictionary` containing representations of relationships, keyed by relationship name.
 */
- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation
                                                           ofEntity:(NSEntityDescription *)entity
                                                       fromResponse:(NSHTTPURLResponse *)response
{
    NSDictionary *result = [super representationsForRelationshipsFromRepresentation:representation
                                                                           ofEntity:entity
                            
                                                                       fromResponse:response];
    DDLogInfo(@"representationsForRelationshipsFromRepresentation:ofEntity:fromResponse: %@", result);
    return result;
}

/**
 Returns the attributes for the managed object corresponding to the representation of an entity from the specified response. This method is used to get the attributes of the managed object from its representation returned in `-representationOrArrayOfRepresentationsFromResponseObject` or `representationsForRelationshipsFromRepresentation:ofEntity:fromResponse:`.
 
 @discussion For example, if the representation returned from `GET /products/123` had a `description` field that corresponded with the `productDescription` attribute in its Core Data model, this method would set the value of the `productDescription` key in the returned dictionary to the value of the `description` field in representation.
 
 @param representation The resource representation.
 @param entity The entity for the representation.
 @param response The HTTP response for the resource request.
 
 @return An `NSDictionary` containing the attributes for a managed object.
 */
- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSDictionary *result = nil;
    
    if ([[entity name] isEqualToString:@"WelcuPost"]) {
        result = @{
                   @"content" : representation[@"content"],
                   };
    } else if ([[entity name] isEqualToString:@"WelcuUser"]) {
        result = @{
                   @"firstName" : representation[@"first_name"],
                   @"lastName" : representation[@"last_name"],
                   @"facebookUID" : representation[@"facebook_uid"]
                   };
    }
    
    DDLogInfo(@"attributesForRepresentation:ofEntity:%@ fromResponse:%@", [entity name], result);
    return result;
}

/**
 Returns a URL request object for the specified fetch request within a particular managed object context.
 
 @discussion For example, if the fetch request specified the `User` entity, this method might return an `NSURLRequest` with `GET /users` if the web service was RESTful, `POST /endpoint?method=users.getAll` for an RPC-style system, or a request with an XML envelope body for a SOAP webservice.
 
 @param fetchRequest The fetch request to translate into a URL request.
 @param context The managed object context executing the fetch request.
 
 @return An `NSURLRequest` object corresponding to the specified fetch request.
 */
- (NSMutableURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                                    withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *result = nil;
    if ([[[fetchRequest entity] name] isEqualToString:@"WelcuPost"]) {
        WelcuEvent *event = (WelcuEvent *)[(id)[fetchRequest predicate] rightExpression];
        result = [self requestWithMethod:@"GET"
                                    path:[NSString stringWithFormat:@"events/%@/posts", @1]
                              parameters:nil];
    } else {
        result = [super requestForFetchRequest:fetchRequest withContext:context];
    }
    
    DDLogInfo(@"requestForFetchRequest:withContext: %@", result);
    return result;
}

/**
 Returns a URL request object with a given HTTP method for a particular managed object. This method is used in `AFIncrementalStore -newValuesForObjectWithID:withContext:error`.
 
 @discussion For example, if a `User` managed object were to be refreshed, this method might return a `GET /users/123` request.
 
 @param method The HTTP method of the request.
 @param objectID The object ID for the specified managed object.
 @param context The managed object context for the managed object.
 
 @return An `NSURLRequest` object with the provided HTTP method for the resource corresponding to the managed object.
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                       pathForObjectWithID:(NSManagedObjectID *)objectID
                               withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *result = [super requestWithMethod:method pathForObjectWithID:objectID withContext:context];
    
    DDLogInfo(@"requestForFetchRequest:withContext: %@", result);
    return result;
}

/**
 Returns a URL request object with a given HTTP method for a particular relationship of a given managed object. This method is used in `AFIncrementalStore -newValueForRelationship:forObjectWithID:withContext:error:`.
 
 @discussion For example, if a `Department` managed object was attempting to fulfill a fault on the `employees` relationship, this method might return `GET /departments/sales/employees`.
 
 @param method The HTTP method of the request.
 @param relationship The relationship of the specifified managed object
 @param objectID The object ID for the specified managed object.
 @param context The managed object context for the managed object.
 
 @return An `NSURLRequest` object with the provided HTTP method for the resource or resoures corresponding to the relationship of the managed object.
 
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                       pathForRelationship:(NSRelationshipDescription *)relationship
                           forObjectWithID:(NSManagedObjectID *)objectID
                               withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *result = [super requestWithMethod:method
                                       pathForRelationship:relationship
                                           forObjectWithID:objectID
                                               withContext:context];
    
    DDLogInfo(@"requestForFetchRequest:withContext: %@", result);
    return result;
}

///-----------------------
/// @name Optional Methods
///-----------------------

/**
 Returns the attributes representation of an entity from the specified managed object. This method is used to get the attributes of the representation from its managed object.
 
 @discussion For example, if the representation sent to `POST /products` or `PUT /products/123` had a `description` field that corresponded with the `productDescription` attribute in its Core Data model, this method would set the value of the `productDescription` field to the value of the `description` key in representation/dictionary.
 
 @param attributes The resource representation.
 @param managedObject The `NSManagedObject` for the representation.
 
 @return An `NSDictionary` containing the attributes for a representation, based on the given managed object.
 */
//- (NSDictionary *)representationOfAttributes:(NSDictionary *)attributes
//                             ofManagedObject:(NSManagedObject *)managedObject
//{
//}

/**
 
 */
//- (NSMutableURLRequest *)requestForInsertedObject:(NSManagedObject *)insertedObject;

/**
 
 */
//- (NSMutableURLRequest *)requestForUpdatedObject:(NSManagedObject *)updatedObject;

/**
 
 */
//- (NSMutableURLRequest *)requestForDeletedObject:(NSManagedObject *)deletedObject;

/**
 Returns whether the client should fetch remote attribute values for a particular managed object. This method is consulted when a managed object faults on an attribute, and will call `-requestWithMethod:pathForObjectWithID:withContext:` if `YES`.
 
 @param objectID The object ID for the specified managed object.
 @param context The managed object context for the managed object.
 
 @return `YES` if an HTTP request should be made, otherwise `NO.
 */
- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

/**
 Returns whether the client should fetch remote relationship values for a particular managed object. This method is consulted when a managed object faults on a particular relationship, and will call `-requestWithMethod:pathForRelationship:forObjectWithID:withContext:` if `YES`.
 
 @param relationship The relationship of the specifified managed object
 @param objectID The object ID for the specified managed object.
 @param context The managed object context for the managed object.
 
 @return `YES` if an HTTP request should be made, otherwise `NO.
 */
- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end
