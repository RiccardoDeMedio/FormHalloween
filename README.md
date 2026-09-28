# listaHalloween

Pagina "mettiti in lista" per Halloween × Pubby. HTML statico, nessuna build.
Le prenotazioni finiscono nella tabella `prenotazioni` del progetto Supabase **listaHalloween**.

- `index.html` — la pagina (config Supabase in cima allo `<script>`)
- `supabase/schema.sql` — tabella, vincoli e policy RLS

## Vedere le prenotazioni
Table Editor → `prenotazioni` (esportabile in CSV). Dal browser non sono leggibili: RLS permette solo l'inserimento.

## Pubblicare
Settings → Pages → Deploy from branch `main` / root.
