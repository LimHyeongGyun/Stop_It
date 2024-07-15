using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class StageSelect : MonoBehaviour
{
    public static int first;
    public void StartScene()
    {
        SceneManager.LoadScene(0);
    }
    public void Scene_Change1()
    {
        first += 1;
        SceneManager.LoadScene(2);
    }

    public void Scene_Change2()
    {
        SceneManager.LoadScene(3);
    }

    public void Scene_Change3()
    {
        SceneManager.LoadScene(4);
    }
    public void Scene_Change4()
    {
        SceneManager.LoadScene(5);
    }
    public void Scene_Change5()
    {
        SceneManager.LoadScene(6);
    }
    public void Scene_Change6()
    {
        SceneManager.LoadScene(7);

    }
    public void Scene_Change7()
    {
        SceneManager.LoadScene(8);
    }
    public void Scene_Change8()
    {
        SceneManager.LoadScene(9);
    }
}
