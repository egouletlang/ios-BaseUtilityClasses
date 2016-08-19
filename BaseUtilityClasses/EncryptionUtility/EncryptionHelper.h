//
//  EncryptionHelper.h
//  Shared
//
//  Created by Etienne Goulet-Lang on 7/20/15.
//  Copyright (c) 2015 Heine Frifeldt. All rights reserved.
//

#ifndef Shared_EncryptionHelper_h
#define Shared_EncryptionHelper_h

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface EncryptionHelper: NSObject

+ (NSString *) md5: (NSString *) raw;

@end

#endif
