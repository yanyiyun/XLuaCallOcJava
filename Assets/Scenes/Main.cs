using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class Main : MonoBehaviour
{
    public TextAsset jsonLua;
    public TextAsset initLua;
    public TextAsset testLua;
    
    void Start()
    {
    }


    public void OnClickBtnAndroid()
    {
        LuaEnv luaenv = new LuaEnv();

        luaenv.DoString(jsonLua.text);
        luaenv.DoString(initLua.text);
        luaenv.DoString(testLua.text);


        // luaenv.DoString(@"CS.Utils.CallStaticVoidMethod('com.example.test3.SysUtils', 'TestNoArg', '()V')");
        // luaenv.DoString(@"CS.Utils.CallStaticVoidMethod('com.example.test3.SysUtils', 'TestVoid', '(AZBCSIJFD)V', {'abc', true, 3, 'd', 5, 6, 7, 8, 9})");
        // luaenv.DoString(@"print(CS.Utils.CallStaticStringMethod('com.example.test3.SysUtils', 'TestString', '(AZBCSIJFD)A', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticBooleanMethod('com.example.test3.SysUtils', 'TestBoolean', '(AZBCSIJFD)Z', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticByteMethod('com.example.test3.SysUtils', 'TestByte', '(AZBCSIJFD)B', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticCharMethod('com.example.test3.SysUtils', 'TestChar', '(AZBCSIJFD)C', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticShortMethod('com.example.test3.SysUtils', 'TestShort', '(AZBCSIJFD)S', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticIntMethod('com.example.test3.SysUtils', 'TestInt', '(AZBCSIJFD)I', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticLongMethod('com.example.test3.SysUtils', 'TestLong', '(AZBCSIJFD)J', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticFloatMethod('com.example.test3.SysUtils', 'TestFloat', '(AZBCSIJFD)F', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");
        // luaenv.DoString(@"print(CS.Utils.CallStaticDoubleMethod('com.example.test3.SysUtils', 'TestDouble', '(AZBCSIJFD)D', {'abc', true, 3, 'd', 5, 6, 7, 8, 9}))");

        luaenv.Dispose();

    }
}
