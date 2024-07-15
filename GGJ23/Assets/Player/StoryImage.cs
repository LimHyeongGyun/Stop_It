using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StoryImage : MonoBehaviour
{
    public GameObject story1;
    public GameObject story2;
    public GameObject story3;
    public GameObject off;
    public GameObject panel;
    int count;
    public int first;
    void Start()
    {
        if(first == 0)
        {
            panel.SetActive(true);
            first++;
        }
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            count++;
            if (count == 1)
            {
                story2.SetActive(true);
                story1.SetActive(false);
            }
            else if (count == 2)
            {
                story2.SetActive(false);
                story3.SetActive(true);
                off.SetActive(true);
            }
        }
    }
    public void BackScene()
    {
        panel.SetActive(false);
    }
    public void StoryBtn()
    {
        count = 0;
        panel.SetActive(true);
        story1.SetActive(true);
        story2.SetActive(false);
        story3.SetActive(false);
    }
}
