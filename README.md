# Parcela Web

Aplicação web responsiva/PWA para controle de produtos e parcelas, com tema escuro, detalhes alaranjados, gráficos, armazenamento local, edição de parcelas, importação/exportação de backup e modo offline após a primeira visita.

## Arquivos

- `index.html` — interface e modais de cadastro.
- `styles.css` — tema responsivo.
- `app.js` — dados, cálculos, gráficos e CRUD.
- `manifest.webmanifest` — configuração PWA.
- `sw.js` — cache offline.
- `icons/` — ícones da aplicação.
- `.nojekyll` — evita processamento Jekyll no GitHub Pages.

## Publicar no GitHub Pages

1. Crie um repositório (ou use o repositório escolhido).
2. Envie **o conteúdo desta pasta**, não o ZIP, para a raiz do repositório. Mantenha `.nojekyll`.
3. No GitHub, abra **Settings → Pages**.
4. Em **Build and deployment**, selecione **Deploy from a branch**.
5. Selecione `main` e `/ (root)`, depois clique em **Save**.
6. Aguarde a publicação e abra o endereço mostrado na página Pages.

O service worker e a instalação PWA exigem HTTPS; GitHub Pages fornece HTTPS.

## Dados e privacidade

Os dados ficam no `localStorage` do navegador e não são enviados a um servidor. Isso significa que:
- celular e computador não sincronizam entre si;
- limpar os dados do site pode apagar os registros;
- exporte backups regularmente em **Configurações → Exportar dados**;
- importar um backup substitui os dados atuais.

## Widget Android

Uma PWA não cria diretamente um widget nativo na tela inicial do Android. Para ter um widget com botões de pagamento, é necessário manter uma implementação Android nativa.

## Dados iniciais e privacidade

A aplicação começa com dois registros **fictícios**, apenas para demonstrar a interface. Exclua-os ou substitua-os pelos seus próprios dados.

Os registros reais adicionados na aplicação ficam no `localStorage` do navegador e não são enviados a um servidor. Ainda assim, não coloque dados financeiros pessoais diretamente em `app.js`, `index.html`, no README ou em outros arquivos do repositório, especialmente se ele for público.

**Atenção ao histórico do Git:** apagar informações de um arquivo não as remove dos commits anteriores. Se uma versão antiga com dados pessoais já foi enviada ao repositório, crie um repositório público novo a partir desta versão sanitizada, em vez de simplesmente tornar público o repositório antigo.

## Cálculos

- O total pago e o saldo em aberto são calculados a partir das parcelas marcadas.
- O percentual usa a soma das parcelas como base quando a quantidade prevista está completa. Se ainda faltarem parcelas para cadastrar, usa o preço total informado quando disponível.
- O preço informado é preservado em campo separado da soma das parcelas.
- Alterações são gravadas no navegador automaticamente.
