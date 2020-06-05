using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class Utils
{
    public static void Test(string str)
    {
        Debug.Log(str);
    }


    public static void Test1(LuaTable lt)
    {
        Debug.Log(lt);
    }



    public static void CallStaticVoidMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            jc.CallStatic(methodName, args);
        }
    }

    public static string CallStaticStringMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        string ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<string>(methodName, args);
        }
        return ret;
    }

    public static bool CallStaticBooleanMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        bool ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<bool>(methodName, args);
        }
        return ret;
    }

    public static byte CallStaticByteMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        byte ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<byte>(methodName, args);
        }
        return ret;
    }

    public static char CallStaticCharMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        char ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<char>(methodName, args);
        }
        return ret;
    }

    public static short CallStaticShortMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        short ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<short>(methodName, args);
        }
        return ret;
    }

    public static int CallStaticIntMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        int ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<int>(methodName, args);
        }
        return ret;
    }

    public static long CallStaticLongMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        long ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<long>(methodName, args);
        }
        return ret;
    }

    public static float CallStaticFloatMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        float ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<float>(methodName, args);
        }
        return ret;
    }

    public static double CallStaticDoubleMethod(string className, string methodName, string methodSignature, LuaTable luaArgs)
    {
        object[] args = ConvertLuaArgs(methodSignature, luaArgs);
        double ret;
        using (AndroidJavaClass jc = new AndroidJavaClass(className))
        {
            ret = jc.CallStatic<double>(methodName, args);
        }
        return ret;
    }

    static object[] ConvertLuaArgs(string methodSignature, LuaTable luaArgs)
    {
        List<object> al = new List<object>();
        for (int i = 1; i < methodSignature.Length - 2; i++)
        {
            char c = methodSignature[i];
            object val;
            switch(c)
            {
                case 'A':
                    val = luaArgs.Get<int, string>(i);
                    break;
                case 'Z':
                    val = luaArgs.Get<int, bool>(i);
                    break;
                case 'B':
                    val = luaArgs.Get<int, byte>(i);
                    break;
                case 'C':
                    val = luaArgs.Get<int, string>(i)[0];
                    break;
                case 'S':
                    val = luaArgs.Get<int, short>(i);
                    break;
                case 'I':
                    val = luaArgs.Get<int, int>(i);
                    break;
                case 'J':
                    val = luaArgs.Get<int, long>(i);
                    break;
                case 'F':
                    val = luaArgs.Get<int, float>(i);
                    break;
                case 'D':
                    val = luaArgs.Get<int, double>(i);
                    break;
                default:
                    throw new Exception("Error methodSignature: " + methodSignature); 
            }
            al.Add(val);
        }

        // foreach (var arg in al) { Debug.Log(arg.GetType()); Debug.Log(arg); }

        return al.ToArray();
    }

}
