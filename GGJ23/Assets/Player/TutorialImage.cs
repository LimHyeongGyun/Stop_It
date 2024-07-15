using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class TutorialImage : MonoBehaviour
{
    public GameObject method1;
    public GameObject method2;
    public GameObject method3;
    public GameObject panel;
    public GameObject off;
    int count;
    public static bool start;

    void Start()
    {
        if(StageSelect.first == 1)
        {
            method1.SetActive(true);
            method2.SetActive(false);
            method3.SetActive(false);
        }
        if(StageSelect.first != 1)
        {
            panel.SetActive(false);
        }
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            count++;
            if (count == 1)
            {
                method1.SetActive(false);
                method2.SetActive(true);
            }
            else if(count == 2)
            {
                method2.SetActive(false);
                method3.SetActive(true);
                off.SetActive(true);
            }
        }
    }
    public void BackScene()
    {
        panel.SetActive(false);
        start = true;
    }
   /* private void OnDisable()
    {
        method1.SetActive (false);
        method2.SetActive (false);
        method3.SetActive (false);
        StartCoroutine(sc.InvisibleCanvas());
    }*/
}
