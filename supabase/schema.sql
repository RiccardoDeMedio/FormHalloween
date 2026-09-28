-- Schema applicato al progetto Supabase "listaHalloween" (cyqcxyhncffmjflxtxns)
create table public.prenotazioni (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  nome text not null check (char_length(trim(nome)) between 1 and 60),
  cognome text not null check (char_length(trim(cognome)) between 1 and 60),
  telefono text not null check (telefono ~ '^\+?[0-9 ]{6,20}$'),
  email text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' and char_length(email) <= 120),
  consenso_privacy boolean not null check (consenso_privacy = true),
  consenso_marketing boolean not null default false
);

create unique index prenotazioni_email_unique on public.prenotazioni (lower(email));

alter table public.prenotazioni enable row level security;

create policy "chiunque può mettersi in lista"
  on public.prenotazioni for insert to anon, authenticated
  with check (consenso_privacy = true);
