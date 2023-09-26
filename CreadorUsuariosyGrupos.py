import os

class Usuario:
    def __init__(self, nombre):
        self.nombre = nombre

    def crear(self):
        os.system(f"sudo useradd {self.nombre}")
        print(f"Usuario '{self.nombre}' creado")

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

grupo = Grupo(nombre_grupo)
grupo.crear()

# Agregar usuarios a grupos
grupo.agregar_usuario(usuario)

# Asignar permisos a grupos
grupo.asignar_permiso("Modificar configuración")
