-- ============================================================
-- RADIO DUNA — Schema completo con datos reales
-- Ejecuta en: Supabase → SQL Editor → Run
-- ============================================================

-- ── TABLA: noticias ──────────────────────────────────────
create table if not exists noticias (
  id uuid primary key default gen_random_uuid(),
  category text not null default 'General',
  title text not null,
  bajada text,
  author text default 'Redacción Duna',
  reading_time text default '3 min de lectura',
  published_at timestamptz default now(),
  body text,
  color text default '#85a9dd',
  active boolean default true
);

-- ── TABLA: podcasts ──────────────────────────────────────
create table if not exists podcasts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  program text,
  duration text,
  summary text,
  color text default 'linear-gradient(135deg,#b3d0f2,#85a9dd)',
  published_at timestamptz default now(),
  active boolean default true
);

-- ── TABLA: entrevistas ───────────────────────────────────
create table if not exists entrevistas (
  id uuid primary key default gen_random_uuid(),
  category text default 'Entrevista',
  title text not null,
  bajada text,
  duration text,
  author text default 'Redacción Duna',
  color text default '#85a9dd',
  published_at timestamptz default now(),
  body text,
  active boolean default true
);

-- ── TABLA: programas ─────────────────────────────────────
create table if not exists programas (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  schedule text,
  description text,
  hosts jsonb default '[]',
  color text default 'linear-gradient(135deg,#b3d0f2,#85a9dd)',
  emoji text default '🎙',
  active boolean default true
);

-- ── RLS ──────────────────────────────────────────────────
alter table noticias enable row level security;
alter table podcasts enable row level security;
alter table entrevistas enable row level security;
alter table programas enable row level security;

drop policy if exists "noticias_read" on noticias;
drop policy if exists "podcasts_read" on podcasts;
drop policy if exists "entrevistas_read" on entrevistas;
drop policy if exists "programas_read" on programas;

create policy "noticias_read" on noticias for select using (active = true);
create policy "podcasts_read" on podcasts for select using (active = true);
create policy "entrevistas_read" on entrevistas for select using (active = true);
create policy "programas_read" on programas for select using (active = true);

-- ── DATOS: noticias ──────────────────────────────────────
insert into noticias (category, title, bajada, author, reading_time, color, body) values
('Política','Bettina Horst y no pago de contribuciones para mayores de 65 años','"Los alcaldes plantean que va a haber una crisis de financiamiento y las cifras no pueden avalar eso, está absolutamente descartado"','Redacción Duna','3 min de lectura','#b3d0f2','<p>La directora ejecutiva de Libertad y Desarrollo, Bettina Horst, abordó el debate en torno a la propuesta de eximir del pago de contribuciones a los adultos mayores de 65 años, descartando que la medida genere un impacto significativo en las finanzas municipales.</p><p>Horst respondió a las advertencias realizadas por algunos alcaldes respecto de una eventual disminución de ingresos para los municipios, asegurando que los antecedentes disponibles no respaldan ese escenario.</p><p>Asimismo, sostuvo que el impacto de la medida variará dependiendo de cada comuna, aunque aseguró que en la mayoría de los casos los efectos serían mínimos.</p>'),
('Economía','Banco Central mantiene tasa en 5% y señala que inflación sigue dentro del rango esperado','El consejo del instituto emisor decidió por unanimidad mantener la tasa de política monetaria luego de evaluar los últimos indicadores.','Economía Duna','4 min de lectura','#fcb78e','<p>El Consejo del Banco Central de Chile acordó mantener la Tasa de Política Monetaria (TPM) en 5,0% anual en su reunión de esta semana, en un contexto en que la inflación continúa convergiendo hacia la meta del 3%.</p><p>La decisión se tomó por unanimidad y refleja la evaluación de que el escenario macroeconómico está evolucionando de acuerdo con lo previsto en el último Informe de Política Monetaria.</p>'),
('Internacional','Elecciones en Argentina: resultados preliminares dan ventaja a la coalición opositora','Las primeras cifras del escrutinio provisorio apuntan a una disputa reñida en el balotaje de noviembre.','Mundo Duna','5 min de lectura','#c5aadc','<p>Los primeros resultados del escrutinio provisorio muestran una ventaja de la coalición opositora sobre el oficialismo en varias provincias clave, aunque la diferencia no es suficiente para determinar un ganador definitivo.</p><p>La participación ciudadana fue elevada, superando el 72% del padrón electoral.</p>'),
('Sociedad','Reforma previsional avanza en la comisión del Senado con respaldo transversal','El proyecto que busca mejorar las pensiones obtuvo votos de distintas coaliciones en la instancia legislativa.','Redacción Duna','3 min de lectura','#85a9dd','<p>La Comisión de Trabajo del Senado aprobó en general el proyecto de reforma previsional con votos de senadores de diferentes coaliciones, permitiendo que el texto avance hacia la Sala.</p>'),
('Cultura','Festival Santiago a Mil anuncia programación 2026 con compañías de 14 países','El evento internacional de artes escénicas presenta su grilla con más de 60 funciones.','Cultura Duna','2 min de lectura','#c5aadc','<p>El Festival Internacional Santiago a Mil presentó su programación para 2026 con espectáculos de teatro, danza y circo de 14 países de América Latina, Europa y Asia.</p>'),
('Tecnología','Chile avanza en regulación de inteligencia artificial con nuevo proyecto de ley','La iniciativa busca un marco normativo para el uso ético y transparente de sistemas de IA.','Tecnología Duna','4 min de lectura','#85a9dd','<p>El Ministerio de Ciencia ingresó al Congreso un proyecto de ley que regula el desarrollo, uso e implementación de sistemas de IA en Chile, estableciendo principios de transparencia y supervisión humana.</p>');

-- ── DATOS: podcasts ──────────────────────────────────────
insert into podcasts (title, program, duration, summary, color) values
('La Crisis del Sistema de Salud Público','Hablemos en Off','42 min','Analizamos el estado del sistema de salud público en Chile, los desafíos de las listas de espera y las propuestas de reforma que se discuten en el Congreso.','linear-gradient(135deg,#b3d0f2,#85a9dd)'),
('Los 100 mejores álbumes del rock chileno','Música & Algo Más','58 min','Un recorrido histórico por los discos que definieron el rock nacional desde los 70 hasta hoy, con análisis de cada era y los artistas que marcaron generaciones.','linear-gradient(135deg,#c5aadc,#85a9dd)'),
('Impacto de la IA en el mercado laboral chileno','Economía Duna','35 min','Expertos analizan cómo la inteligencia artificial está transformando el empleo en Chile y qué habilidades serán más valiosas en el futuro próximo.','linear-gradient(135deg,#fcb78e,#c5aadc)'),
('Geopolítica 2026: tensiones en el Indo-Pacífico','Mundo Duna','47 min','Un análisis profundo de las tensiones geopolíticas en Asia-Pacífico y su impacto en la economía global y en América Latina.','linear-gradient(135deg,#85a9dd,#0e1826)');

-- ── DATOS: entrevistas ───────────────────────────────────
insert into entrevistas (category, title, bajada, duration, author, color, body) values
('Economía','Felipe Larraín: "Chile necesita un pacto fiscal que sea sostenible y creíble"','El ex ministro de Hacienda analizó el escenario macroeconómico del país y los desafíos para la próxima década.','18:24 min','Economía Duna','#fcb78e','<p>El ex ministro de Hacienda, Felipe Larraín, señaló que Chile enfrenta un momento clave para definir su política fiscal de largo plazo. En una extensa conversación, abordó los desafíos de la deuda pública, la inversión y el crecimiento.</p>'),
('Política','Camila Vallejo sobre reforma de pensiones: "Es un avance histórico para las futuras generaciones"','La ministra Portavoz explicó los alcances del proyecto que está en trámite en el Senado.','24:10 min','Redacción Duna','#85a9dd','<p>La ministra portavoz, Camila Vallejo, defendió el proyecto de reforma previsional y respondió a las críticas de la oposición, destacando los beneficios para los sectores más vulnerables.</p>'),
('Cultura','Nona Fernández: "La literatura chilena está viviendo un momento de gran efervescencia creativa"','La escritora y dramaturga habló sobre su nueva novela y el panorama de las letras en el país.','31:55 min','Cultura Duna','#c5aadc','<p>La reconocida escritora Nona Fernández presentó su nueva novela y reflexionó sobre el papel de la literatura en tiempos de crisis, la identidad chilena y el rol de las mujeres en la narrativa nacional.</p>');

-- ── DATOS: programas ─────────────────────────────────────
insert into programas (name, schedule, description, hosts, color, emoji) values
('Hablemos en Off','Lun–Vie · 7:00–9:00','El espacio de análisis político y entrevistas de la mañana de Duna.','[["MR","Matías del Río"],["NV","Nicolás Vergara"]]','linear-gradient(135deg,#b3d0f2,#85a9dd)','🎙'),
('Música & Algo Más','Lun–Vie · 9:00–13:00','La mejor música con contexto cultural y artístico.','[["CR","Catalina Rojas"],["FM","Felipe Maturana"]]','linear-gradient(135deg,#c5aadc,#85a9dd)','🎵'),
('Economía Duna','Lun–Vie · 13:00–15:00','Análisis económico con los mejores expertos del país.','[["RC","Rodrigo Cerda"],["PR","Paula Recabarren"]]','linear-gradient(135deg,#fcb78e,#c5aadc)','📊'),
('Mundo Duna','Lun–Vie · 15:00–17:00','La actualidad internacional y geopolítica global.','[["CH","Constanza Hola"],["JM","Jorge Morales"]]','linear-gradient(135deg,#85a9dd,#5e6ac0)','🌍'),
('Tarde Duna','Lun–Vie · 17:00–20:00','Música y entretenimiento para el cierre de la tarde.','[["DJ","Diego Jara"],["CS","Camila Soto"]]','linear-gradient(135deg,#0e1826,#5e6ac0)','🎸'),
('Noche de Radio','Lun–Vie · 20:00–00:00','La música más especial para acompañar la noche.','[["VB","Valentina Bravo"]]','linear-gradient(135deg,#b3d0f2,#0e1826)','🌙'),
('Duna Weekend','Sáb · 9:00–12:00','El magazine del fin de semana con temas de actualidad.','[["IE","Ignacio Errázuriz"],["BM","Bárbara Muñoz"]]','linear-gradient(135deg,#c5aadc,#fcb78e)','☀️'),
('Duna Clásico','Dom · 10:00–13:00','Un recorrido por los grandes clásicos de la música.','[["SI","Sebastián Irarrázaval"]]','linear-gradient(135deg,#85a9dd,#fcb78e)','🎼');

