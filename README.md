# XLuaCallOcJava
Lua call iOS Objective-C or Android java static method by using reflection mechanism. It only works in Unity. It's embedded XLua framework.

## Quick start
### Android:
```java
//java
package com.example.test3;
public class JavaBridgeTest {
    public static void TestNoArg() {
        Log.i(tag, "====  TestNoArg  ====");
    }
}
```

Lua call java:  
```lua
--lua
NativeBridge.CallStatic('com.example.test3.JavaBridgeTest', 'TestNoArg', '()V')
```
  
  
### iOS:
```Objective-c
//Object-c
@interface ObjCBridge : NSObject
+ (NSString*)test:(NSString*)str;
@end
```

Lua call Object-c:  
```lua
--lua
NativeBridge.CallStatic("ObjCBridge", "test:", "ObjCBridge Test")
```

### Lua method:  
```lua
--[[
Andriod:
AndroidCallStaticMethod(className, methodName, methodSignature, ...)
methodSignature: Method signature rule is similar to JNI rule.  Difference: Replace character string with 'A'; only support base type and sting stype; e.g. (AZBCSIJFD)V
https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/types.html


iOS:
iOSCallStaticMethod(className, methodName, ...)
methodName: e.g. no arg "funcname",  one arg "funcname:",  two args "funcname:argname2:"
args and return value: support base type and lua table. Lua array <==> NSArray; Lua talbe obj <==> NSDictionary.  bool type, as return value will be convert to [0|1]
]]
function NativeBridge.CallStatic(...)
```

## How to do
Copy these files in to your unity project:  
```text
NativeBridge.lua.txt
NativeBridge.cs
ObjCBridge.h (Plugins/iOS/)
ObjCBridge.mm (Plugins/iOS/)
```
  
Modify NativeBridge.lua.txt first three lines.  
```lua
--user define
local json = json
local register_global_module_table = true
```
