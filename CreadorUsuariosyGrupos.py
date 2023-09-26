import os
import getpass  # Importar la biblioteca getpass para ocultar la contraseña ingresada

class Usuario:
    def __init__(self, nombre):
        self.nombre = nombre

    def crear(self):
        os.system(f"sudo useradd {self.nombre}")
        print(f"Usuario '{self.nombre}' creado")

    def asignar_contrasena(self):
        contrasena = getpass.getpass(f"Ingrese la contraseña para '{self.nombre}': ")
        confirmar_contrasena = getpass.getpass("Confirme la contraseña: ")
        if contrasena == confirmar_contrasena:
            os.system(f"echo '{self.nombre}:{contrasena}' | sudo chpasswd")
            print(f"Contraseña asignada al usuario '{self.nombre}'")
        else:
            print("Las contraseñas no coinciden. La contraseña no se asignó.")

class Grupo:
    def __init__(self, nombre):
        self.nombre = nombre
        self.usuarios = []
        self.permisos = []

    def crear(self):
        os.system(f"sudo groupadd {self.nombre}")
        print(f"Grupo '{self.nombre}' creado")

    def agregar_usuario(self, usuario):
        self.usuarios.append(usuario)
        os.system(f"sudo usermod -aG {self.nombre} {usuario.nombre}")
        print(f"Usuario '{usuario.nombre}' agregado al grupo '{self.nombre}'")

    def asignar_permiso(self, permiso):
        self.permisos.append(permiso)
        # Aquí puedes implementar la lógica para asignar permisos al grupo

# Obtener nombres de usuario y grupo
nombre_usuario = input("Ingresa el nombre de usuario: ")
nombre_grupo = input("Ingresa el nombre de grupo: ")

# Crear usuarios y grupos
usuario = Usuario(nombre_usuario)
usuario.crear()
usuario.asignar_contrasena()  # Asignar contraseña al usuario

grupo = Grupo(nombre_grupo)
grupo.crear()

# Agregar usuarios a grupos
grupo.agregar_usuario(usuario)

# Asignar permisos a grupos
grupo.asignar_permiso("Modificar configuración")
