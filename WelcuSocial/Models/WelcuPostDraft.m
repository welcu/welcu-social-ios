//
//  WelcuPostDraft.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/19/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuPostDraft.h"
#import "WelcuEvent.h"
#import "WelcuUserAccount.h"


@implementation WelcuPostDraft

@dynamic photo;
@dynamic content;
@dynamic kind;
@dynamic published;
@dynamic event;
@dynamic facebookEnabled;
@dynamic twitterEnabled;
@dynamic createdAt;


@synthesize progressDelegate;
@synthesize uploading = _uploading;
@synthesize progress = _progress;

+ (WelcuPostDraft *)postDraftWithAttributes:(NSDictionary *)attributes
{
    WelcuEvent *event = attributes[@"event"];
    
    if (!event) return nil;
    
    WelcuPostDraft *draft = [NSEntityDescription insertNewObjectForEntityForName:@"WelcuPostDraft"
                                                          inManagedObjectContext:event.managedObjectContext];
    
    draft.progress = 0;
    draft.createdAt = [NSDate date];
    draft.event = event;
    draft.content = attributes[@"content"];
    draft.facebookEnabled = attributes[@"facebook"];
    draft.twitterEnabled = attributes[@"twitter"];
    if (attributes[@"photo"]) {
        draft.photo = UIImagePNGRepresentation(attributes[@"photo"]);
    }
    
    [event.managedObjectContext save:nil];
    
    return draft;
}

- (void)startUpload
{
    if ([self isUploading]) return;
    _uploading = YES;
    
    WelcuUserAccount *userAccount = (WelcuUserAccount *)[WelcuAccount currentAccount];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"post"] = [NSMutableDictionary dictionary];
    parameters[@"post"][@"content"] = self.content;
    parameters[@"twitter"] = self.twitterEnabled;
    parameters[@"facebook"] = self.facebookEnabled;
    
//    request 
    NSURLRequest *request = [userAccount.client multipartFormRequestWithMethod:@"POST"
                                                                          path:[NSString stringWithFormat:@"events/%@/posts", self.event.eventID]
                                                                    parameters:parameters
                             constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        if (self.photo) {
            [formData appendPartWithFileData:self.photo
                                        name:@"post[photo]"
                                    fileName:@"photo.png"
                                    mimeType:@"image/png"];
        }
    }];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.published = @(YES);
        _uploading = NO;
        self.progress = 1;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        _uploading = NO;
        self.progress =  0;
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        self.progress = 1.0*totalBytesWritten/totalBytesExpectedToWrite;
        [self.progressDelegate postDraft:self uploadProgressedTo:self.progress];
        DDLogInfo(@"Progress %f", self.progress);
    }];
    
    [operation start];
    
}

@end
