using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using XLua;

public class OcUtils
{

    [DllImport("__Internal")]
    private static extern IntPtr callObjCBridge(string className, string methodName, string jsonArgs, out int rlen);

    [DllImport("__Internal")]
    private static extern void freeCMemory(IntPtr ptr);

    public static string CallStaticMethod(string className, string methodName, string jsonArgs)
    {
        Debug.Log("!! OC CallStaticMethod !!");

        int rlen = 0;
        IntPtr stringData = callObjCBridge(className, methodName, jsonArgs, out rlen);

        byte[] buffer = new byte[rlen];
        Marshal.Copy(stringData, buffer, 0, rlen);
        // Marshal.FreeHGlobal(stringData);
        freeCMemory(stringData);

        return System.Text.Encoding.UTF8.GetString(buffer);
    }
}
