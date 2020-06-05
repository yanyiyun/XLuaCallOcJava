#import "ObjCBridge.h"
#include <string>


@interface ObjCBridge ()

@end

@implementation ObjCBridge


const char* callObjCBridge(const char* className, const char* methodName, const char* jsonArgs, int *rlen)
{
    NSString* nsClassName = [NSString stringWithCString: className encoding:NSUTF8StringEncoding];
    NSString* nsMethodName = [NSString stringWithCString: methodName encoding:NSUTF8StringEncoding];
    NSString* nsJsonArgs = [NSString stringWithCString: jsonArgs encoding:NSUTF8StringEncoding];
    
    NSString* rval = [ObjCBridge callWithClassName:nsClassName methodName:nsMethodName jsonArgs:nsJsonArgs];
    
    const char* str = [rval UTF8String];
    *rlen = (int)strlen(str);
    char* ret = (char*)malloc(*rlen + 1);
    strcpy(ret, str);
    
    return ret;
}

void freeCMemory(void* ptr)
{
    free(ptr);
}

#define JSO_ERR_OK                 (0)
#define JSO_ERR_TYPE_NOT_SUPPORT   (-1)
#define JSO_ERR_INVALID_ARGUMENTS  (-2)
#define JSO_ERR_METHOD_NOT_FOUND   (-3)
#define JSO_ERR_EXCEPTION_OCCURRED (-4)
#define JSO_ERR_CLASS_NOT_FOUND    (-5)
#define JSO_ERR_VM_FAILURE         (-6)

+ (NSString*)callWithClassName:(NSString*)className methodName:(NSString*)methodName jsonArgs:(NSString*)jsonArgs {
    int _error = 0;
    id rval = [NSNull null];
    
//    @try
//    {
        do {
            Class targetClass = NSClassFromString(className);
            if(!targetClass)
            {
                _error = JSO_ERR_CLASS_NOT_FOUND;
                break;
            }
            
            SEL methodSel = NSSelectorFromString(methodName);
            if (!methodSel)
            {
                _error = JSO_ERR_METHOD_NOT_FOUND;
                break;
            }
            
            NSMethodSignature *methodSig = [targetClass methodSignatureForSelector:(SEL)methodSel];
            if (methodSig == nil)
            {
                _error =  JSO_ERR_METHOD_NOT_FOUND;
                NSLog(@"%@.%@ method isn't found!", className, methodName);
                break;
            }
        
        
            NSArray* argv;
            if(jsonArgs)
                argv = [[self class] arrayWithJsonString:jsonArgs];
            NSUInteger argc = (argv == nil) ? 0 : [argv count];
            NSUInteger argumentCount = [methodSig numberOfArguments];
             if (argumentCount != argc + 2)
             {
                 _error = JSO_ERR_INVALID_ARGUMENTS;
                 break;
             }
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            [invocation setTarget:targetClass];
            [invocation setSelector:methodSel];
            
            for(int i = 2; i < argc + 2; ++i)
            {
                std::string argumentType = [methodSig getArgumentTypeAtIndex:i];
                id arg = [argv objectAtIndex:i-2];
    
                /* - (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)idx;
                 *
                 * Refer to https://developer.apple.com/documentation/foundation/nsinvocation/1437834-setargument?language=objc
                 *
                 * This method copies the contents of buffer as the argument at index. The number of bytes copied is determined by the argument size.
                 * When the argument value is an object, pass a pointer to the variable (or memory) from which the object should be copied:
                 */
    
                if ([arg isKindOfClass:[NSNumber class]])
                {
                    NSNumber* argN = (NSNumber*)arg;
                    if (argumentType == @encode(int))
                    {
                        int val = [argN intValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(long))
                    {
                        long val = [argN longValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(short))
                    {
                        short val = [argN shortValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(unsigned int))
                    {
                        unsigned int val = [argN unsignedIntValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(unsigned long))
                    {
                        unsigned long val = [argN unsignedLongValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(unsigned short))
                    {
                        unsigned short val = [argN unsignedShortValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(float))
                    {
                        float val = [argN floatValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(double))
                    {
                        double val = [argN doubleValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(char))
                    {
                        char val = [argN charValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(unsigned char))
                    {
                        unsigned char val = [argN unsignedCharValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(BOOL))
                    {
                        BOOL val = [argN boolValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == @encode(bool))
                    {
                        bool val = [argN boolValue];
                        [invocation setArgument:&val atIndex:i];
                    }
                    else if (argumentType == "@")
                    { // NSNumber*
                        NSNumber* number = argN;
                        [invocation setArgument:&number atIndex:i];
                    }
                    else
                    {
                        NSLog(@"Unsupported argument type: %s", argumentType.c_str());
                        _error = JSO_ERR_TYPE_NOT_SUPPORT;
                        break;
                    }
                }
                else
                {
                    [invocation setArgument:&arg atIndex:i];
                }
            }

            NSUInteger returnLength = [methodSig methodReturnLength];
            std::string returnType = [methodSig methodReturnType];
            [invocation invoke];

            if (returnLength > 0)
            {
                if (returnType == "@")
                {
                    void *tmp;
                    [invocation getReturnValue:&tmp];
                    rval = (__bridge id)tmp;
                }
                else if (returnType == @encode(BOOL) || returnType == @encode(bool))
                {
                    bool ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithBool:ret];
                }
                else if (returnType == @encode(int))
                {
                    int ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithInt:ret];
                }
                else if (returnType == @encode(long))
                {
                    long ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithLong:ret];
                }
                else if (returnType == @encode(short))
                {
                    short ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithShort:ret];
                }
                else if (returnType == @encode(unsigned int))
                {
                    unsigned int ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithUnsignedInt:ret];
                }
                else if (returnType == @encode(unsigned long))
                {
                    unsigned long ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithUnsignedLong:ret];
                }
                else if (returnType == @encode(unsigned short))
                {
                    unsigned short ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithUnsignedShort:ret];
                }
                else if (returnType == @encode(float))
                {
                    float ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithFloat:ret];
                }
                else if (returnType == @encode(double))
                {
                    double ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithDouble:ret];
                }
                else if (returnType == @encode(char))
                {
                    int8_t ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithChar:ret];
                }
                else if (returnType == @encode(unsigned char))
                {
                    uint8_t ret;
                    [invocation getReturnValue:&ret];
                    rval = [NSNumber numberWithUnsignedChar:ret];
                }
                else
                {
                    _error = JSO_ERR_TYPE_NOT_SUPPORT;
                    NSLog(@"not support return type = %s", returnType.c_str());
                    break;
                }
            }
        } while (false);
//    }@catch(NSException *exception)
//    {
//        NSLog(@"EXCEPTION THROW: %@", exception);
//        _error = JSO_ERR_EXCEPTION_OCCURRED;
//    }
    
    return [[self class] arrayToJsonString:@[[NSNumber numberWithInt:_error], rval]];
}


#pragma mark -字典转换成json串
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
#pragma mark -数组转换成json串
+ (NSString *)arrayToJsonString:(NSArray *)array{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}

#pragma mark -json串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json decode err: %@",err);
        return nil;
    }
    return dic;
}

#pragma mark -json串转换成数组
+ (NSArray*)arrayWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                    error:&err];
    
    if(err) {
        NSLog(@"json decode err：%@",err);
        return nil;
    }
    return arr;
    
}


@end
