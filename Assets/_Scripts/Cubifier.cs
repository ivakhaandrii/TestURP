using UnityEngine;

public class Cubifier : MonoBehaviour
{
    public GameObject TargetCube;

    public Vector3 SectionCount;
    public Material SubCubeMaterial;

    private Vector3 SizeOfOriginalCube;
    private Vector3 SectionSize;
    private Vector3 FillStartPosition;
    private Transform ParentTransform;
    private GameObject SubCube;

    void Start()
    {
        if (TargetCube == null)
            TargetCube = gameObject;

        SizeOfOriginalCube = TargetCube.transform.lossyScale;
        SectionSize = new Vector3(
            SizeOfOriginalCube.x / SectionCount.x,
            SizeOfOriginalCube.y / SectionCount.y,
            SizeOfOriginalCube.z / SectionCount.z
            );

        FillStartPosition = TargetCube.transform.TransformPoint(new Vector3(-0.5f, 0.5f, -0.5f))
                            + TargetCube.transform.TransformDirection(new Vector3(SectionSize.x, -SectionSize.y, SectionSize.z) / 2.0f);

        ParentTransform = new GameObject(TargetCube.name + "CubeParent").transform;
        DivideIntoCuboids();
    }

    private void DivideIntoCuboids()
    {
        for (int i = 0; i < SectionCount.x; i++)
        {
            for (int j = 0; j < SectionCount.y; j++)
            {
                for (int k = 0; k < SectionCount.z; k++)
                {
                    SubCube = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    SubCube.transform.localScale = SectionSize;
                    SubCube.transform.position = FillStartPosition +
                                                   TargetCube.transform.TransformDirection(new Vector3((SectionSize.x) * i, -(SectionSize.y) * j, (SectionSize.z) * k));
                    SubCube.transform.rotation = TargetCube.transform.rotation;

                    SubCube.transform.SetParent(ParentTransform);
                    SubCube.GetComponent<MeshRenderer>().material = SubCubeMaterial;
                    var rb = SubCube.AddComponent<Rigidbody>();
                    rb.isKinematic = true;
                }
            }
        }
        Destroy(TargetCube);
    }
}