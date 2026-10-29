-- ParcelaWeb: migração para campos de identificação de parcela e mês.
-- Execute no Supabase SQL Editor uma única vez antes de publicar o novo site.
ALTER TABLE public.installments ADD COLUMN IF NOT EXISTS label TEXT NOT NULL DEFAULT '';
ALTER TABLE public.installments ADD COLUMN IF NOT EXISTS month TEXT NOT NULL DEFAULT '';
ALTER TABLE public.installments ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();
-- O painel permite produto sem preço total informado.
ALTER TABLE public.products ALTER COLUMN total_amount DROP NOT NULL;

-- Habilita Realtime para as duas tabelas (se já estiverem na publicação, não altera).
DO $$ BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.products;
EXCEPTION WHEN duplicate_object THEN NULL;
WHEN undefined_object THEN RAISE NOTICE 'Publicação supabase_realtime não encontrada; habilite Realtime pelo painel.';
END $$;
DO $$ BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.installments;
EXCEPTION WHEN duplicate_object THEN NULL;
WHEN undefined_object THEN RAISE NOTICE 'Publicação supabase_realtime não encontrada; habilite Realtime pelo painel.';
END $$;
