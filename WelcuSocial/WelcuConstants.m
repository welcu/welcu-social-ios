//
//  WelcuConstants.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuConstants.h"

NSString * const kWelcuTestflightToken = @"5c4488fd-b302-402e-ad76-553495fec49a";

#ifdef DEBUG
int const ddLogLevel = LOG_LEVEL_VERBOSE;
#else
int const ddLogLevel = LOG_LEVEL_WARN;
#endif
