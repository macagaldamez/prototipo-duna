-- ============================================================
-- RADIO DUNA — Schema Supabase
-- Pega este SQL completo en: Supabase → SQL Editor → Run
-- ============================================================

-- 1. TABLA: periodistas
create table if not exists periodistas (
  id uuid primary key default gen_random_uuid(),
  usuario text unique not null,
  nombre text not null,
  email text unique not null,
  created_at timestamptz default now()
);

insert into periodistas (usuario, nombre, email)
values ('periodista', 'Editor Duna', 'editor@duna.cl')
on conflict (usuario) do nothing;

-- 2. TABLA: notas
create table if not exists notas (
  id uuid primary key default gen_random_uuid(),
  titular text not null check (char_length(titular) <= 120),
  bajada text,
  cuerpo text,
  foto_url text,
  autor_id uuid references periodistas(id),
  autor_nombre text,
  publicado boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 3. TABLA: favoritos
create table if not exists favoritos (
  id uuid primary key default gen_random_uuid(),
  session_id text not null,
  tipo text not null check (tipo in ('noticia','podcast','programa','entrevista')),
  titulo text not null,
  referencia_id text,
  metadata jsonb default '{}',
  created_at timestamptz default now()
);

-- 4. TABLA: sesiones_periodista
create table if not exists sesiones_periodista (
  id uuid primary key default gen_random_uuid(),
  periodista_id uuid references periodistas(id),
  usuario text not null,
  token text unique not null,
  expires_at timestamptz not null,
  created_at timestamptz default now()
);

-- ============================================================
-- RLS — Row Level Security
-- IMPORTANTE: drop policies primero por si ya existen
-- ============================================================

alter table periodistas enable row level security;
alter table notas enable row level security;
alter table favoritos enable row level security;
alter table sesiones_periodista enable row level security;

-- Drop existing policies to avoid conflicts
drop policy if exists "notas_lectura_publica" on notas;
drop policy if exists "notas_insertar" on notas;
drop policy if exists "notas_actualizar" on notas;
drop policy if exists "favoritos_lectura" on favoritos;
drop policy if exists "favoritos_insertar" on favoritos;
drop policy if exists "favoritos_eliminar" on favoritos;
drop policy if exists "sesiones_lectura" on sesiones_periodista;
drop policy if exists "sesiones_insertar" on sesiones_periodista;
drop policy if exists "sesiones_eliminar" on sesiones_periodista;
drop policy if exists "periodistas_lectura" on periodistas;

-- Notas: público puede leer, cualquiera puede insertar (prototipo)
create policy "notas_lectura_publica" on notas
  for select using (true);

create policy "notas_insertar" on notas
  for insert with check (true);

create policy "notas_actualizar" on notas
  for update using (true);

-- Favoritos: acceso total (oyentes sin login)
create policy "favoritos_lectura" on favoritos
  for select using (true);

create policy "favoritos_insertar" on favoritos
  for insert with check (true);

create policy "favoritos_eliminar" on favoritos
  for delete using (true);

-- Sesiones
create policy "sesiones_lectura" on sesiones_periodista
  for select using (true);

create policy "sesiones_insertar" on sesiones_periodista
  for insert with check (true);

create policy "sesiones_eliminar" on sesiones_periodista
  for delete using (true);

-- Periodistas: solo lectura
create policy "periodistas_lectura" on periodistas
  for select using (true);
