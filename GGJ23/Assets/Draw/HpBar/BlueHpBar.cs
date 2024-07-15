using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BlueHpBar : MonoBehaviour
{
    public BluePlayer Bplayer;
    public Transform player;
    float maxHp = 30;
    float hp;
    public Slider Slider;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        transform.position = player.position + new Vector3(0,0,-0.05f);
        Slider.value = Bplayer.blueHp / maxHp;
    }
}
