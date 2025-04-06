-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025‑04‑05 11:43:16 BRT
--   site:      Oracle Database 12cR2
--   tipo:      Oracle Database 12cR2

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE

/* ============================================================
   TABELAS DIMENSÃO
   ============================================================ */

CREATE TABLE dim_bairro (
    sk_bairro           NUMBER NOT NULL,
    sk_cidade           NUMBER NOT NULL,
    nome_bairro         VARCHAR2(100 BYTE) NOT NULL,
    nr_populacao_bairro NUMBER(9),
    nr_nivel_seguranca  NUMBER(1)
);

COMMENT ON TABLE dim_bairro IS
    'Dimensão que detalha os bairros, vinculados a uma determinada cidade.';

COMMENT ON COLUMN dim_bairro.sk_bairro IS
    'Chave primária gerada por IDENTITY para a dimensão BAIRRO.';

COMMENT ON COLUMN dim_bairro.nome_bairro IS
    'Nome do bairro (por exemplo, Bela Vista, Centro).';

COMMENT ON COLUMN dim_bairro.nr_populacao_bairro IS
    'População estimada do bairro.';

COMMENT ON COLUMN dim_bairro.nr_nivel_seguranca IS
    'Índice ou indicador de segurança atribuído ao bairro, de 0 a 9 (exemplo).';

CREATE UNIQUE INDEX pk_dim_bairro ON dim_bairro ( sk_bairro );

ALTER TABLE dim_bairro
  ADD CONSTRAINT pk_dim_bairro PRIMARY KEY ( sk_bairro );

/* ---------- dim_categoria ---------- */
CREATE TABLE dim_categoria (
    sk_categoria           NUMBER NOT NULL,
    nome_categoria         VARCHAR2(100 BYTE) NOT NULL,
    st_categoria           CHAR(1 BYTE) NOT NULL,
    nr_avaliacao_categoria NUMBER(3,1)
);

COMMENT ON TABLE dim_categoria IS
    'Dimensão que armazena as diferentes categorias de produtos.';

COMMENT ON COLUMN dim_categoria.sk_categoria IS
    'Chave primária gerada por IDENTITY para a dimensão CATEGORIA.';

COMMENT ON COLUMN dim_categoria.nome_categoria IS
    'Nome da categoria (ex.: Eletrônicos, Eletrodomésticos).';

COMMENT ON COLUMN dim_categoria.st_categoria IS
    'Status da categoria (A=Ativa, I=Inativa).';

COMMENT ON COLUMN dim_categoria.nr_avaliacao_categoria IS
    'Nota de avaliação média da categoria.';

CREATE UNIQUE INDEX pk_dim_categoria ON dim_categoria ( sk_categoria );

ALTER TABLE dim_categoria
  ADD CONSTRAINT pk_dim_categoria PRIMARY KEY ( sk_categoria );

/* ---------- dim_centro_distribuicao ---------- */
CREATE TABLE dim_centro_distribuicao (
    sk_centro_distribuicao   NUMBER NOT NULL,
    sk_logradouro            NUMBER NOT NULL,
    cd_cd                    NUMBER NOT NULL,
    nome_centro_distribuicao VARCHAR2(100 BYTE) NOT NULL
);

COMMENT ON TABLE dim_centro_distribuicao IS
    'Dimensão que armazena dados de cada Centro de Distribuição (CD).';

COMMENT ON COLUMN dim_centro_distribuicao.sk_centro_distribuicao IS
    'Chave primária gerada por IDENTITY.';

CREATE UNIQUE INDEX pk_dim_centrodist
    ON dim_centro_distribuicao ( sk_centro_distribuicao );

ALTER TABLE dim_centro_distribuicao
  ADD CONSTRAINT pk_dim_centrodist PRIMARY KEY ( sk_centro_distribuicao );

/* ---------- dim_cidade ---------- */
CREATE TABLE dim_cidade (
    sk_cidade    NUMBER NOT NULL,
    sk_estado    NUMBER NOT NULL,
    nome_cidade  VARCHAR2(100 BYTE) NOT NULL,
    nr_populacao NUMBER(10),
    codigo_ibge  NUMBER(10),
    altitude     NUMBER(5)
);

COMMENT ON TABLE dim_cidade IS
    'Dimensão que armazena dados das cidades.';

CREATE UNIQUE INDEX pk_dim_cidade ON dim_cidade ( sk_cidade );

ALTER TABLE dim_cidade
  ADD CONSTRAINT pk_dim_cidade PRIMARY KEY ( sk_cidade );

/* ---------- dim_cliente ---------- */
CREATE TABLE dim_cliente (
    sk_cliente    NUMBER NOT NULL,
    sk_logradouro NUMBER NOT NULL,
    nr_cliente    NUMBER NOT NULL,
    nome_cliente  VARCHAR2(100 BYTE) NOT NULL,
    nr_estrelas   NUMBER(1),
    st_cliente    CHAR(1 BYTE),
    dt_nascimento DATE
);

COMMENT ON TABLE dim_cliente IS
    'Dimensão de clientes.';

CREATE UNIQUE INDEX pk_dim_cliente ON dim_cliente ( sk_cliente );

ALTER TABLE dim_cliente
  ADD CONSTRAINT pk_dim_cliente PRIMARY KEY ( sk_cliente );

/* ---------- dim_data ---------- */
CREATE TABLE dim_data (
    sk_data         NUMBER NOT NULL,
    data_completa   DATE   NOT NULL,
    ano             NUMBER(4) NOT NULL,
    mes             NUMBER(2) NOT NULL,
    nome_mes        VARCHAR2(20),
    dia             NUMBER(2) NOT NULL,
    nome_dia_semana VARCHAR2(20)
);

COMMENT ON TABLE dim_data IS
    'Dimensão de datas.';

CREATE UNIQUE INDEX pk_dim_data ON dim_data ( sk_data );

ALTER TABLE dim_data
  ADD CONSTRAINT pk_dim_data PRIMARY KEY ( sk_data );

/* ---------- dim_entregador ---------- */
CREATE TABLE dim_entregador (
    sk_entregador   NUMBER NOT NULL,
    nome_entregador VARCHAR2(100 BYTE) NOT NULL
);

CREATE UNIQUE INDEX pk_dim_entregador ON dim_entregador ( sk_entregador );

ALTER TABLE dim_entregador
  ADD CONSTRAINT pk_dim_entregador PRIMARY KEY ( sk_entregador );

/* ---------- dim_estado ---------- */
CREATE TABLE dim_estado (
    sk_estado    NUMBER NOT NULL,
    sk_regiao    NUMBER NOT NULL,
    sigla_estado CHAR(2 BYTE) NOT NULL,
    nome_estado  VARCHAR2(50 BYTE) NOT NULL,
    gentilico    VARCHAR2(50)
);

CREATE UNIQUE INDEX pk_dim_estado ON dim_estado ( sk_estado );

ALTER TABLE dim_estado
  ADD CONSTRAINT pk_dim_estado PRIMARY KEY ( sk_estado );

/* ---------- dim_logradouro ---------- */
CREATE TABLE dim_logradouro (
    sk_logradouro   NUMBER NOT NULL,
    sk_bairro       NUMBER NOT NULL,
    nome_logradouro VARCHAR2(100),
    nr_logradouro   VARCHAR2(10),
    nr_cep          VARCHAR2(15)
);

CREATE UNIQUE INDEX pk_dim_logradouro ON dim_logradouro ( sk_logradouro );

ALTER TABLE dim_logradouro
  ADD CONSTRAINT pk_dim_logradouro PRIMARY KEY ( sk_logradouro );

/* ---------- dim_produto ---------- */
CREATE TABLE dim_produto (
    sk_produto      NUMBER NOT NULL,
    sk_subcategoria NUMBER NOT NULL,
    nome_produto    VARCHAR2(150 BYTE) NOT NULL,
    embalagem       VARCHAR2(50),
    id_subcategoria NUMBER NOT NULL
);

CREATE UNIQUE INDEX pk_dim_produto ON dim_produto ( sk_produto );

ALTER TABLE dim_produto
  ADD CONSTRAINT pk_dim_produto PRIMARY KEY ( sk_produto );

/* ---------- dim_regiao ---------- */
CREATE TABLE dim_regiao (
    sk_regiao   NUMBER NOT NULL,
    nome_regiao VARCHAR2(20 BYTE) NOT NULL
);

CREATE UNIQUE INDEX pk_dim_regiao ON dim_regiao ( sk_regiao );

ALTER TABLE dim_regiao
  ADD CONSTRAINT pk_dim_regiao PRIMARY KEY ( sk_regiao );

/* ---------- dim_subcategoria ---------- */
CREATE TABLE dim_subcategoria (
    sk_subcategoria            NUMBER NOT NULL,
    sk_categoria               NUMBER NOT NULL,
    nome_subcategoria          VARCHAR2(100 BYTE) NOT NULL,
    st_sub_categoria           CHAR(1 BYTE) NOT NULL,
    nr_avaliacao_sub_categoria NUMBER(3,1)
);

CREATE UNIQUE INDEX pk_dim_subcategoria
    ON dim_subcategoria ( sk_subcategoria );

ALTER TABLE dim_subcategoria
  ADD CONSTRAINT pk_dim_subcategoria PRIMARY KEY ( sk_subcategoria );

/* ============================================================
   TABELA FATO
   ============================================================ */

CREATE TABLE fato_entrega (
    sk_produto             NUMBER NOT NULL,
    sk_centro_distribuicao NUMBER NOT NULL,
    sk_data_prev           NUMBER NOT NULL,
    sk_data_ped            NUMBER NOT NULL,
    sk_cliente             NUMBER NOT NULL,
    nr_pedido              NUMBER NOT NULL,
    nr_item                NUMBER NOT NULL,
    sk_data_entrega        NUMBER NOT NULL,
    sk_entregador          NUMBER,
    quantidade             NUMBER(10) NOT NULL,
    qt_prod_entregue       NUMBER(10) NOT NULL,
    vl_unitario            NUMBER(12,2) NOT NULL,
    vl_total               NUMBER(12,2) NOT NULL,
    perc_icms              NUMBER(5,2),
    nota_embalagem         NUMBER(2),
    nota_pontualidade      NUMBER(2),
    nota_cortesia          NUMBER(2),
    tempo_entrega_min      NUMBER(10)
);

CREATE UNIQUE INDEX uidx_fato_entrega
    ON fato_entrega ( nr_pedido, nr_item );

ALTER TABLE fato_entrega
  ADD CONSTRAINT pk_fato_entrega PRIMARY KEY (
      nr_pedido,
      nr_item,
      sk_produto,
      sk_centro_distribuicao,
      sk_data_prev,
      sk_data_ped,
      sk_cliente
);

/* ============================================================
   CHAVES ESTRANGEIRAS
   ============================================================ */

ALTER TABLE dim_bairro
  ADD CONSTRAINT fk_bairro_cidade
  FOREIGN KEY ( sk_cidade )
  REFERENCES dim_cidade ( sk_cidade );

ALTER TABLE dim_centro_distribuicao
  ADD CONSTRAINT fk_centro_logra
  FOREIGN KEY ( sk_logradouro )
  REFERENCES dim_logradouro ( sk_logradouro );

ALTER TABLE dim_cidade
  ADD CONSTRAINT fk_cidade_estado
  FOREIGN KEY ( sk_estado )
  REFERENCES dim_estado ( sk_estado );

ALTER TABLE dim_cliente
  ADD CONSTRAINT fk_cliente_logra
  FOREIGN KEY ( sk_logradouro )
  REFERENCES dim_logradouro ( sk_logradouro );

ALTER TABLE dim_estado
  ADD CONSTRAINT fk_estado_regiao
  FOREIGN KEY ( sk_regiao )
  REFERENCES dim_regiao ( sk_regiao );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_centro
  FOREIGN KEY ( sk_centro_distribuicao )
  REFERENCES dim_centro_distribuicao ( sk_centro_distribuicao );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_cliente
  FOREIGN KEY ( sk_cliente )
  REFERENCES dim_cliente ( sk_cliente );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_data_entr
  FOREIGN KEY ( sk_data_entrega )
  REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_data_ped
  FOREIGN KEY ( sk_data_ped )
  REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_data_prv
  FOREIGN KEY ( sk_data_prev )
  REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_entregador
  FOREIGN KEY ( sk_entregador )
  REFERENCES dim_entregador ( sk_entregador );

ALTER TABLE fato_entrega
  ADD CONSTRAINT fk_fato_produto
  FOREIGN KEY ( sk_produto )
  REFERENCES dim_produto ( sk_produto );

ALTER TABLE dim_logradouro
  ADD CONSTRAINT fk_logra_bairro
  FOREIGN KEY ( sk_bairro )
  REFERENCES dim_bairro ( sk_bairro );

ALTER TABLE dim_produto
  ADD CONSTRAINT fk_produto_subcat
  FOREIGN KEY ( sk_subcategoria )
  REFERENCES dim_subcategoria ( sk_subcategoria );

ALTER TABLE dim_subcategoria
  ADD CONSTRAINT fk_subcat_cat
  FOREIGN KEY ( sk_categoria )
  REFERENCES dim_categoria ( sk_categoria );

/* ============================================================
   SEQUENCES E TRIGGERS
   ============================================================ */

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_bairro_sk_bairro_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_bairro_sk_bairro_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_bairro_sk_bairro_trg
BEFORE INSERT ON dim_bairro
FOR EACH ROW
WHEN ( NEW.sk_bairro IS NULL )
BEGIN
    :NEW.sk_bairro := dim_bairro_sk_bairro_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_categoria_sk_categoria_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_categoria_sk_categoria_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_categoria_sk_categoria_trg
BEFORE INSERT ON dim_categoria
FOR EACH ROW
WHEN ( NEW.sk_categoria IS NULL )
BEGIN
    :NEW.sk_categoria := dim_categoria_sk_categoria_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_centro_distribuicao_sk_centro_distribuicao_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_centro_distribuicao_sk_centro_distribuicao_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_centro_distribuicao_sk_centro_distribuicao_trg
BEFORE INSERT ON dim_centro_distribuicao
FOR EACH ROW
WHEN ( NEW.sk_centro_distribuicao IS NULL )
BEGIN
    :NEW.sk_centro_distribuicao := dim_centro_distribuicao_sk_centro_distribuicao_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_cidade_sk_cidade_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_cidade_sk_cidade_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_cidade_sk_cidade_trg
BEFORE INSERT ON dim_cidade
FOR EACH ROW
WHEN ( NEW.sk_cidade IS NULL )
BEGIN
    :NEW.sk_cidade := dim_cidade_sk_cidade_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_cliente_sk_cliente_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_cliente_sk_cliente_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_cliente_sk_cliente_trg
BEFORE INSERT ON dim_cliente
FOR EACH ROW
WHEN ( NEW.sk_cliente IS NULL )
BEGIN
    :NEW.sk_cliente := dim_cliente_sk_cliente_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_data_sk_data_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_data_sk_data_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_data_sk_data_trg
BEFORE INSERT ON dim_data
FOR EACH ROW
WHEN ( NEW.sk_data IS NULL )
BEGIN
    :NEW.sk_data := dim_data_sk_data_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_entregador_sk_entregador_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_entregador_sk_entregador_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_entregador_sk_entregador_trg
BEFORE INSERT ON dim_entregador
FOR EACH ROW
WHEN ( NEW.sk_entregador IS NULL )
BEGIN
    :NEW.sk_entregador := dim_entregador_sk_entregador_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_estado_sk_estado_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_estado_sk_estado_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_estado_sk_estado_trg
BEFORE INSERT ON dim_estado
FOR EACH ROW
WHEN ( NEW.sk_estado IS NULL )
BEGIN
    :NEW.sk_estado := dim_estado_sk_estado_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_logradouro_sk_logradouro_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_logradouro_sk_logradouro_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_logradouro_sk_logradouro_trg
BEFORE INSERT ON dim_logradouro
FOR EACH ROW
WHEN ( NEW.sk_logradouro IS NULL )
BEGIN
    :NEW.sk_logradouro := dim_logradouro_sk_logradouro_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_produto_sk_produto_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_produto_sk_produto_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_produto_sk_produto_trg
BEFORE INSERT ON dim_produto
FOR EACH ROW
WHEN ( NEW.sk_produto IS NULL )
BEGIN
    :NEW.sk_produto := dim_produto_sk_produto_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_regiao_sk_regiao_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_regiao_sk_regiao_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_regiao_sk_regiao_trg
BEFORE INSERT ON dim_regiao
FOR EACH ROW
WHEN ( NEW.sk_regiao IS NULL )
BEGIN
    :NEW.sk_regiao := dim_regiao_sk_regiao_seq.NEXTVAL;
END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE dim_subcategoria_sk_subcategoria_seq';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/
CREATE SEQUENCE dim_subcategoria_sk_subcategoria_seq START WITH 1 CACHE 20;
CREATE OR REPLACE TRIGGER dim_subcategoria_sk_subcategoria_trg
BEFORE INSERT ON dim_subcategoria
FOR EACH ROW
WHEN ( NEW.sk_subcategoria IS NULL )
BEGIN
    :NEW.sk_subcategoria := dim_subcategoria_sk_subcategoria_seq.NEXTVAL;
END;
/

/* ============================================================
   RELATÓRIO DE OBJETOS CRIADOS
   ============================================================ */
-- CREATE TABLE            13
-- CREATE INDEX            13
-- ALTER TABLE             28
-- CREATE SEQUENCE         12
-- CREATE TRIGGER          12
