using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using System.Linq;
public class RedPlayer : MonoBehaviour
{
    public List<GameObject> Blue;

    public int redHp;
    int i;
    float attackdelay;
    int angrytime;
    bool angry;
    bool On;

    public ParticleSystem angryParticle;
    public NavMeshAgent nav;
    AudioSource sound;
    Rigidbody rigid;
    Animator anim;
    private void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        nav = GetComponent<NavMeshAgent>();
        anim = GetComponent<Animator>();
        sound = GetComponentInChildren<AudioSource>();
    }

    void Start()
    {
        angry = true;
        angryParticle.Stop();
        nav.speed = 0;
        if (StageSelect.first != 1)
            StartCoroutine(SetTime());
        Blue = GameObject.FindGameObjectsWithTag("BluePlayer").OrderBy(x => Vector3.Distance(transform.position, x.transform.position)).ToList();
        redHp = 30;
    }
    void Update()
    {
        if(!angry)
            StartCoroutine(AngryRed());
        Target();
        if (SceneChanger.peace == true || SceneChanger.fail == true)
        {
            nav.speed = 0;
            anim.SetBool("Attack", false);
        }
        if (StageSelect.first == 1 && SceneChanger.move == true)
            StartCoroutine(SetTime());
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("BluePlayer"))
        {
            if (On)
                sound.Play();
        }
    }
    private void OnCollisionStay(Collision collision) //플레이어와 충돌시
    {
        if (collision.gameObject.CompareTag("BluePlayer"))
        {
            On = true;
            if (On)
                sound.Play();
            nav.velocity = Vector3.zero;
            attackdelay += Time.deltaTime;
            if(attackdelay > 1f)
            {
                attackdelay = 0;
                StartCoroutine(Damage());
            }
            anim.SetBool("Attack", true);
        }
    }
    private void OnCollisionExit(Collision collision) //다른 플레이어로 이동할 때
    {
        if (collision.gameObject.CompareTag("BluePlayer"))
        {
            On = false;
            anim.SetBool("Attack", false);
            nav.velocity = new Vector3(1, 1, 1);
        }
    }
    IEnumerator SetTime()
    {
        yield return new WaitForSecondsRealtime(4f);

        nav.speed = 1;
        anim.SetBool("Run", true);
        angry = false;
    }
    IEnumerator Damage()
    {
        redHp -= 10;
        if (redHp > 0)
        {
            
        }
        else
        {
            anim.SetTrigger("Die");
            yield return new WaitForSeconds(2f);

            GameObject parents = transform.parent.gameObject;
            Destroy(parents);
            SceneChanger.fail = true;
        }
    }
    void Target()
    {
        if (Blue[i] != null)
            nav.SetDestination(Blue[i].transform.position);
        else if (Blue[i] == null && i == Blue.Count)
        {
            anim.SetBool("Run", false);
        }
        else
            i += 1;
    }
    IEnumerator AngryRed()
    {
        angry = true;
        angrytime = Random.Range(2, 7);
        yield return new WaitForSeconds(angrytime);

        angryParticle.Play();
        yield return new WaitForSeconds(3f);

        angryParticle.Stop();
        angry = false;
    }
}