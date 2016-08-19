//
//  EncryptionHelper.m
//  Shared
//
//  Created by Etienne Goulet-Lang on 7/20/15.
//  Copyright (c) 2015 Heine Frifeldt. All rights reserved.
//

#import "EncryptionHelper.h"

@implementation EncryptionHelper

+ (NSString *) md5: (NSString *) raw {
    // Create pointer to the string as UTF8
    const char *ptr = [raw UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

@end