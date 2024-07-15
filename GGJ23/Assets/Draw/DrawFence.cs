 using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using Shady;
using System.Linq;

public class DrawFence : MonoBehaviour
{
    [SerializeField] LineRenderer trailPrefab = null;
    [SerializeField] GameObject fencePrefab = null;
    [SerializeField] Camera Cam;
    [SerializeField] float clearSpeed = 1;
    [SerializeField] float distanceFromCamera = 1;
    private GameObject fenceLine;
    private LineRenderer currentTrail;
    private List<Vector3> points = new List<Vector3>();
    private List<GameObject>fenceobj = new List<GameObject>();

    public int chance = 1;
    public float _timer;
    void Start()
    {
        _timer = 15;
    }

    void Update()
    {
        if(chance > 0 && SceneChanger.draw)
        {
            if (Input.GetMouseButtonDown(0))
            {
                DestroyCurrentTrail();
                CreateCurrentTrail();
                AddPoint();
            }//if end

            if (Input.GetMouseButton(0))
            {
                AddPoint();
            }//if end
            if (Input.GetMouseButtonUp(0))
            {
                CreateFence();
                chance -= 1;
            }

            UpdateTrailPoints();

            ClearTrailPoints();
        }
        else if(chance <= 0 && SceneChanger.fail != true)
        {
            _timer -= Time.deltaTime;
            if(_timer < 0)
            {
                SceneChanger.peace = true;
            }
        }
    }
    private void DestroyCurrentTrail()
    {
        if (currentTrail != null)
        {
            Destroy(currentTrail.gameObject);
            currentTrail = null;
            points.Clear();
        }//if end
    }//DestroyCurrentTrail() end

    private void CreateCurrentTrail()
    {
        currentTrail = Instantiate(trailPrefab);
        currentTrail.transform.SetParent(transform, true);
    }//CreateCurrentTrail() end

    void CreateFence()
    {
        points = points.Distinct().ToList();//중복 Vector3값 제거
        foreach (Vector3 linepoint in points)
        {
            fenceLine = Instantiate(fencePrefab, new Vector3(linepoint.x, Input.mousePosition.y/Screen.height, linepoint.z), Quaternion.identity);
            fenceLine.transform.SetParent(transform, true);
        }
    }

    private void AddPoint()
    {
        Vector3 mousePosition = Input.mousePosition;
        points.Add(Cam.ViewportToWorldPoint(new Vector3(mousePosition.x / Screen.width, mousePosition.y / Screen.height, distanceFromCamera)));
    }//AddPoint() end

    private void UpdateTrailPoints()
    {
        if (currentTrail != null && points.Count > 1)
        {
            currentTrail.positionCount = points.Count;
            currentTrail.SetPositions(points.ToArray());
        }//if end
        else
        {
            DestroyCurrentTrail();
        }//else end
    }//UpdateTrailPoints() end

    private void ClearTrailPoints()
    {
        float clearDistance = Time.deltaTime * clearSpeed;
        while (points.Count > 1 && clearDistance > 0)
        {
            float distance = (points[1] - points[0]).magnitude;
            if (clearDistance > distance)
            {
                points.RemoveAt(0);
            }//if end
            else
            {
                points[0] = Vector3.Lerp(points[0], points[1], clearDistance / distance);
            }//else end
            clearDistance -= distance;
        }//loop end
    }//ClearTrailPoints() end

    void OnDisable()
    {
        DestroyCurrentTrail();
    }//OnDisable() end
    
}
