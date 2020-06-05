using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class Main : MonoBehaviour
{
    public TextAsset jsonLua;
    public TextAsset NativeBridgeLua;
    public TextAsset testLua;
    
    void Start()
    {
    }


    public void OnClickBtnAndroid()
    {
        LuaEnv luaenv = new LuaEnv();

        luaenv.DoString(jsonLua.text);
        luaenv.DoString(NativeBridgeLua.text);
        luaenv.DoString(testLua.text);

        luaenv.Dispose();

    }
}
