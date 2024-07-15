using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChanger : MonoBehaviour
{
    public GameObject peacePanel;
    public GameObject losePanel;
    public GameObject countCanvas;
    public GameObject Restart;
    public static bool peace;
    public static bool fail;
    public static bool draw;
    public static bool move;
    void Start()
    {
        if (SceneManager.GetActiveScene().buildIndex != 2)
            StageSelect.first = 2;
        peace = false;
        fail = false;
        peacePanel.SetActive(false);
        losePanel.SetActive(false);
        if (StageSelect.first != 1)
            StartCoroutine(InvisibleCanvas());
    }

    // Update is called once per frame
    void Update()
    {
        if (peace == true)
        {
            peacePanel.SetActive(true);
            Restart.SetActive(false);
        }
        else if (fail == true)
        {
            losePanel.SetActive(true);
            Restart.SetActive(false);
        }
        if (StageSelect.first == 1 && TutorialImage.start == true)
            StartCoroutine(InvisibleCanvas());


    }
    IEnumerator InvisibleCanvas()
    {
        TutorialImage.start = false;
        move = true;
        countCanvas.SetActive(true);
        yield return null;

        move = false;
        yield return new WaitForSeconds(3.5f);

        draw = true;
        yield return new WaitForSeconds(0.5f);

        countCanvas.SetActive(false);
        Restart.SetActive(true);
        
    }
    public void RegameBtn()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        SceneChanger.draw = false;
    }
    public void MainMenuBtn()
    {
        SceneManager.LoadScene("Select");
    }
    public void NextLevelBtn()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex+1);
        SceneChanger.draw = false;

        if (SceneManager.GetActiveScene().buildIndex == 2)
            StageSelect.first = 2;
    }
}
