using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mute : MonoBehaviour
{
    AudioSource sound;
    public GameObject ground;

    private void Start()
    {
        sound = ground.GetComponent<AudioSource>();
    }
    private void OnEnable()
    {
        sound = ground.GetComponent<AudioSource>();
        sound.mute = true;
    }
}
