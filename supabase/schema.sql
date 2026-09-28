-- Schema applicato al progetto Supabase "listaHalloween" (cyqcxyhncffmjflxtxns)
create table public.liste (
  slug text primary key check (slug ~ '^[a-z0-9-]{2,40}$'),
  nome text not null check (char_length(nome) between 1 and 60),
  ordine int not null default 0,
  attiva boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.prenotazioni (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  lista text not null references public.liste(slug),
  nome text not null check (char_length(trim(nome)) between 1 and 60),
  cognome text not null check (char_length(trim(cognome)) between 1 and 60),
  telefono text not null check (telefono ~ '^\+?[0-9 ]{6,20}$'),
  email text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' and char_length(email) <= 120),
  consenso_privacy boolean not null check (consenso_privacy = true),
  consenso_marketing boolean not null default false
);

create unique index prenotazioni_email_unique on public.prenotazioni (lower(email));
create index prenotazioni_lista_idx on public.prenotazioni (lista);

alter table public.liste enable row level security;
alter table public.prenotazioni enable row level security;

create policy "liste attive leggibili da tutti"
  on public.liste for select to anon, authenticated using (attiva = true);

create policy "chiunque può mettersi in lista"
  on public.prenotazioni for insert to anon, authenticated
  with check (consenso_privacy = true
    and exists (select 1 from public.liste l where l.slug = lista and l.attiva));

insert into public.liste (slug, nome, ordine) values
  ('locali','Locali',1), ('younivibes','Younivibes',2), ('baila-bonita','Baila Bonita',3);
