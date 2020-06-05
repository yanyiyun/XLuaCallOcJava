package com.example.test3;

import android.util.Log;

public class JavaBridgeTest {
    static String tag = "UnityAndroid";
    
    public static void TestNoArg() {
        Log.i(tag, "====  TestNoArg  ====");
    }

    public static void BasePrint(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "String: " + v1);
        Log.i(tag, "boolean: " + v2);
        Log.i(tag, "byte: " + v3);
        Log.i(tag, "char: " + v4);
        Log.i(tag, "short: " + v5);
        Log.i(tag, "int: " + v6);
        Log.i(tag, "long: " + v7);
        Log.i(tag, "float: " + v8);
        Log.i(tag, "double: " + v9);
    }

    public static void TestVoid(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestVoid  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
    }

    public static String TestString(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestString  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v1;
    }

    public static boolean TestBoolean(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestBoolean  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v2;
    }

    public static byte TestByte(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestByte  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v3;
    }

    public static char TestChar(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestChar  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v4;
    }

    public static short TestShort(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestShort  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v5;
    }

    public static int TestInt(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestInt  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v6;
    }

    public static long TestLong(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestLong  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v7;
    }

    public static float TestFloat(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestFloat  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v8;
    }

    public static double TestDouble(String v1, boolean v2, byte v3, char v4, short v5, int v6, long v7, float v8, double v9) {
        Log.i(tag, "====  TestDouble  ====");
        BasePrint(v1, v2, v3, v4,  v5, v6, v7, v8, v9);
        return v9;
    }

}
