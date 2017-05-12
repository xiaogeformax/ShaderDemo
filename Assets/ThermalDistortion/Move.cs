using UnityEngine;
using System.Collections;

public class Move : MonoBehaviour {

    public Transform tra;
    public float xMin;
    public float xMax;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () 
    {
        float x = Mathf.Lerp(xMin, xMax, Mathf.Abs(Mathf.Sin(Time.time)));
        tra.localPosition = new Vector3(x, tra.localPosition.y, tra.localPosition.z);
	}
}
