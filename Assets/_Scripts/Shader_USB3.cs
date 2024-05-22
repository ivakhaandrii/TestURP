using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shader_USB3 : MonoBehaviour
{
    private MeshRenderer meshRenderer;
    private float counter = 0;

    private void Awake()
    {
        meshRenderer = GetComponent<MeshRenderer>();
    }

    private IEnumerator Start()
    {
        while (true)
        {
            counter += Time.deltaTime;
            meshRenderer.material.SetFloat("_Rotation", counter * 90);
            yield return null;
        }
    }
}
