# ParcelaWeb — sincronização em nuvem

Site estático/PWA para controle de produtos e parcelas. O login e a sincronização usam Supabase Auth + PostgreSQL + RLS. O site continua hospedado no GitHub Pages.

## Antes de publicar esta versão

1. No Supabase SQL Editor, execute o arquivo `supabase-migration.sql`. Ele adiciona os campos `label`, `month` e `updated_at` que a interface utiliza.
2. Confirme em **Authentication → URL Configuration** que Site URL e Redirect URL incluem `https://SEU-USUARIO.github.io/SEU-REPOSITORIO/`.
3. Em **Authentication → Sign In / Providers**, mantenha Email habilitado e cadastro permitido. A confirmação de e-mail pode permanecer ativada.
4. Verifique que RLS está ativo em `products` e `installments`, com políticas `FOR ALL` para `authenticated`, `USING (user_id = auth.uid())` e `WITH CHECK` equivalente. Nunca exponha `service_role`/secret key.
5. Envie o conteúdo desta pasta para a raiz do repositório do GitHub Pages e aguarde a publicação.

## Credenciais no navegador

A URL do projeto e a chave **Publishable** estão no começo de `app.js`. A publishable key é feita para o navegador; a segurança depende das políticas RLS. Nunca coloque uma `service_role` ou `sb_secret_...` no frontend.

## Primeira utilização e migração local

- Abra o site e crie uma conta com e-mail e senha.
- Se a conta já tiver dados na nuvem, o site perguntará antes de substituir a visualização local.
- Se a nuvem estiver vazia e o navegador tiver dados locais, o site perguntará se deseja enviá-los para a conta. Confira os registros antes de confirmar.
- Os dados locais não são apagados automaticamente durante a migração. Exporte um backup JSON em Configurações antes de trocar de aparelho ou migrar dados.
- Use a mesma conta nos dispositivos. Alterações são enviadas ao Supabase e atualizações remotas são recebidas por Realtime quando habilitado.

## Tabelas esperadas

`products`: `id` UUID, `user_id` UUID, `name`, `total_amount`, `installments_count`, `notes`, `created_at`, `updated_at`.

`installments`: `id` UUID, `user_id` UUID, `product_id` UUID, `installment_number`, `amount`, `due_date`, `paid`, `paid_at`, `label`, `month`, `created_at`, `updated_at`.

## Limitações importantes

- A primeira versão de sincronização não é um editor colaborativo com resolução sofisticada de conflitos. Evite editar o mesmo registro simultaneamente em dois aparelhos; use **Sincronizar agora** para atualizar manualmente.
- Realtime precisa estar habilitado para as duas tabelas na publicação `supabase_realtime`.
- O Supabase free pode ter limites de uso e inatividade; consulte o painel do serviço.
- Se o login funcionar mas o banco der erro, confira se executou `supabase-migration.sql` e se as políticas RLS existem.
- O site antigo pode ter cache de service worker. Após publicar, faça `Ctrl+F5`; no celular, feche e reabra o app. Se persistir código antigo, limpe os dados do site e entre novamente após exportar o backup.

## Arquivos

- `index.html` — interface e autenticação.
- `styles.css` — tema responsivo.
- `app.js` — lógica, autenticação, sincronização e CRUD.
- `supabase-migration.sql` — ajuste de esquema e publicação Realtime.
- `manifest.webmanifest`, `sw.js`, `icons/` — PWA.
