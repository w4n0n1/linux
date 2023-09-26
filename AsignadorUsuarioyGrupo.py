#!/usr/bin/python3
#_*_ coding: utf8 _*_

import os

def asignar_propietario_grupo(archivo, propietario, grupo):
    try:
        os.chown(archivo, os.geteuid(propietario), os.getegid(grupo))
        print(f"Se ha cambiado el propietario de '{archivo}' a '{propietario}' y el grupo a '{grupo}'.")
    except OSError as e:
        print(f"No se pudo cambiar el propietario/grupo de '{archivo}': {str(e)}")

# Nombre del archivo al que se asignarán el propietario y el grupo
nombre_archivo = input("Ingresa el nombre del archivo: ")

# Propietario y grupo al que se asignarán el archivo
propietario = input("Ingresa el nombre del propietario: ")
grupo = input("Ingresa el nombre del grupo: ")

# Llamada a la función para asignar propietario y grupo
asignar_propietario_grupo(nombre_archivo, propietario, grupo)
