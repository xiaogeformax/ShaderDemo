using UnityEngine;
using System.Collections;
using UnityEditor;

public class Tools : MonoBehaviour
{

    [MenuItem("Assets/显示路径")]
    public static void ShowPath()
    {
        Object animObj = Selection.activeObject;
        string path = AssetDatabase.GetAssetPath(animObj);
//         AnimationClip clip = AssetDatabase.LoadAssetAtPath(path, typeof(AnimationClip)) as AnimationClip;
//         if (clip != null)
//         {
//             Debug.LogError("get");
//         }
        Debug.LogError(path);
    }
}
