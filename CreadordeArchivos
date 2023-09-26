import os

def crear_archivo(nombre, extension, contenido=""):
    nombre_archivo = f"{nombre}.{extension}"
    with open(nombre_archivo, "w") as archivo:
        archivo.write(contenido)
    print(f"Archivo '{nombre_archivo}' creado.")

def asignar_permisos(nombre_archivo, permisos):
    os.system(f"chmod {permisos} {nombre_archivo}")
    print(f"Permisos del archivo '{nombre_archivo}' actualizados a {permisos}.")

# Obtener detalles del archivo a crear
nombre_archivo = input("Ingresa el nombre del archivo (sin extensión): ")
extension_archivo = input("Ingresa la extensión del archivo: ")
contenido_archivo = input("Ingresa el contenido del archivo (opcional): ")

# Crear el archivo
crear_archivo(nombre_archivo, extension_archivo, contenido_archivo)

# Obtener permisos
permisos = input("Ingresa los permisos (por ejemplo, 755): ")

# Asignar permisos al archivo
asignar_permisos(f"{nombre_archivo}.{extension_archivo}", permisos)
