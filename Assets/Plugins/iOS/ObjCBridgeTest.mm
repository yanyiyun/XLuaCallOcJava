//
//  ViewController.m
//  relection
//
//  Created by js on 2020/6/2.
//  Copyright © 2020 js. All rights reserved.
//

#import "ObjCBridgeTest.h"
#import "ObjCBridge.h"


@interface ObjCBridgeTest ()

@end

@implementation ObjCBridgeTest

void ObjCTest()
{
    [ObjCBridgeTest test];
}

+ (void)test {    
    NSNumber* num = [NSNumber numberWithInt:true];
    NSLog(@"%@   %s %s %s %s %s", num, [num objCType], @encode(BOOL), @encode(bool), @encode(char), @encode(int));
    
    [[self class] test:@"t1"];
    
//    NSArray* args = [[self class] arrayWithJsonString:@"[1,2, 3, null, \"abc\" ]"];
    NSString* ret = [ObjCBridge callWithClassName:@"ObjCBridgeTest" methodName:@"test3:" jsonArgs:@"[[134, \"abc\"]]"];
    NSLog(@"ret: %@", ret);
    
    int rlen;
    const char* ret1 = callObjCBridge("ObjCBridgeTest", "test2:arg2:", "[111, \"abc\"]", &rlen);
    
    printf("c call: %s", ret1);
    
    freeCMemory((void*)ret1);
    
//    NSLog(@"%@", args);
//
//    NSLog(@"%d", [[args objectAtIndex:4] isKindOfClass:[NSNull class]]);
//
//    NSLog(@"%d", [[args objectAtIndex:1] isKindOfClass:[NSNumber class]]);
}

+ (void)testNoArg {
    NSLog(@"NO arg");
}


+ (void)test:(NSString*)str {
    NSLog(@"%@", str);
}


//+ (NSString*)test2:(int)val {
//    NSLog(@"%d", val);
//    return [NSString stringWithFormat:@"%d", val];
//}

//+ (void)test2:(int)val {
//    NSLog(@"%d", val);
//}

+ (NSArray*)test2:(int)val {
    NSLog(@"%d", val);
    return @[[NSNumber numberWithInt:val], @"aaa", @true];
}

+ (NSArray*)test2:(int)arg1 arg2:(NSString*)arg2 {
    if (arg2)  {
        NSLog(@"%@ %@", arg2, [arg2 class]);
    }
    return @[[NSNumber numberWithInt:arg1], arg2];
}

+ (void)test3:(NSArray*)arg1 {
    NSLog(@"%@", arg1);
}


//+ (NSArray*)test2:(int)arg1 arg2:(int)arg2 {
//    return @[[NSNumber numberWithInt:arg1], [NSNumber numberWithInt:arg2]];
//}

@end
