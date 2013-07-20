//
//  WelcuPostDraft.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/19/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuPostDraft.h"
#import "WelcuEvent.h"
#import "WelcuAccount.h"


@implementation WelcuPostDraft

@dynamic photo;
@dynamic content;
@dynamic kind;
@dynamic published;
@dynamic event;

@synthesize uploading = _uploading;

+ (WelcuPostDraft *)postDraftWithAttributes:(NSDictionary *)attributes
{
    WelcuEvent *event = attributes[@"event"];
    
    if (!event) return nil;
    
    WelcuPostDraft *draft = [NSEntityDescription insertNewObjectForEntityForName:@"WelcuPostDraft"
                                                          inManagedObjectContext:event.managedObjectContext];
    
    draft.event = event;
    draft.content = attributes[@"content"];
    if (attributes[@"photo"]) {
        draft.photo = UIImagePNGRepresentation(attributes[@"photo"]);
    }
    
    return draft;
}

- (void)startUpload
{
    if ([self isUploading]) return;
    _uploading = YES;
    
    WelcuAccount *userAccount = [WelcuAccount currentAccount];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"post"] = [NSMutableDictionary dictionary];
    parameters[@"post"][@"content"] = self.content;
    parameters[@"twitter"] = @(YES);
    parameters[@"facebook"] = @(YES);
    
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
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        _uploading = NO;
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        DDLogInfo(@"Uploading %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    [operation start];
    
}

@end
