## Hechiceros

Queremos armar un programa donde tenemos hechiceros con diferentes rangos (aprendiz de brujo, archimago, hechicero supremo) que usan hechizos.
De los hechizos se conoce su energía requerida para usarlos y si son prohibidos.

#### De un hechicero queremos:

- ### Saber cuál es la energía mágica máxima:
    - En el caso de los aprendices es 50.
    - Para los archimagos es 100 + el doble de su nivel.
    - Para los hechiceros supremos es 500.

- ### Saber si puede usar cierto hechizo:
    Esto se cumple cuando tienen suficiente energía mágica disponible y aparte dependiendo del rango de mago:

  - Los aprendices de brujo sólo pueden usar hechizos que requieren menos de 40 de energía mágica.
  - Los archimagos pueden usar cualquier hechizo que no esté prohibido.
  - Los hechiceros supremos pueden usar cualquier hechizo sin importar la cantidad de energía mágica que tengan disponible.

### Progresión de rangos

Dado que estos hechiceros no están detenidos en el tiempo y van adquiriendo más conocimientos, queremos poder hacer que un hechicero aumente su rango y pase a otro. Entonces, necesitamos implementar lo necesario para por ejemplo hacer que:

- un aprendiz de brujo cambie a archimago de nivel 1.
- un archimago cambie a archimago de algún otro nivel o a hechicero supremo.