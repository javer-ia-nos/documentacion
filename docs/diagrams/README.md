# Diagramas

Los diagramas compilados a png deben seguir el formato: `nombre-archivo.png` (_no `nombre-archivo.drawio.png`_).

## Compilar diagramas

Idealmente compilar mediante la interfaz gráfica de draw.io.

## Compilación automática

El repo realiza una compilación automática de los diagramas al momento de generar el documento de entrega. Por favor tener en cuenta el formato del nombre del archivo al momento de referenciarlo en typst, de lo contrario fallará.

## Como agregar al documento

Los diagramas compilados a png deben seguir el formato: `nombre-archivo.png` (_no `nombre-archivo.drawio.png`_), ejemplo:

```typ
#figure(
  caption: "Diagrama de vista de componentes", // Es el texto que sale abajo de la imagen
  align(
    center,
    image(
      "diagrams/component-view.png",           // Path de la imagen, generalmente inicia solo por diagramas
      width: 80%,
    ),
  ),
) <fig-container-view>                         // Tag de la figura, sirve para manejar más facil
                                               // las referencias en el documento.
                                               // Osea lo de "vease fig tal"
```

Por favor tener en cuenta las partes de esta notación. Más sobre las tags en: [https://typst.app/docs/reference/model/ref/](https://typst.app/docs/reference/model/ref/).
