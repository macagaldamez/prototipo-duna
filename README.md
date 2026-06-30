# Radio Duna 89.7 — Prototipo de Sitio Web

## Descripción
Prototipo funcional de sitio web para Radio Duna 89.7 FM, desarrollado como
ejercicio de diseño UX/UI y desarrollo frontend. Incluye dos flujos de usuario
diferenciados: oyentes y periodistas.

## Cómo abrir el proyecto
Simplemente abre el archivo `index.html` con doble clic en cualquier navegador
moderno (Chrome, Firefox, Safari, Edge). No requiere instalación ni servidor.

Para funcionalidad completa de base de datos (Supabase), se recomienda servir
el archivo desde un servidor local:
```bash
python3 -m http.server 8080
```
Luego visitar `http://localhost:8080`

## Estructura del proyecto
- **index.html** — Sitio completo en un solo archivo (HTML + CSS + JavaScript)
- **supabase_schema.sql** — Script SQL para crear las tablas en Supabase

## Funcionalidades implementadas

### Flujo oyente
- Página de inicio con noticias, entrevistas, podcast y programación destacada
- Páginas de listado completo por categoría ("Ver más")
- Vista de detalle para artículos, programas y episodios de podcast
- Sección "En Vivo TV" con transmisión de video en vivo
- Reproductor de audio en vivo en la barra superior
- Buscador global de contenido
- Sistema de favoritos (persistencia en Supabase + localStorage)
- Asistente conversacional "Duna IA"

### Flujo periodista
- Acceso restringido vía login (usuario: `periodista`, contraseña: `demo1234`)
- Editor de notas con validación de caracteres y carga de imagen
- Publicación de notas (guardadas en base de datos Supabase)
- Descarga de notas en formato Word
- Panel de métricas con indicadores de audiencia

## Tecnologías utilizadas
- HTML5, CSS3, JavaScript (vanilla, sin frameworks)
- Supabase (base de datos en la nube, autenticación de datos)
- Lucide Icons (iconografía vía CDN)
- Tabler Icons (iconografía complementaria)
- Mediastream (embeds de streaming de audio y video en vivo)

## Notas técnicas
- El streaming de audio y video en vivo requiere que el sitio esté publicado
  en un dominio autorizado por Mediastream para reproducir contenido real,
  debido a restricciones de seguridad del navegador (CORS). Localmente, el
  reproductor mostrará un mensaje indicando esta limitación.
- La conexión a Supabase requiere que el sitio se sirva vía HTTP (no abrir
  directamente como archivo). Si no hay conexión disponible, el sitio sigue
  funcionando con respaldo en localStorage.

---
Proyecto desarrollado como prototipo de diseño UX/UI para Radio Duna 89.7 FM.
