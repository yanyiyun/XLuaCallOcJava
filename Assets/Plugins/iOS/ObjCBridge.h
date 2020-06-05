
#import <UIKit/UIKit.h>

extern "C" {
//return: remember call free(void*)
const char* callObjCBridge(const char* className, const char* methodName, const char* jsonArgs, int *rlen);
void freeCMemory(void* ptr);
}


@interface ObjCBridge : NSObject
+ (NSString*)callWithClassName:(NSString*)className methodName:(NSString*)methodName jsonArgs:(NSString*)jsonArgs;
+ (NSString*)test:(NSString*)str;
@end

