using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class usb3script : MonoBehaviour
{


    private void Awake()
    {
        connection.lineRenderer.material.SetFloat("_Number_of_Dashes", DASHED_LINE_NUMBER_OF_DASHES * lineDistance);
    }
}
