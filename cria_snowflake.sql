-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025-04-05 11:43:16 BRT
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

CREATE UNIQUE INDEX rm557311.pk_dim_bairro ON
    dim_bairro (
        sk_bairro
    ASC );

ALTER TABLE dim_bairro ADD CONSTRAINT pk_dim_bairro PRIMARY KEY ( sk_bairro );

CREATE TABLE dim_categoria (
    sk_categoria           NUMBER NOT NULL,
    nome_categoria         VARCHAR2(100 BYTE) NOT NULL,
    st_categoria           CHAR(1 BYTE) NOT NULL,
    nr_avaliacao_categoria NUMBER(3, 1)
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

CREATE UNIQUE INDEX rm557311.pk_dim_categoria ON
    dim_categoria (
        sk_categoria
    ASC );

ALTER TABLE dim_categoria ADD CONSTRAINT pk_dim_categoria PRIMARY KEY ( sk_categoria );

CREATE TABLE dim_centro_distribuicao (
    sk_centro_distribuicao   NUMBER NOT NULL,
    sk_logradouro            NUMBER NOT NULL,
    cd_cd                    NUMBER NOT NULL,
    nome_centro_distribuicao VARCHAR2(100 BYTE) NOT NULL
);

COMMENT ON TABLE dim_centro_distribuicao IS
    'Dimensão que armazena dados de cada Centro de Distribuição (CD), incluindo endereço via DIM_LOGRADOURO.';

COMMENT ON COLUMN dim_centro_distribuicao.sk_centro_distribuicao IS
    'Chave primária gerada por IDENTITY para a dimensão CENTRO DE DISTRIBUIÇÃO.';

COMMENT ON COLUMN dim_centro_distribuicao.cd_cd IS
    'Código identificador do Centro de Distribuição no sistema (CD).';

COMMENT ON COLUMN dim_centro_distribuicao.nome_centro_distribuicao IS
    'Nome do Centro de Distribuição (ex.: CD Norte, CD SP-1).';

CREATE UNIQUE INDEX rm557311.pk_dim_centrodist ON
    dim_centro_distribuicao (
        sk_centro_distribuicao
    ASC );

ALTER TABLE dim_centro_distribuicao ADD CONSTRAINT pk_dim_centrodist PRIMARY KEY ( sk_centro_distribuicao );

CREATE TABLE dim_cidade (
    sk_cidade    NUMBER NOT NULL,
    sk_estado    NUMBER NOT NULL,
    nome_cidade  VARCHAR2(100 BYTE) NOT NULL,
    nr_populacao NUMBER(10),
    codigo_ibge  NUMBER(10),
    altitude     NUMBER(5)
);

COMMENT ON TABLE dim_cidade IS
    'Dimensão que armazena dados das cidades, referenciando o Estado ao qual pertence.';

COMMENT ON COLUMN dim_cidade.sk_cidade IS
    'Chave primária gerada por IDENTITY para a dimensão CIDADE.';

COMMENT ON COLUMN dim_cidade.nome_cidade IS
    'Nome do município (por exemplo, São Paulo, Curitiba).';

COMMENT ON COLUMN dim_cidade.nr_populacao IS
    'População estimada da cidade.';

COMMENT ON COLUMN dim_cidade.codigo_ibge IS
    'Código da cidade segundo o IBGE.';

COMMENT ON COLUMN dim_cidade.altitude IS
    'Altitude média da cidade em metros.';

CREATE UNIQUE INDEX rm557311.pk_dim_cidade ON
    dim_cidade (
        sk_cidade
    ASC );

ALTER TABLE dim_cidade ADD CONSTRAINT pk_dim_cidade PRIMARY KEY ( sk_cidade );

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
    'Dimensão que armazena dados do cliente, vinculando o endereço via DIM_LOGRADOURO.';

COMMENT ON COLUMN dim_cliente.sk_cliente IS
    'Chave primária gerada por IDENTITY para a dimensão CLIENTE.';

COMMENT ON COLUMN dim_cliente.nr_cliente IS
    'Código de identificação do cliente no e-commerce.';

COMMENT ON COLUMN dim_cliente.nome_cliente IS
    'Nome completo do cliente.';

COMMENT ON COLUMN dim_cliente.nr_estrelas IS
    'Nível de fidelidade ou pontuação do cliente (ex.: 3 estrelas de 5).';

COMMENT ON COLUMN dim_cliente.st_cliente IS
    'Status do cliente (A=Ativo, I=Inativo).';

COMMENT ON COLUMN dim_cliente.dt_nascimento IS
    'Data de nascimento do cliente (se disponível).';

CREATE UNIQUE INDEX rm557311.pk_dim_cliente ON
    dim_cliente (
        sk_cliente
    ASC );

ALTER TABLE dim_cliente ADD CONSTRAINT pk_dim_cliente PRIMARY KEY ( sk_cliente );

CREATE TABLE dim_data (
    sk_data         NUMBER NOT NULL,
    data_completa   DATE NOT NULL,
    ano             NUMBER(4) NOT NULL,
    mes             NUMBER(2) NOT NULL,
    nome_mes        VARCHAR2(20 BYTE),
    dia             NUMBER(2) NOT NULL,
    nome_dia_semana VARCHAR2(20 BYTE)
);

COMMENT ON TABLE dim_data IS
    'Dimensão que armazena detalhes de datas, utilizada como Role-Playing (pedido, previsto, entrega).';

COMMENT ON COLUMN dim_data.sk_data IS
    'Chave primária gerada por IDENTITY para a dimensão DATA.';

COMMENT ON COLUMN dim_data.data_completa IS
    'Campo que armazena o dia exato no formato DATE (inclui hora, min, seg se necessário).';

COMMENT ON COLUMN dim_data.ano IS
    'Ano (yyyy).';

COMMENT ON COLUMN dim_data.mes IS
    'Mês numérico (1 a 12).';

COMMENT ON COLUMN dim_data.nome_mes IS
    'Nome do mês (Janeiro, Fevereiro etc.).';

COMMENT ON COLUMN dim_data.dia IS
    'Dia numérico (1 a 31).';

COMMENT ON COLUMN dim_data.nome_dia_semana IS
    'Nome do dia da semana (segunda, terça etc.).';

CREATE UNIQUE INDEX rm557311.pk_dim_data ON
    dim_data (
        sk_data
    ASC );

ALTER TABLE dim_data ADD CONSTRAINT pk_dim_data PRIMARY KEY ( sk_data );

CREATE TABLE dim_entregador (
    sk_entregador   NUMBER NOT NULL,
    nome_entregador VARCHAR2(100 BYTE) NOT NULL
);

COMMENT ON TABLE dim_entregador IS
    'Dimensão que armazena dados de cada entregador (pessoa responsável pelo transporte).';

COMMENT ON COLUMN dim_entregador.sk_entregador IS
    'Chave primária gerada por IDENTITY para a dimensão ENTREGADOR.';

COMMENT ON COLUMN dim_entregador.nome_entregador IS
    'Nome do entregador ou profissional responsável pelo envio.';

CREATE UNIQUE INDEX rm557311.pk_dim_entregador ON
    dim_entregador (
        sk_entregador
    ASC );

ALTER TABLE dim_entregador ADD CONSTRAINT pk_dim_entregador PRIMARY KEY ( sk_entregador );

CREATE TABLE dim_estado (
    sk_estado    NUMBER NOT NULL,
    sk_regiao    NUMBER NOT NULL,
    sigla_estado CHAR(2 BYTE) NOT NULL,
    nome_estado  VARCHAR2(50 BYTE) NOT NULL,
    gentilico    VARCHAR2(50)
);

COMMENT ON TABLE dim_estado IS
    'Dimensão que armazena dados dos Estados (UF), referenciando a região a que pertence.';

COMMENT ON COLUMN dim_estado.sk_estado IS
    'Chave primária gerada por IDENTITY para a dimensão ESTADO.';

COMMENT ON COLUMN dim_estado.sigla_estado IS
    'Sigla da unidade federativa (por exemplo, SP, RJ).';

COMMENT ON COLUMN dim_estado.nome_estado IS
    'Nome por extenso do Estado (por exemplo, São Paulo, Rio de Janeiro).';

COMMENT ON COLUMN dim_estado.gentilico IS
    'Termo que se refere aos habitantes do estado (ex.: paulista, carioca).';

CREATE UNIQUE INDEX rm557311.pk_dim_estado ON
    dim_estado (
        sk_estado
    ASC );

ALTER TABLE dim_estado ADD CONSTRAINT pk_dim_estado PRIMARY KEY ( sk_estado );

CREATE TABLE dim_logradouro (
    sk_logradouro   NUMBER NOT NULL,
    sk_bairro       NUMBER NOT NULL,
    nome_logradouro VARCHAR2(100 BYTE),
    nr_logradouro   VARCHAR2(10 BYTE),
    nr_cep          VARCHAR2(15 BYTE)
);

COMMENT ON TABLE dim_logradouro IS
    'Dimensão que armazena informações dos logradouros (rua, CEP, número etc.).';

COMMENT ON COLUMN dim_logradouro.sk_logradouro IS
    'Chave primária gerada por IDENTITY para a dimensão LOGRADOURO.';

COMMENT ON COLUMN dim_logradouro.nome_logradouro IS
    'Nome da rua/avenida/travessa, etc. (ex.: Av. Paulista).';

COMMENT ON COLUMN dim_logradouro.nr_logradouro IS
    'Número do endereço do logradouro (ex.: 100, 123B, S/N).';

COMMENT ON COLUMN dim_logradouro.nr_cep IS
    'CEP (Código de Endereçamento Postal).';

CREATE UNIQUE INDEX rm557311.pk_dim_logradouro ON
    dim_logradouro (
        sk_logradouro
    ASC );

ALTER TABLE dim_logradouro ADD CONSTRAINT pk_dim_logradouro PRIMARY KEY ( sk_logradouro );

CREATE TABLE dim_produto (
    sk_produto      NUMBER NOT NULL,
    sk_subcategoria NUMBER NOT NULL,
    nome_produto    VARCHAR2(150 BYTE) NOT NULL,
    embalagem       VARCHAR2(50 BYTE),
    id_subcategoria NUMBER NOT NULL
);

COMMENT ON TABLE dim_produto IS
    'Dimensão que armazena informações detalhadas de cada produto.';

COMMENT ON COLUMN dim_produto.sk_produto IS
    'Chave primária gerada por IDENTITY para a dimensão PRODUTO.';

COMMENT ON COLUMN dim_produto.nome_produto IS
    'Nome do produto (ex.: iPhone 14, TV 50 polegadas).';

COMMENT ON COLUMN dim_produto.embalagem IS
    'Tipo de embalagem, se houver (ex.: caixa, envelope etc.).';

COMMENT ON COLUMN dim_produto.id_subcategoria IS
    'Chave estrangeira para DIM_SUBCATEGORIA, definindo a subcategoria deste produto.';

CREATE UNIQUE INDEX rm557311.pk_dim_produto ON
    dim_produto (
        sk_produto
    ASC );

ALTER TABLE dim_produto ADD CONSTRAINT pk_dim_produto PRIMARY KEY ( sk_produto );

CREATE TABLE dim_regiao (
    sk_regiao   NUMBER NOT NULL,
    nome_regiao VARCHAR2(20 BYTE) NOT NULL
);

COMMENT ON TABLE dim_regiao IS
    'Dimensão que armazena informações de macrorregiões (Norte, Nordeste, Centro-Oeste, Sudeste, Sul).';

COMMENT ON COLUMN dim_regiao.sk_regiao IS
    'Chave primária gerada por IDENTITY para a dimensão REGIAO.';

COMMENT ON COLUMN dim_regiao.nome_regiao IS
    'Nome da região geográfica (Norte, Nordeste, etc.).';

CREATE UNIQUE INDEX rm557311.pk_dim_regiao ON
    dim_regiao (
        sk_regiao
    ASC );

ALTER TABLE dim_regiao ADD CONSTRAINT pk_dim_regiao PRIMARY KEY ( sk_regiao );

CREATE TABLE dim_subcategoria (
    sk_subcategoria            NUMBER NOT NULL,
    sk_categoria               NUMBER NOT NULL,
    nome_subcategoria          VARCHAR2(100 BYTE) NOT NULL,
    st_sub_categoria           CHAR(1 BYTE) NOT NULL,
    nr_avaliacao_sub_categoria NUMBER(3, 1)
);

COMMENT ON TABLE dim_subcategoria IS
    'Dimensão que armazena as subcategorias de produtos, vinculadas a uma categoria maior.';

COMMENT ON COLUMN dim_subcategoria.sk_subcategoria IS
    'Chave primária gerada por IDENTITY para a dimensão SUBCATEGORIA.';

COMMENT ON COLUMN dim_subcategoria.nome_subcategoria IS
    'Nome da subcategoria (ex.: Smartphones, Geladeiras).';

COMMENT ON COLUMN dim_subcategoria.st_sub_categoria IS
    'Status da subcategoria (A=Ativa, I=Inativa).';

COMMENT ON COLUMN dim_subcategoria.nr_avaliacao_sub_categoria IS
    'Nota de avaliação média da subcategoria.';

CREATE UNIQUE INDEX rm557311.pk_dim_subcategoria ON
    dim_subcategoria (
        sk_subcategoria
    ASC );

ALTER TABLE dim_subcategoria ADD CONSTRAINT pk_dim_subcategoria PRIMARY KEY ( sk_subcategoria );

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
    vl_unitario            NUMBER(12, 2) NOT NULL,
    vl_total               NUMBER(12, 2) NOT NULL,
    perc_icms              NUMBER(5, 2),
    nota_embalagem         NUMBER(2),
    nota_pontualidade      NUMBER(2),
    nota_cortesia          NUMBER(2),
    tempo_entrega_min      NUMBER(10)
);

COMMENT ON TABLE fato_entrega IS
    'Tabela Fato (grão: Pedido + Item). Armazena medições de entrega, ligando-se às dimensões Cliente, Produto, CD, Entregador e Datas.'
    ;

COMMENT ON COLUMN fato_entrega.sk_produto IS
    'FK para DIM_PRODUTO.';

COMMENT ON COLUMN fato_entrega.sk_centro_distribuicao IS
    'FK para DIM_CENTRO_DISTRIBUICAO (qual CD despachou o produto).';

COMMENT ON COLUMN fato_entrega.sk_data_prev IS
    'FK para a data de previsão da DIM_DATA.';

COMMENT ON COLUMN fato_entrega.sk_data_ped IS
    'FK para a data do pedido da DIM_DATA.';

COMMENT ON COLUMN fato_entrega.sk_cliente IS
    'FK para DIM_CLIENTE (quem recebe o produto).';

COMMENT ON COLUMN fato_entrega.nr_pedido IS
    'Número do pedido (código natural do sistema transacional). Parte 1 da PK.';

COMMENT ON COLUMN fato_entrega.nr_item IS
    'Número sequencial do item dentro do pedido. Parte 2 da PK.';

COMMENT ON COLUMN fato_entrega.sk_data_entrega IS
    'FK para a data de entrega da DIM_DATA.';

COMMENT ON COLUMN fato_entrega.sk_entregador IS
    'FK para DIM_ENTREGADOR (profissional que realizou a entrega).';

COMMENT ON COLUMN fato_entrega.quantidade IS
    'Quantidade de itens solicitados no pedido.';

COMMENT ON COLUMN fato_entrega.qt_prod_entregue IS
    'Quantidade efetiva de itens que foram entregues (pode variar da quantidade pedida).';

COMMENT ON COLUMN fato_entrega.vl_unitario IS
    'Valor unitário do item no momento da compra.';

COMMENT ON COLUMN fato_entrega.vl_total IS
    'Valor total da linha, normalmente QUANTIDADE x VL_UNITARIO.';

COMMENT ON COLUMN fato_entrega.perc_icms IS
    'Percentual de ICMS aplicado ao produto neste pedido.';

COMMENT ON COLUMN fato_entrega.nota_embalagem IS
    'Avaliação (0 a 10) do cliente quanto à embalagem do produto.';

COMMENT ON COLUMN fato_entrega.nota_pontualidade IS
    'Avaliação (0 a 10) do cliente quanto à pontualidade (cumprimento do prazo).';

COMMENT ON COLUMN fato_entrega.nota_cortesia IS
    'Avaliação (0 a 10) do cliente quanto à cordialidade do entregador.';

COMMENT ON COLUMN fato_entrega.tempo_entrega_min IS
    'Tempo total de entrega em minutos, calculado entre pedido e entrega real.';

CREATE UNIQUE INDEX rm557311.pk_fato_entrega ON
    fato_entrega (
        nr_pedido
    ASC,
        nr_item
    ASC );

ALTER TABLE fato_entrega
    ADD CONSTRAINT pk_fato_entrega PRIMARY KEY ( nr_pedido,
                                                 nr_item,
                                                 sk_produto,
                                                 sk_centro_distribuicao,
                                                 sk_data_prev,
                                                 sk_data_ped,
                                                 sk_cliente );

/* ============================================================
   CHAVES ESTRANGEIRAS
   ============================================================ */

ALTER TABLE dim_bairro
    ADD CONSTRAINT fk_bairro_cidade FOREIGN KEY ( sk_cidade )
        REFERENCES dim_cidade ( sk_cidade );

ALTER TABLE dim_centro_distribuicao
    ADD CONSTRAINT fk_centro_logra FOREIGN KEY ( sk_logradouro )
        REFERENCES dim_logradouro ( sk_logradouro );

ALTER TABLE dim_cidade
    ADD CONSTRAINT fk_cidade_estado FOREIGN KEY ( sk_estado )
        REFERENCES dim_estado ( sk_estado );

ALTER TABLE dim_cliente
    ADD CONSTRAINT fk_cliente_logra FOREIGN KEY ( sk_logradouro )
        REFERENCES dim_logradouro ( sk_logradouro );

ALTER TABLE dim_estado
    ADD CONSTRAINT fk_estado_regiao FOREIGN KEY ( sk_regiao )
        REFERENCES dim_regiao ( sk_regiao );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_centro FOREIGN KEY ( sk_centro_distribuicao )
        REFERENCES dim_centro_distribuicao ( sk_centro_distribuicao );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_cliente FOREIGN KEY ( sk_cliente )
        REFERENCES dim_cliente ( sk_cliente );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_data_entr FOREIGN KEY ( sk_data_entrega )
        REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_data_ped FOREIGN KEY ( sk_data_ped )
        REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_data_prv FOREIGN KEY ( sk_data_prev )
        REFERENCES dim_data ( sk_data );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_entregador FOREIGN KEY ( sk_entregador )
        REFERENCES dim_entregador ( sk_entregador );

ALTER TABLE fato_entrega
    ADD CONSTRAINT fk_fato_produto FOREIGN KEY ( sk_produto )
        REFERENCES dim_produto ( sk_produto );

ALTER TABLE dim_logradouro
    ADD CONSTRAINT fk_logra_bairro FOREIGN KEY ( sk_bairro )
        REFERENCES dim_bairro ( sk_bairro );

ALTER TABLE dim_produto
    ADD CONSTRAINT fk_produto_subcat FOREIGN KEY ( sk_subcategoria )
        REFERENCES dim_subcategoria ( sk_subcategoria );

ALTER TABLE dim_subcategoria
    ADD CONSTRAINT fk_subcat_cat FOREIGN KEY ( sk_categoria )
        REFERENCES dim_categoria ( sk_categoria );

/* ============================================================
   SEQUENCES E TRIGGERS
   ============================================================ */

/* ---------- dim_bairro ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_bairro_sk_bairro_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_bairro_sk_bairro_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_bairro_sk_bairro_trg
BEFORE INSERT ON dim_bairro
FOR EACH ROW
WHEN ( new.sk_bairro IS NULL )
BEGIN
    :new.sk_bairro := dim_bairro_sk_bairro_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_categoria ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_categoria_sk_categoria_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_categoria_sk_categoria_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_categoria_sk_categoria_trg
BEFORE INSERT ON dim_categoria
FOR EACH ROW
WHEN ( new.sk_categoria IS NULL )
BEGIN
    :new.sk_categoria := dim_categoria_sk_categoria_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_centro_distribuicao ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_centro_distribuicao_sk_centro_distribuicao_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_centro_distribuicao_sk_centro_distribuicao_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_centro_distribuicao_sk_centro_distribuicao_trg
BEFORE INSERT ON dim_centro_distribuicao
FOR EACH ROW
WHEN ( new.sk_centro_distribuicao IS NULL )
BEGIN
    :new.sk_centro_distribuicao := dim_centro_distribuicao_sk_centro_distribuicao_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_cidade ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_cidade_sk_cidade_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_cidade_sk_cidade_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_cidade_sk_cidade_trg
BEFORE INSERT ON dim_cidade
FOR EACH ROW
WHEN ( new.sk_cidade IS NULL )
BEGIN
    :new.sk_cidade := dim_cidade_sk_cidade_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_cliente ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_cliente_sk_cliente_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_cliente_sk_cliente_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_cliente_sk_cliente_trg
BEFORE INSERT ON dim_cliente
FOR EACH ROW
WHEN ( new.sk_cliente IS NULL )
BEGIN
    :new.sk_cliente := dim_cliente_sk_cliente_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_data ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_data_sk_data_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_data_sk_data_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_data_sk_data_trg
BEFORE INSERT ON dim_data
FOR EACH ROW
WHEN ( new.sk_data IS NULL )
BEGIN
    :new.sk_data := dim_data_sk_data_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_entregador ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_entregador_sk_entregador_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_entregador_sk_entregador_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_entregador_sk_entregador_trg
BEFORE INSERT ON dim_entregador
FOR EACH ROW
WHEN ( new.sk_entregador IS NULL )
BEGIN
    :new.sk_entregador := dim_entregador_sk_entregador_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_estado ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_estado_sk_estado_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_estado_sk_estado_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_estado_sk_estado_trg
BEFORE INSERT ON dim_estado
FOR EACH ROW
WHEN ( new.sk_estado IS NULL )
BEGIN
    :new.sk_estado := dim_estado_sk_estado_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_logradouro ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_logradouro_sk_logradouro_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_logradouro_sk_logradouro_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_logradouro_sk_logradouro_trg
BEFORE INSERT ON dim_logradouro
FOR EACH ROW
WHEN ( new.sk_logradouro IS NULL )
BEGIN
    :new.sk_logradouro := dim_logradouro_sk_logradouro_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_produto ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_produto_sk_produto_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_produto_sk_produto_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_produto_sk_produto_trg
BEFORE INSERT ON dim_produto
FOR EACH ROW
WHEN ( new.sk_produto IS NULL )
BEGIN
    :new.sk_produto := dim_produto_sk_produto_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_regiao ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_regiao_sk_regiao_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_regiao_sk_regiao_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_regiao_sk_regiao_trg
BEFORE INSERT ON dim_regiao
FOR EACH ROW
WHEN ( new.sk_regiao IS NULL )
BEGIN
    :new.sk_regiao := dim_regiao_sk_regiao_seq.nextval;
END;
/
---------------------------------------------------------------

/* ---------- dim_subcategoria ---------- */
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE dim_subcategoria_sk_subcategoria_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
CREATE SEQUENCE dim_subcategoria_sk_subcategoria_seq START WITH 1 CACHE 20;

CREATE OR REPLACE TRIGGER dim_subcategoria_sk_subcategoria_trg
BEFORE INSERT ON dim_subcategoria
FOR EACH ROW
WHEN ( new.sk_subcategoria IS NULL )
BEGIN
    :new.sk_subcategoria := dim_subcategoria_sk_subcategoria_seq.nextval;
END;
/
---------------------------------------------------------------

/* ============================================================
   RELATÓRIO DE OBJETOS CRIADOS
   ============================================================ */

-- CREATE TABLE                            13
-- CREATE INDEX                            13
-- ALTER TABLE                             28
-- CREATE TRIGGER                          12
-- CREATE SEQUENCE                         12
-- (demais objetos = 0)
