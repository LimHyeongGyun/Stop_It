using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using UnityEngine;
using UnityEngine.AI;
public class BluePlayer : MonoBehaviour
{
    public List<GameObject> Red;

    public int blueHp;
    int i;
    bool On;
    float attackdelay;
    float actiondelay;
    int angrytime;
    bool angry;
    public ParticleSystem angryParticle;
    public ParticleSystem fightParticle;

    public NavMeshAgent nav;
    Rigidbody rigid;
    Animator anim;
    AudioSource sound;

    private void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        nav = GetComponent<NavMeshAgent>();
        anim = GetComponent<Animator>();
        sound = GetComponent<AudioSource>();
    }
    void Start()
    {
        angry = true;
        fightParticle.Stop();
        angryParticle.Stop();
        nav.speed = 0;
        if (StageSelect.first != 1)
            StartCoroutine(SetTime());
        Red = GameObject.FindGameObjectsWithTag("RedPlayer").OrderBy(x => Vector3.Distance(transform.position, x.transform.position)).ToList();
        blueHp = 30;
        On = true;
    }
    void Update()
    {
        if(!angry)
            StartCoroutine(AngryBlue());
        Target();
        if (SceneChanger.peace == true || SceneChanger.fail == true)
        {
            nav.speed = 0;
            anim.SetBool("Attack",false);
        }
        if (StageSelect.first == 1 && SceneChanger.move == true)
            StartCoroutine(SetTime());
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("RedPlayer"))
        {
            if (On)
                sound.Play();
        }
    }
    private void OnCollisionStay(Collision collision)
    {
        if (collision.gameObject.CompareTag("RedPlayer"))
        {
            nav.velocity = Vector3.zero;
            attackdelay += Time.deltaTime;
            actiondelay += Time.deltaTime;
            if (attackdelay > 1f)
            {
                attackdelay = 0;
                StartCoroutine(Damage());
            }
            if (actiondelay > Random.Range(0.5f, 1f))
            {
                ParticleSystem action = Instantiate(fightParticle, collision.transform.position, Quaternion.identity);
                actiondelay = 0;
            }
            anim.SetBool("Attack", true);
        }
    }
    private void OnCollisionExit(Collision collision) //다른 플레이어로 이동할 때
    {
        if (collision.gameObject.CompareTag("RedPlayer"))
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
        blueHp -= 10;
        sound.Play();
        if (blueHp > 0)
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
        if (Red[i] != null)
            nav.SetDestination(Red[i].transform.position);
        else if (Red[i] == null && i == Red.Count)
        {
            anim.SetBool("Run", false);
        }
        else
            i += 1;
    }
    IEnumerator AngryBlue()
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