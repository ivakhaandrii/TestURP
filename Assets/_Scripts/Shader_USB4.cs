using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shader_USB4 : MonoBehaviour
{
    private MeshRenderer meshRenderer;
    private float counter = 0;
    private bool isReverse = false;

    private void Awake()
    {
        meshRenderer = GetComponent<MeshRenderer>();
    }

    private IEnumerator Start()
    {
        while (true)
        {
            counter += Time.deltaTime * 3 * (isReverse ? 1 : -1);
            counter = Mathf.Clamp01(counter);
            if (counter == 1 || counter == 0)
                isReverse = !isReverse;
            meshRenderer.material.SetFloat("_Zoom", counter);
            yield return null;
        }
    }
}
