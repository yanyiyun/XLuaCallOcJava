# XLuaCallOcJava
Lua call iOS Objective-C or Android java static method by using reflection mechanism. It only works in Unity. It's embedded XLua framework.

## Quick start
Lua call java:  
```lua
NativeBridge.CallStatic('com.example.test3.JavaBridgeTest', 'TestNoArg', '()V')
```

Lua call Object-c:  
```lua
NativeBridge.CallStatic("ObjCBridge", "test:", "ObjCBridge Test")
```

Lua method:  
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
