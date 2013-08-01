//
//  WelcuSocialClient.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuSocialClient.h"

#import <TransformerKit/TTTDateTransformers.h>

#import "WelcuAccount.h"
#import "WelcuEvent.h"

NSString * const kWelcuSocialClientAPIBaseURLString = @"https://api.welcu.com/social/v1/";
//static NSString * const kWelcuSocialClientAPIBaseURLString = @"http://api.welcu.dev/social/v1/";
//static NSString * const kWelcuSocialClientAPIBaseURLString = @"http://api.welcu.192.168.5.123.xip.io/social/v1/";
static NSString * const kWelcuSocialClientAPIClientId = @"daace30d-bc2b-4e0b-a31a-a4470d6d6bb0";
//static NSString * const kWelcuSocialClientAPIClientSecret = @"FbQciVOWVa2mKhdt8cMCAg";


@interface WelcuAccount (AccessToken)
@property (readonly) NSString *accessToken;
@end

@implementation WelcuSocialClient

#pragma mark - Initialization

- (instancetype)initWithAccount:(WelcuAccount *)account
{
    self = [super initWithBaseURL:[NSURL URLWithString:kWelcuSocialClientAPIBaseURLString]];
    if (self) {
        self.account = account;
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept"
                         value:@"application/json"];
        [self setDefaultHeader:@"Authorization"
                         value:[NSString stringWithFormat:@"Bearer %@", self.account.accessToken]];
    }
    return self;
}

#pragma mark Authorization


+ (void)authorizeWithFacebookAccessToken:(NSString *)accessToken
                                 success:(void (^)(id accessTokenData))success
                                 failure:(void (^)(NSError *error))failure
{
    [self authorizeWithEmail:@"facebook"
                 andPassword:accessToken
                     success:success
                     failure:failure];
}

+ (void)authorizeWithEmail:(NSString *)email
               andPassword:(NSString *)password
                   success:(void (^)(id accessTokenData))success
                   failure:(void (^)(NSError *error))failure
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kWelcuSocialClientAPIBaseURLString]];
    
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    [client postPath:@"oauth/access_token"
          parameters:@{
                       @"client_id" : kWelcuSocialClientAPIClientId,
//                       @"client_secret" : kWelcuSocialClientAPIClientSecret,
                       @"x_auth_user" : email,
                       @"x_auth_password" : password
                       }
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark Welcu Social API

- (void)fetchMe:(WelcuSocialClientResponseHandler)handler
{
    [self getPath:@"me"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        handler(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil,error);
    }];
}


#pragma mark - Object attributes from representation

- (NSDate *)dateFromISO8601String:(NSString *)dateString
{
    static dispatch_once_t onceToken;
    static NSValueTransformer *dateTransformer = nil;
    dispatch_once(&onceToken, ^{
        dateTransformer = [NSValueTransformer valueTransformerForName:TTTISO8601DateTransformerName];
    });
    
    return [dateTransformer reverseTransformedValue:dateString];
}

- (NSDictionary *)attributesForEventRepresentation:(NSDictionary *)representation
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"fetchedAt"] = [NSDate date];
    result[@"eventID"] = representation[@"id"];
    
    if (representation[@"name"])
        result[@"name"] = representation[@"name"];
    
    if (representation[@"timezone"])
        result[@"timezone"] = representation[@"timezone"];
    
    if (representation[@"starts_at"]) {
        result[@"startsAt"] = [self dateFromISO8601String:representation[@"starts_at"]];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit | NSYearCalendarUnit
                                                                       fromDate:result[@"startsAt"]];
        
        result[@"startsAtMonth"] = [NSString stringWithFormat:@"%d-%d", components.year, components.month ];
    }
    
    if (representation[@"ends_at"])
        result[@"endsAt"] = [self dateFromISO8601String:representation[@"ends_at"]];
    
    if (representation[@"header_photo"])
        result[@"headerPhoto"] = representation[@"header_photo"];
    
    if (representation[@"venue_name"])
        result[@"venueName"] = representation[@"venue_name"];
    
    if (representation[@"venue_address"])
        result[@"venueAddress"] = representation[@"venue_address"];
    
    if (representation[@"lat"] && representation[@"lng"]) {
        result[@"latitude"] = representation[@"lat"];
        result[@"longitude"] = representation[@"lng"];
    }
    
    if (representation[@"participating"] || (response.URL.pathComponents.count >=4 && [response.URL.pathComponents[3] isEqualToString:@"me"])) {
        result[@"participating"] = @(YES);
    }
    
    return result;
}

- (NSDictionary *)attributesForPostRepresentation:(NSDictionary *)representation
                                      fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"fetchedAt"] = [NSDate date];
    
    result[@"postID"] = representation[@"id"];
    result[@"createdAt"] = [self dateFromISO8601String:representation[@"created_at"]];
    
    if (representation[@"content"])
        result[@"content"] = representation[@"content"];
    
    if (representation[@"sub_content"])
        result[@"subContent"] = representation[@"sub_content"];
    
    if (representation[@"photo"]) {
        result[@"photo"] = representation[@"photo"][@"url"];
    }

    return result;
}

- (NSDictionary *)attributesForTicketRepresentation:(NSDictionary *)representation
                                     fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"fetchedAt"] = [NSDate date];
    
    result[@"ticketID"] =representation[@"id"];
    result[@"code"] = representation[@"code"];
    result[@"urlString"] = representation[@"url"];
    result[@"createdAt"] = [self dateFromISO8601String:representation[@"created_at"]];
    
    if (representation[@"formatted_price"])
        result[@"formattedPrice"] = representation[@"formatted_price"];
    
    
    if (representation[@"checked_at"]) {
        result[@"checkedAt"] = [self dateFromISO8601String:representation[@"checked_at"]];
    }
    
    if (representation[@"person"]) {
        result[@"personFirstName"] = representation[@"person"][@"first_name"];
        result[@"personLastName"] = representation[@"person"][@"last_name"];
        
        if (representation[@"person"][@"email"]) {
            result[@"personEmail"] = representation[@"person"][@"email"];
        }
    }
    
    if (representation[@"ticket"]) {
        result[@"ticketName"] = representation[@"ticket"][@"name"];
        
        if (representation[@"ticket"][@"venue_name"])
            result[@"ticketVenueName"] = representation[@"ticket"][@"venue_name"];
        
        if (representation[@"ticket"][@"venue_address"])
            result[@"ticketVenueAddress"] = representation[@"ticket"][@"venue_address"];
        
        if (representation[@"ticket"][@"lat"] && representation[@"ticket"][@"lng"]) {
            result[@"ticketLatitude"] = representation[@"ticket"][@"lat"];
            result[@"ticketLongitude"] = representation[@"ticket"][@"lng"];
        }
        
        if (representation[@"ticket"][@"starts_at"])
            result[@"ticketStartsAt"] = [self dateFromISO8601String:representation[@"ticket"][@"starts_at"]];
        
        if (representation[@"ticket"][@"ends_at"])
            result[@"ticketEndsAt"] = [self dateFromISO8601String:representation[@"ticket"][@"ends_at"]];
    }
    
    return result;
}

- (NSDictionary *)attributesForUserRepresentation:(NSDictionary *)representation
                                     fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"fetchedAt"] = [NSDate date];
    
    result[@"userID"] = representation[@"id"];
    result[@"firstName"] = representation[@"first_name"];
    result[@"lastName"] = representation[@"last_name"];
    result[@"facebookUID"] = representation[@"facebook_uid"];
    
    return result;
}

#pragma mark - Requests for Objects

- (NSMutableURLRequest *)requestForEventsFetchRequest:(NSFetchRequest *)fetchRequest
                                         withContext:(NSManagedObjectContext *)context
{
    if (fetchRequest.fetchLimit == 1) return nil;
    
    NSString *path = @"events";
    
    if (fetchRequest.predicate) {
        NSArray *predicates = nil;
        if ([fetchRequest.predicate isKindOfClass:[NSCompoundPredicate class]]) {
            predicates = [(NSCompoundPredicate*)fetchRequest.predicate subpredicates];
        } else {
            predicates = @[ fetchRequest.predicate ];
        }
        
        for (NSComparisonPredicate *predicate in predicates) {
            if ([predicate.leftExpression.keyPath isEqualToString:@"participating"]) {
                // [NSPredicate predicateWithFormat:@"participating = %@" argumentArray:@[@(YES)]];
                path = [NSString stringWithFormat:@"me/%@", path];
            } else if ([predicate.leftExpression.keyPath isEqualToString:@"endsAt"]) {
                switch (predicate.predicateOperatorType) {
                    case NSGreaterThanPredicateOperatorType:
                    case NSGreaterThanOrEqualToPredicateOperatorType:
                        // [NSPredicate predicateWithFormat:@"endsAt >= %@" argumentArray:@[[NSDate date]]];
                        path = [NSString stringWithFormat:@"%@/upcoming", path];
                        break;
                    case NSLessThanPredicateOperatorType:
                    case NSLessThanOrEqualToPredicateOperatorType:
                        // [NSPredicate predicateWithFormat:@"endsAt <= %@" argumentArray:@[[NSDate date]]];
                        path = [NSString stringWithFormat:@"%@/past", path];
                        break;
                    default:
                        break;
                }
            }
            DDLogInfo(@"%@", predicate);
        }
        
    }
    
    return [self requestWithMethod:@"GET" path:path parameters:nil];
}


- (NSMutableURLRequest *)requestForPostsFetchRequest:(NSFetchRequest *)fetchRequest
                                         withContext:(NSManagedObjectContext *)context
{
    WelcuEvent *event = [[(NSComparisonPredicate *)[fetchRequest predicate] rightExpression] constantValue];
    return [self requestWithMethod:@"GET"
                                path:[NSString stringWithFormat:@"events/%@/posts", event.eventID]
                          parameters:nil];
}


- (NSMutableURLRequest *)requestForTicketsFetchRequest:(NSFetchRequest *)fetchRequest
                                         withContext:(NSManagedObjectContext *)context
{
    NSString *path = @"me/tickets";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (fetchRequest.predicate) {
        NSArray *predicates = nil;
        if ([fetchRequest.predicate isKindOfClass:[NSCompoundPredicate class]]) {
            predicates = [(NSCompoundPredicate*)fetchRequest.predicate subpredicates];
        } else {
            predicates = @[ fetchRequest.predicate ];
        }
        
        for (NSComparisonPredicate *predicate in predicates) {
            if ([predicate.leftExpression.keyPath isEqualToString:@"event"]) {
                // [NSPredicate predicateWithFormat:@"participating = %@" argumentArray:@[@(YES)]];
                
            } else if ([predicate.leftExpression.keyPath isEqualToString:@"event.endsAt"]) {
                switch (predicate.predicateOperatorType) {
                    case NSGreaterThanPredicateOperatorType:
                    case NSGreaterThanOrEqualToPredicateOperatorType:
                        // [NSPredicate predicateWithFormat:@"endsAt >= %@" argumentArray:@[[NSDate date]]];
                        path = [NSString stringWithFormat:@"%@/upcoming", path];
                        break;
                    case NSLessThanPredicateOperatorType:
                    case NSLessThanOrEqualToPredicateOperatorType:
                        // [NSPredicate predicateWithFormat:@"endsAt <= %@" argumentArray:@[[NSDate date]]];
                        path = [NSString stringWithFormat:@"%@/past", path];
                        break;
                    default:
                        break;
                }
            }
            DDLogInfo(@"%@", predicate);
        }
        
    }
    
    return [self requestWithMethod:@"GET" path:path parameters:parameters];
}


#pragma mark - AFIncrementalStore

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    if ([[entity name] isEqualToString:@"WelcuPost"]) {
        return [self attributesForPostRepresentation:representation fromResponse:response];
    } else if ([[entity name] isEqualToString:@"WelcuUser"]) {
        return [self attributesForUserRepresentation:representation fromResponse:response];
    } else if ([[entity name] isEqualToString:@"WelcuEvent"]) {
        return [self attributesForEventRepresentation:representation fromResponse:response];
    } else if ([[entity name] isEqualToString:@"WelcuTicket"]) {
        return [self attributesForTicketRepresentation:representation fromResponse:response];
    }
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unknown representation for %@ entity", [entity name]]
                                 userInfo:nil];
    
    return nil;
}

- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation
                                                           ofEntity:(NSEntityDescription *)entity
                                                       fromResponse:(NSHTTPURLResponse *)response
{
    NSDictionary *result = nil;
    
    if ([[entity name] isEqualToString:@"WelcuPost"]) {
        result = @{
                   @"user" : representation[@"user"],
                   @"event" : @{
                           @"id" : representation[@"event_id"]
                           }
                   };
    } else if ([[entity name] isEqualToString:@"WelcuTicket"]) {
        result = @{
                   @"event" : @{
                           @"id" : representation[@"event_id"],
                           @"participating" : @(YES)
                           }
                   };
    } else {
        result = [super representationsForRelationshipsFromRepresentation:representation
                                                                 ofEntity:entity
                                                             fromResponse:response];
    }
    
    DDLogInfo(@"representationsForRelationshipsFromRepresentation:ofEntity:fromResponse: %@", result);
    return result;
}

- (NSMutableURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                                    withContext:(NSManagedObjectContext *)context
{
    if ([fetchRequest.entity.name isEqualToString:@"WelcuPost"]) {
        return [self requestForPostsFetchRequest:fetchRequest withContext:context];
    } else if ([fetchRequest.entity.name isEqualToString:@"WelcuEvent"]) {
        return [self requestForEventsFetchRequest:fetchRequest withContext:context];
    } else if ([fetchRequest.entity.name isEqualToString:@"WelcuTicket"]) {
        return [self requestForTicketsFetchRequest:fetchRequest withContext:context];
    }
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unknown request for %@ entity", fetchRequest.entity.name]
                                 userInfo:nil];
    return nil;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                       pathForObjectWithID:(NSManagedObjectID *)objectID
                               withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *result = [super requestWithMethod:method pathForObjectWithID:objectID withContext:context];
    
    DDLogInfo(@"requestForFetchRequest:withContext: %@", result);
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unknown request for %@ entity with id %@", objectID.entity.name, objectID]
                                 userInfo:nil];
    
    return nil;
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
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unknown request for %@ entity relationships with id %@", objectID.entity.name, objectID]
                                 userInfo:nil];
    
    return nil;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if ([objectID.entity.name isEqualToString:@"WelcuEvent"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (NSMutableURLRequest *)requestForInsertedObject:(NSManagedObject *)insertedObject
{
    return nil;
}

- (NSMutableURLRequest *)requestForUpdatedObject:(NSManagedObject *)updatedObject
{
    return nil;
}

- (NSMutableURLRequest *)requestForDeletedObject:(NSManagedObject *)deletedObject
{
    return nil;
}

@end
