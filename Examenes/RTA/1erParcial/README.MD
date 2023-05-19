# Arquitectura de Sistemas Operativos

## Resolucion del 1er Parcial 20230518

- Grabacion
 - uso del comando script

```sh
script --timing=rec/time_log_Punto0 rec/rec_Parcial1_Punto0
script --timing=rec/time_log_PuntoA rec/rec_Parcial1_PuntoA
script --timing=rec/time_log_PuntoB rec/rec_Parcial1_PuntoB
script --timing=rec/time_log_PuntoC rec/rec_Parcial1_PuntoC
script --timing=rec/time_log_PuntoD rec/rec_Parcial1_PuntoD
script --timing=rec/time_log_PuntoE rec/rec_Parcial1_PuntoE
script --timing=rec/time_log_PuntoF rec/rec_Parcial1_PuntoF
script --timing=rec/time_log_PuntoG rec/rec_Parcial1_PuntoG
```

- Reproduccion
```sh

scriptreplay --timing=rec/time_log_Punto0 rec/rec_Parcial1_Punto0
scriptreplay --timing=rec/time_log_PuntoA rec/rec_Parcial1_PuntoA
scriptreplay --timing=rec/time_log_PuntoB rec/rec_Parcial1_PuntoB
scriptreplay --timing=rec/time_log_PuntoC rec/rec_Parcial1_PuntoC
scriptreplay --timing=rec/time_log_PuntoD rec/rec_Parcial1_PuntoD
scriptreplay --timing=rec/time_log_PuntoE rec/rec_Parcial1_PuntoE
scriptreplay --timing=rec/time_log_PuntoF rec/rec_Parcial1_PuntoF
scriptreplay --timing=rec/time_log_PuntoG rec/rec_Parcial1_PuntoG

```

