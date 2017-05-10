using UnityEngine;
using System.Collections;

public class Controll : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
    void OnGUI()
    {
        if (GUILayout.Button("修改"))
        {
            this.GetComponent<Renderer>().material.SetFloat("_Speed", 0f);
        }

  
    }
}
