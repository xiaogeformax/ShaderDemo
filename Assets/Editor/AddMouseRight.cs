using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;

/// <summary>
/// 添加鼠标右键事件
/// </summary>
[InitializeOnLoad]
[ExecuteInEditMode]
public static class AddMouseRight
{

    static AddMouseRight()
    {
        SceneView.onSceneGUIDelegate = OnSceneFunc;
    }

    private class Item
    {
        public string MenuName { get; set; }
        public GenericMenu.MenuFunction2 Call { get; set; }
    }
    static List<Item> S_MenuList = new List<Item>();
    public static void AddMenu(string menuName, GenericMenu.MenuFunction2 call)
    {
        Item item = new Item();
        item.MenuName = menuName;
        item.Call = call;
        S_MenuList.Add(item);
    }

    static void OnSceneFunc(SceneView sceneView)
    {
        if (S_MenuList.Count == 0)
        {
            return;
        }

        if (Event.current.isMouse && Event.current.button == 1)
        {
            Vector3 p = Event.current.mousePosition;

            GenericMenu menu = new GenericMenu();

            foreach (Item i in S_MenuList)
            {
                menu.AddItem(new GUIContent(i.MenuName), false, i.Call, p);
            }
            menu.ShowAsContext();

            Event.current.Use();
        }
    }

    public static void Reset()
    {
        while (S_MenuList.Count > 0)
        {
            S_MenuList.RemoveAt(0);
        }
    }


}