--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.14
-- Dumped by pg_dump version 9.6.14

-- Started on 2020-12-21 11:40:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 190 (class 1259 OID 53630)
-- Name: acao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acao (
    id integer NOT NULL,
    gestor_id integer,
    plano_id integer,
    unidade_id integer,
    objetivo_geral text,
    objetivos_especificos text,
    titulo character varying(255)
);


--
-- TOC entry 191 (class 1259 OID 53639)
-- Name: acao_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.acao_areas (
    acao_id integer NOT NULL,
    areas_id integer NOT NULL
);


--
-- TOC entry 189 (class 1259 OID 53628)
-- Name: acao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.acao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 189
-- Name: acao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.acao_id_seq OWNED BY public.acao.id;


--
-- TOC entry 193 (class 1259 OID 53644)
-- Name: area_atuacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area_atuacao (
    id integer NOT NULL,
    nome character varying(255),
    plano_id integer,
    descricao character varying(255)
);


--
-- TOC entry 192 (class 1259 OID 53642)
-- Name: area_atuacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.area_atuacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 192
-- Name: area_atuacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_atuacao_id_seq OWNED BY public.area_atuacao.id;


--
-- TOC entry 195 (class 1259 OID 53652)
-- Name: avaliacao_controle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avaliacao_controle (
    id integer NOT NULL,
    descricao text,
    nome character varying(255),
    plano_id integer,
    fator numeric(19,2)
);


--
-- TOC entry 194 (class 1259 OID 53650)
-- Name: avaliacao_controle_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.avaliacao_controle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 194
-- Name: avaliacao_controle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.avaliacao_controle_id_seq OWNED BY public.avaliacao_controle.id;


--
-- TOC entry 197 (class 1259 OID 53663)
-- Name: avaliacao_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avaliacao_risco (
    id integer NOT NULL,
    data date,
    avaliacao_controle_id integer,
    impacto_id integer,
    probabilidade_id integer,
    responsavel_id integer,
    risco_id integer,
    periodicidade character varying(255),
    causa text,
    consequencia text,
    controles text
);


--
-- TOC entry 196 (class 1259 OID 53661)
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.avaliacao_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 196
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.avaliacao_risco_id_seq OWNED BY public.avaliacao_risco.id;


--
-- TOC entry 199 (class 1259 OID 53671)
-- Name: categoria_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria_risco (
    id integer NOT NULL,
    descricao text,
    nome character varying(255),
    plano_id integer
);


--
-- TOC entry 198 (class 1259 OID 53669)
-- Name: categoria_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoria_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 198
-- Name: categoria_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_risco_id_seq OWNED BY public.categoria_risco.id;


--
-- TOC entry 201 (class 1259 OID 53682)
-- Name: impacto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impacto (
    id integer NOT NULL,
    descricao text,
    nome character varying(255),
    plano_id integer,
    peso integer
);


--
-- TOC entry 200 (class 1259 OID 53680)
-- Name: impacto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.impacto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 200
-- Name: impacto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.impacto_id_seq OWNED BY public.impacto.id;


--
-- TOC entry 203 (class 1259 OID 53693)
-- Name: nivel_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nivel_risco (
    id integer NOT NULL,
    cor character varying(255),
    descricao text,
    nome character varying(255),
    plano_id integer,
    valor_final numeric(19,2),
    valor_inicial numeric(19,2),
    periodicidade character varying(255),
    apetite boolean DEFAULT false NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 53691)
-- Name: nivel_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nivel_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 202
-- Name: nivel_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nivel_risco_id_seq OWNED BY public.nivel_risco.id;


--
-- TOC entry 204 (class 1259 OID 53702)
-- Name: nivel_risco_respostas_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nivel_risco_respostas_risco (
    nivel_risco_id integer NOT NULL,
    respostas_risco_id integer NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 53707)
-- Name: ocorrencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ocorrencia (
    id integer NOT NULL,
    data date,
    descricao character varying(255),
    resultados character varying(255),
    solucao character varying(255),
    plano_contingencia_id integer,
    responsavel_id integer,
    risco_id integer
);


--
-- TOC entry 205 (class 1259 OID 53705)
-- Name: ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ocorrencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 205
-- Name: ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ocorrencia_id_seq OWNED BY public.ocorrencia.id;


--
-- TOC entry 208 (class 1259 OID 53718)
-- Name: plano; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano (
    id integer NOT NULL,
    data_fim date,
    data_inicio date,
    descricao text,
    nome character varying(255)
);


--
-- TOC entry 228 (class 1259 OID 60796)
-- Name: plano_apetite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_apetite (
    plano_id integer NOT NULL,
    apetite_id integer NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 53727)
-- Name: plano_areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_areas (
    plano_id integer NOT NULL,
    areas_id integer NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 53730)
-- Name: plano_avaliacoes_controle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_avaliacoes_controle (
    plano_id integer NOT NULL,
    avaliacoes_controle_id integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 53733)
-- Name: plano_categorias_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_categorias_risco (
    plano_id integer NOT NULL,
    categorias_risco_id integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 53750)
-- Name: plano_contingencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_contingencia (
    id integer NOT NULL,
    acao character varying(255),
    gatilho character varying(255),
    responsavel_id integer,
    risco_id integer
);


--
-- TOC entry 216 (class 1259 OID 53748)
-- Name: plano_contingencia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plano_contingencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 216
-- Name: plano_contingencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plano_contingencia_id_seq OWNED BY public.plano_contingencia.id;


--
-- TOC entry 207 (class 1259 OID 53716)
-- Name: plano_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plano_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 207
-- Name: plano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plano_id_seq OWNED BY public.plano.id;


--
-- TOC entry 212 (class 1259 OID 53736)
-- Name: plano_impactos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_impactos (
    plano_id integer NOT NULL,
    impactos_id integer NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 53739)
-- Name: plano_niveis_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_niveis_risco (
    plano_id integer NOT NULL,
    niveis_risco_id integer NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 53742)
-- Name: plano_probabilidades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_probabilidades (
    plano_id integer NOT NULL,
    probabilidades_id integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 53745)
-- Name: plano_respostas_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_respostas_risco (
    plano_id integer NOT NULL,
    respostas_risco_id integer NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 53761)
-- Name: plano_tratamento_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_tratamento_risco (
    id integer NOT NULL,
    custos character varying(255),
    data_planejamento date,
    inicio date,
    justificativa character varying(255),
    monitoramento character varying(255),
    plano_acao character varying(255),
    termino date,
    responsavel_id integer,
    resposta_risco_id integer
);


--
-- TOC entry 218 (class 1259 OID 53759)
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plano_tratamento_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 218
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plano_tratamento_risco_id_seq OWNED BY public.plano_tratamento_risco.id;


--
-- TOC entry 221 (class 1259 OID 53772)
-- Name: probabilidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.probabilidade (
    id integer NOT NULL,
    descricao text,
    nome character varying(255),
    plano_id integer,
    peso integer
);


--
-- TOC entry 220 (class 1259 OID 53770)
-- Name: probabilidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.probabilidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 220
-- Name: probabilidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.probabilidade_id_seq OWNED BY public.probabilidade.id;


--
-- TOC entry 223 (class 1259 OID 53783)
-- Name: resposta_risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resposta_risco (
    id integer NOT NULL,
    descricao text,
    nome character varying(255),
    plano_id integer,
    ameaca boolean NOT NULL,
    oportunidade boolean NOT NULL,
    plano_tratamento boolean NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 53781)
-- Name: resposta_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resposta_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 222
-- Name: resposta_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resposta_risco_id_seq OWNED BY public.resposta_risco.id;


--
-- TOC entry 225 (class 1259 OID 53794)
-- Name: risco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.risco (
    id integer NOT NULL,
    nome character varying(255),
    periodicidade_avaliacao character varying(255),
    tipo character varying(255),
    plano_id integer,
    plano_tratamento_id integer,
    responsavel_id integer,
    unidade_id integer,
    causa text,
    consequencia text,
    controles text
);


--
-- TOC entry 226 (class 1259 OID 53803)
-- Name: risco_acoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.risco_acoes (
    risco_id integer NOT NULL,
    acoes_id integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 53806)
-- Name: risco_categorias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.risco_categorias (
    risco_id integer NOT NULL,
    categorias_id integer NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 53792)
-- Name: risco_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 224
-- Name: risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.risco_id_seq OWNED BY public.risco.id;


--
-- TOC entry 186 (class 1259 OID 44725)
-- Name: unidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unidade (
    id integer NOT NULL,
    excluida boolean NOT NULL,
    nome character varying(255),
    sigla character varying(255),
    chefe_id integer,
    unidade_pai_id integer,
    vice_chefe_id integer
);


--
-- TOC entry 185 (class 1259 OID 44723)
-- Name: unidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 185
-- Name: unidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unidade_id_seq OWNED BY public.unidade.id;


--
-- TOC entry 188 (class 1259 OID 44736)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    cargo character varying(255),
    email character varying(255),
    habilitado boolean NOT NULL,
    nome character varying(255),
    password character varying(255),
    unidade_id integer
);


--
-- TOC entry 187 (class 1259 OID 44734)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 2157 (class 2604 OID 53633)
-- Name: acao id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao ALTER COLUMN id SET DEFAULT nextval('public.acao_id_seq'::regclass);


--
-- TOC entry 2158 (class 2604 OID 53647)
-- Name: area_atuacao id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_atuacao ALTER COLUMN id SET DEFAULT nextval('public.area_atuacao_id_seq'::regclass);


--
-- TOC entry 2159 (class 2604 OID 53655)
-- Name: avaliacao_controle id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_controle ALTER COLUMN id SET DEFAULT nextval('public.avaliacao_controle_id_seq'::regclass);


--
-- TOC entry 2160 (class 2604 OID 53666)
-- Name: avaliacao_risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco ALTER COLUMN id SET DEFAULT nextval('public.avaliacao_risco_id_seq'::regclass);


--
-- TOC entry 2161 (class 2604 OID 53674)
-- Name: categoria_risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria_risco ALTER COLUMN id SET DEFAULT nextval('public.categoria_risco_id_seq'::regclass);


--
-- TOC entry 2162 (class 2604 OID 53685)
-- Name: impacto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impacto ALTER COLUMN id SET DEFAULT nextval('public.impacto_id_seq'::regclass);


--
-- TOC entry 2163 (class 2604 OID 53696)
-- Name: nivel_risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nivel_risco ALTER COLUMN id SET DEFAULT nextval('public.nivel_risco_id_seq'::regclass);


--
-- TOC entry 2165 (class 2604 OID 53710)
-- Name: ocorrencia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocorrencia ALTER COLUMN id SET DEFAULT nextval('public.ocorrencia_id_seq'::regclass);


--
-- TOC entry 2166 (class 2604 OID 53721)
-- Name: plano id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano ALTER COLUMN id SET DEFAULT nextval('public.plano_id_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 53753)
-- Name: plano_contingencia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_contingencia ALTER COLUMN id SET DEFAULT nextval('public.plano_contingencia_id_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 53764)
-- Name: plano_tratamento_risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_tratamento_risco ALTER COLUMN id SET DEFAULT nextval('public.plano_tratamento_risco_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 53775)
-- Name: probabilidade id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.probabilidade ALTER COLUMN id SET DEFAULT nextval('public.probabilidade_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 53786)
-- Name: resposta_risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta_risco ALTER COLUMN id SET DEFAULT nextval('public.resposta_risco_id_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 53797)
-- Name: risco id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco ALTER COLUMN id SET DEFAULT nextval('public.risco_id_seq'::regclass);


--
-- TOC entry 2155 (class 2604 OID 44728)
-- Name: unidade id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade ALTER COLUMN id SET DEFAULT nextval('public.unidade_id_seq'::regclass);


--
-- TOC entry 2156 (class 2604 OID 44739)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 2398 (class 0 OID 53630)
-- Dependencies: 190
-- Data for Name: acao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.acao VALUES (3, 2, 1, 2, 'Incentivar a curricularização das atividades de Cultura (arte', 'Criar o Comitê de Cultura (arte e esporte);', 'Ampliar os mecanismos de financiamento para a área de cultura artística e esportiva da UFC');
INSERT INTO public.acao VALUES (4, 2, 1, 2, 'Expandir a quantidade dos estágios obrigatórios e não obrigatórios nacionais e internacionais.', '<ul><li>Normatizar o funcionamento de ligas, núcleos e grupos internos da UFC, visando definir com clareza como deve ocorrer o estágio;</li><li>Criar uma sessão dentro dos encontros universitários em que as empresas possam expor suas oportunidades e experiências de estágios;</li><li>Criar o um Programa de Estágios na UFC para identificar oportunidades de estágios dentro da própria universidade;</li><li>Articular ações conjuntas com a PROINTER voltadas para a internacionalização dos estágios.</li></ul>', 'Expansão do estágio');
INSERT INTO public.acao VALUES (6, 2, 1, 2, 'Objetivo geral da ação', '<ol><li>Primeiro objetivo</li><li>Segundo objetivo</li></ol>', 'Nova ação');
INSERT INTO public.acao VALUES (2, 2, 1, 2, 'Avaliar a viabilidade da criação da Secretaria de Esporte (ou', '<ul><li>Criar o Comitê de Cultura (arte e esporte);</li></ul>', 'Fortalecer o processo de institucionalização da Cultura Artística e Esportiva na UFC');


--
-- TOC entry 2399 (class 0 OID 53639)
-- Dependencies: 191
-- Data for Name: acao_areas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.acao_areas VALUES (3, 1);
INSERT INTO public.acao_areas VALUES (3, 2);
INSERT INTO public.acao_areas VALUES (3, 3);
INSERT INTO public.acao_areas VALUES (4, 1);
INSERT INTO public.acao_areas VALUES (4, 2);
INSERT INTO public.acao_areas VALUES (6, 10);
INSERT INTO public.acao_areas VALUES (6, 3);
INSERT INTO public.acao_areas VALUES (2, 1);
INSERT INTO public.acao_areas VALUES (2, 2);


--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 189
-- Name: acao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.acao_id_seq', 6, true);


--
-- TOC entry 2401 (class 0 OID 53644)
-- Dependencies: 193
-- Data for Name: area_atuacao; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.area_atuacao VALUES (1, 'Objetivos estratégicos', 1, 'Concentra-se nos eventos de riscos que possam comprometer (ameaças) ou potencializar (oportunidades) o alcance desses objetivos estratégicos e da visão de futuro da Universidade.');
INSERT INTO public.area_atuacao VALUES (2, 'Processos Organizacionais', 1, 'Visa apoiar a melhoria dos fluxos de trabalho e prevenir falhas que comprometam o desempenho dos serviços e ações da Universidade');
INSERT INTO public.area_atuacao VALUES (3, 'Integridade', 1, 'Riscos que configurem ações ou omissões que possam favorecer a ocorrência de fraudes ou atos de corrupção.');
INSERT INTO public.area_atuacao VALUES (10, 'Contratos', 1, 'Uma breve descrição para os contratos');


--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 192
-- Name: area_atuacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.area_atuacao_id_seq', 12, true);


--
-- TOC entry 2403 (class 0 OID 53652)
-- Dependencies: 195
-- Data for Name: avaliacao_controle; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.avaliacao_controle VALUES (1, 'Controles inexistentes, mal desenhados ou mal implantados, isto é, não funcionais.', 'Inexistente', 1, 1.00);
INSERT INTO public.avaliacao_controle VALUES (2, 'Controles têm abordagens ​ad hoc​, tendem a ser aplicados caso a caso, a responsabilidade é individual, havendo elevado grau de confiança no conhecimento das pessoas', 'Fraco', 1, 0.80);
INSERT INTO public.avaliacao_controle VALUES (3, 'Controles implementados mitigam alguns aspectos do risco, mas não contemplam todos os aspectos relevantes do risco devido a deficiências no desenho ou nas ferramentas utilizadas', 'Mediano', 1, 0.60);
INSERT INTO public.avaliacao_controle VALUES (4, 'Controles implementados e sustentados por ferramentas adequadas e embora passíveis de aperfeiçoamento, mitigam o risco satisfatoriamente', 'Satisfatório', 1, 0.40);
INSERT INTO public.avaliacao_controle VALUES (5, 'Controles implementados podem ser considerados a “melhor prática”, mitigando todos os aspectos relevantes do risco', 'Forte', 1, 0.20);


--
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 194
-- Name: avaliacao_controle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.avaliacao_controle_id_seq', 6, true);


--
-- TOC entry 2405 (class 0 OID 53663)
-- Dependencies: 197
-- Data for Name: avaliacao_risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.avaliacao_risco VALUES (3, '2020-10-20', 3, 3, 4, 2, 3, NULL, NULL, NULL, NULL);
INSERT INTO public.avaliacao_risco VALUES (5, '2019-10-28', 3, 4, 3, 2, 3, NULL, NULL, NULL, NULL);
INSERT INTO public.avaliacao_risco VALUES (6, '2020-10-29', 1, 1, 2, 2, 4, NULL, NULL, NULL, NULL);
INSERT INTO public.avaliacao_risco VALUES (7, '2020-10-29', 2, 4, 3, 2, 5, NULL, NULL, NULL, NULL);
INSERT INTO public.avaliacao_risco VALUES (4, '2020-10-21', 5, 5, 4, 2, 3, NULL, 'Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio. A ordem dos tratores não altera o pão duris. Nullam volutpat risus nec leo commodo, ut interdum diam laoreet. Sed non consequat odio. Posuere libero varius. Nullam a nisl ut ante blandit hendrerit. Aenean sit amet nisi.', 'Mussum Ipsum, cacilds vidis litro abertis. In elementis mé pra quem é amistosis quis leo. Detraxit consequat et quo num tendi nada. Mais vale um bebadis conhecidiss, que um alcoolatra anonimis. Mauris nec dolor in eros commodo tempor. Aenean aliquam molestie leo, vitae iaculis nisl.', 'Mussum Ipsum, cacilds vidis litro abertis. Todo mundo vê os porris que eu tomo, mas ninguém vê os tombis que eu levo! Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis. Nec orci ornare consequat. Praesent lacinia ultrices consectetur. Sed non ipsum felis. In elementis mé pra quem é amistosis quis leo.');


--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 196
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.avaliacao_risco_id_seq', 7, true);


--
-- TOC entry 2407 (class 0 OID 53671)
-- Dependencies: 199
-- Data for Name: categoria_risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categoria_risco VALUES (2, 'Eventos que podem comprometer a capacidade da UFC de contar com os recursos orçamentários e financeiros necessários à realização de suas atividades, ou eventos que possam comprometer a própria execução orçamentária', 'Financeiros/Orçamentário', 1);
INSERT INTO public.categoria_risco VALUES (3, 'Eventos que podem comprometer as atividades da UFC, normalmente associados a falhas, deficiência ou inadequação de processos internos, de pessoas, de infraestrutura e de sistemas', 'Operacionais', 1);
INSERT INTO public.categoria_risco VALUES (4, 'Eventos derivados de alterações legislativas ou normativas que podem comprometer as atividades da UFC', 'Legal/de Conformidade', 1);
INSERT INTO public.categoria_risco VALUES (5, 'Eventos que podem comprometer a confiança da sociedade (ou de parceiros, de clientes ou de fornecedores) em relação à capacidade da UFC em cumprir sua missão institucional', 'Imagem / Reputação', 1);
INSERT INTO public.categoria_risco VALUES (6, 'Integridade Eventos relacionados à corrupção, fraudes, irregularidades e/ou desvios éticos e de conduta que podem comprometer os valores e padrões preconizados pela UFC', 'Integridade', 1);
INSERT INTO public.categoria_risco VALUES (1, 'Eventos que ameacem diretamente os objetivos estratégicos organizacionais, afetando o alcance da sua visão e a sustentabilidade da instituição no longo prazo', 'Estratégico', 1);


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 198
-- Name: categoria_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_risco_id_seq', 11, true);


--
-- TOC entry 2409 (class 0 OID 53682)
-- Dependencies: 201
-- Data for Name: impacto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.impacto VALUES (2, 'Pequeno impacto nos objetivos', 'Baixo', 1, 2);
INSERT INTO public.impacto VALUES (3, 'Moderado impacto nos objetivos, porém', 'Médio', 1, 5);
INSERT INTO public.impacto VALUES (4, 'Significativo impacto nos objetivos, de difícil reversão.', 'Alto', 1, 8);
INSERT INTO public.impacto VALUES (5, 'Catastrófico impacto nos objetivos, de forma irreversível.', 'Muito alto', 1, 10);
INSERT INTO public.impacto VALUES (1, 'Mínimo impacto nos objetivos (estratégicos, operacionais, de informação / comunicação / divulgação ou de conformidade)', 'Muito baixo', 1, 1);


--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 200
-- Name: impacto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.impacto_id_seq', 7, true);


--
-- TOC entry 2411 (class 0 OID 53693)
-- Dependencies: 203
-- Data for Name: nivel_risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.nivel_risco VALUES (1, '#2bd27e', 'Nível de risco dentro do apetite a risco, mas é possível que existam oportunidades de maior retorno que podem ser exploradas assumindo-se mais riscos, avaliando a relação custo x benefício, como diminuir o nível de controles.', 'Baixo', 1, 9.99, 0.00, 'DIARIA', false);
INSERT INTO public.nivel_risco VALUES (4, '#F24130', 'Nível de risco muito além do apetite a risco. Qualquer risco neste nível deve ser objeto de Avaliação Estratégica, comunicado ao Comitê de Governança e ao Reitor e ter uma resposta imediata. Postergação de medidas só com autorização do Comitê de Governança.', 'Extremo', 1, 100.00, 80.00, 'SEMANAL', false);
INSERT INTO public.nivel_risco VALUES (3, '#FF6D00', 'Nível de risco além do apetite a risco. Qualquer risco neste nível deve ser comunicado ao dirigente máximo da unidade e ter uma ação tomada em período determinado. Postergação de medidas só com autorização do dirigente máximo da unidade.', 'Alto', 1, 79.99, 40.00, 'MENSAL', false);
INSERT INTO public.nivel_risco VALUES (2, '#F5F40F', 'Nível de risco dentro do apetite a risco. Geralmente nenhuma medida especial é necessária, porém requer atividades de monitoramento específicas e atenção da unidade na manutenção de respostas e controles para manter o risco nesse nível, ou reduzi-lo sem custos adicionais.', 'Médio', 1, 39.99, 10.00, 'SEMANAL', false);


--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 202
-- Name: nivel_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.nivel_risco_id_seq', 9, true);


--
-- TOC entry 2412 (class 0 OID 53702)
-- Dependencies: 204
-- Data for Name: nivel_risco_respostas_risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.nivel_risco_respostas_risco VALUES (2, 4);
INSERT INTO public.nivel_risco_respostas_risco VALUES (2, 1);


--
-- TOC entry 2414 (class 0 OID 53707)
-- Dependencies: 206
-- Data for Name: ocorrencia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 205
-- Name: ocorrencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ocorrencia_id_seq', 1, false);


--
-- TOC entry 2416 (class 0 OID 53718)
-- Dependencies: 208
-- Data for Name: plano; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.plano VALUES (1, '2022-12-31', '2020-01-01', NULL, 'Plano de Gestão de Riscos 2020-2022');
INSERT INTO public.plano VALUES (2, '2022-12-31', '2020-01-01', NULL, 'Plano de Gestão de Riscos 2020-2022');


--
-- TOC entry 2436 (class 0 OID 60796)
-- Dependencies: 228
-- Data for Name: plano_apetite; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2417 (class 0 OID 53727)
-- Dependencies: 209
-- Data for Name: plano_areas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2418 (class 0 OID 53730)
-- Dependencies: 210
-- Data for Name: plano_avaliacoes_controle; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2419 (class 0 OID 53733)
-- Dependencies: 211
-- Data for Name: plano_categorias_risco; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2425 (class 0 OID 53750)
-- Dependencies: 217
-- Data for Name: plano_contingencia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 216
-- Name: plano_contingencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plano_contingencia_id_seq', 1, false);


--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 207
-- Name: plano_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plano_id_seq', 2, true);


--
-- TOC entry 2420 (class 0 OID 53736)
-- Dependencies: 212
-- Data for Name: plano_impactos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2421 (class 0 OID 53739)
-- Dependencies: 213
-- Data for Name: plano_niveis_risco; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2422 (class 0 OID 53742)
-- Dependencies: 214
-- Data for Name: plano_probabilidades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2423 (class 0 OID 53745)
-- Dependencies: 215
-- Data for Name: plano_respostas_risco; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2427 (class 0 OID 53761)
-- Dependencies: 219
-- Data for Name: plano_tratamento_risco; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 218
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plano_tratamento_risco_id_seq', 1, false);


--
-- TOC entry 2429 (class 0 OID 53772)
-- Dependencies: 221
-- Data for Name: probabilidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.probabilidade VALUES (1, 'Improvável. Em situações excepcionais, o evento poderá até ocorrer, mas nada nas circunstâncias indica essa possibilidade', 'Muito baixa', 1, 1);
INSERT INTO public.probabilidade VALUES (2, 'Rara. De forma inesperada ou casual, o evento poderá ocorrer, pois as circunstâncias pouco indicam essa possibilidade', 'Baixa', 1, 2);
INSERT INTO public.probabilidade VALUES (3, 'Possível. De alguma forma, o evento poderá ocorrer, pois as circunstâncias indicam moderadamente essa possibilidade', 'Média', 1, 5);
INSERT INTO public.probabilidade VALUES (4, 'Provável. De forma até esperada, o evento poderá ocorrer, pois as circunstâncias indicam fortemente essa possibilidade', 'Alta', 1, 8);
INSERT INTO public.probabilidade VALUES (5, 'Praticamente certo. De forma inequívoca, o evento ocorrerá. As circunstâncias indicam claramente essa possibilidade.', 'Muito Alta', 1, 10);


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 220
-- Name: probabilidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.probabilidade_id_seq', 7, true);


--
-- TOC entry 2431 (class 0 OID 53783)
-- Dependencies: 223
-- Data for Name: resposta_risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.resposta_risco VALUES (2, 'Um risco normalmente é mitigado quando é classificado como “Alto” ou “Extremo”. A implementação de controles, neste caso, apresenta um custo/benefício adequado. Mitigar o risco significa implementar controles que possam diminuir as causas ou as consequências dos riscos, identificadas nas etapas de ​Identificação ​e Avaliação de Riscos​.', 'Mitigar', 1, true, false, true);
INSERT INTO public.resposta_risco VALUES (4, 'Um risco normalmente é evitado quando é classificado como “Alto” ou “Extremo”, mas a implementação de controles apresenta um custo muito elevado, inviabilizando sua mitigação, ou não há entidades (internas ou externas) dispostas a compartilhar o risco
com a UFC. Caso essa opção incorra na interrupção do processo organizacional, a decisão deve ser aprovada pelo Comitê
de Governança, ou Câmara associada', 'Evitar', 1, true, false, true);
INSERT INTO public.resposta_risco VALUES (1, 'Um risco normalmente é aceito quando seu nível está nas faixas de apetite a risco. Nessa situação, nenhum novo controle precisa ser implementado para mitigar o risco.', 'Aceitar', 1, true, true, false);
INSERT INTO public.resposta_risco VALUES (3, 'Um risco normalmente é compartilhado quando é classificado como “Alto” ou “Extremo”, mas a implementação de controles não apresenta um custo/benefício adequado. Pode-se identificar outra unidade que tenha mais
robustez para tratá-lo ou compartilhar o risco por meio de terceirização ou apólice de seguro, por exemplo', 'Compartilhar', 1, true, true, true);


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 222
-- Name: resposta_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.resposta_risco_id_seq', 6, true);


--
-- TOC entry 2433 (class 0 OID 53794)
-- Dependencies: 225
-- Data for Name: risco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.risco VALUES (3, 'Mais vale um bebadis conhecidiss, que um alcoolatra anonimis', NULL, 'AMEACA', 1, NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.risco VALUES (4, 'Nullam volutpat risus nec leo commodo, ut interdum diam laoreet', NULL, 'AMEACA', 1, NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.risco VALUES (5, 'Si u mundo tá muito paradis toma um mé que o mundo vai girarzis', NULL, 'OPORTUNIDADE', 1, NULL, 2, 2, NULL, NULL, NULL);
INSERT INTO public.risco VALUES (6, 'Título do evento', NULL, 'AMEACA', 1, NULL, 2, 2, NULL, NULL, NULL);


--
-- TOC entry 2434 (class 0 OID 53803)
-- Dependencies: 226
-- Data for Name: risco_acoes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.risco_acoes VALUES (3, 3);
INSERT INTO public.risco_acoes VALUES (3, 4);
INSERT INTO public.risco_acoes VALUES (4, 2);
INSERT INTO public.risco_acoes VALUES (5, 4);
INSERT INTO public.risco_acoes VALUES (6, 2);


--
-- TOC entry 2435 (class 0 OID 53806)
-- Dependencies: 227
-- Data for Name: risco_categorias; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.risco_categorias VALUES (3, 3);
INSERT INTO public.risco_categorias VALUES (3, 5);
INSERT INTO public.risco_categorias VALUES (4, 2);
INSERT INTO public.risco_categorias VALUES (4, 3);
INSERT INTO public.risco_categorias VALUES (4, 4);
INSERT INTO public.risco_categorias VALUES (5, 2);
INSERT INTO public.risco_categorias VALUES (5, 4);
INSERT INTO public.risco_categorias VALUES (6, 1);
INSERT INTO public.risco_categorias VALUES (6, 3);


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 224
-- Name: risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.risco_id_seq', 6, true);


--
-- TOC entry 2394 (class 0 OID 44725)
-- Dependencies: 186
-- Data for Name: unidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.unidade VALUES (2, false, 'CAMPUS QUIXADÁ', 'QXD', 2, NULL, NULL);


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 185
-- Name: unidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unidade_id_seq', 2, true);


--
-- TOC entry 2396 (class 0 OID 44736)
-- Dependencies: 188
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.usuario VALUES (2, 'CARGO GESTÃO DE RISCOS', 'usuario@ufc.br', true, 'USUÁRIO GESTÃO DE RISCOS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 2);


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_id_seq', 2, true);


--
-- TOC entry 2179 (class 2606 OID 53638)
-- Name: acao acao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao
    ADD CONSTRAINT acao_pkey PRIMARY KEY (id);


--
-- TOC entry 2181 (class 2606 OID 53649)
-- Name: area_atuacao area_atuacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_atuacao
    ADD CONSTRAINT area_atuacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2183 (class 2606 OID 53660)
-- Name: avaliacao_controle avaliacao_controle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_controle
    ADD CONSTRAINT avaliacao_controle_pkey PRIMARY KEY (id);


--
-- TOC entry 2185 (class 2606 OID 53668)
-- Name: avaliacao_risco avaliacao_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT avaliacao_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2187 (class 2606 OID 53679)
-- Name: categoria_risco categoria_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria_risco
    ADD CONSTRAINT categoria_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2189 (class 2606 OID 53690)
-- Name: impacto impacto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impacto
    ADD CONSTRAINT impacto_pkey PRIMARY KEY (id);


--
-- TOC entry 2191 (class 2606 OID 53701)
-- Name: nivel_risco nivel_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nivel_risco
    ADD CONSTRAINT nivel_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2193 (class 2606 OID 53715)
-- Name: ocorrencia ocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT ocorrencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2211 (class 2606 OID 53758)
-- Name: plano_contingencia plano_contingencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT plano_contingencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2195 (class 2606 OID 53726)
-- Name: plano plano_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano
    ADD CONSTRAINT plano_pkey PRIMARY KEY (id);


--
-- TOC entry 2213 (class 2606 OID 53769)
-- Name: plano_tratamento_risco plano_tratamento_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT plano_tratamento_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 53780)
-- Name: probabilidade probabilidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.probabilidade
    ADD CONSTRAINT probabilidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2217 (class 2606 OID 53791)
-- Name: resposta_risco resposta_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta_risco
    ADD CONSTRAINT resposta_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2219 (class 2606 OID 53802)
-- Name: risco risco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2175 (class 2606 OID 44746)
-- Name: usuario uk_5171l57faosmj8myawaucatdw; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uk_5171l57faosmj8myawaucatdw UNIQUE (email);


--
-- TOC entry 2207 (class 2606 OID 53820)
-- Name: plano_probabilidades uk_9klflngd59r69unqh5swrrcv1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_probabilidades
    ADD CONSTRAINT uk_9klflngd59r69unqh5swrrcv1 UNIQUE (probabilidades_id);


--
-- TOC entry 2209 (class 2606 OID 53822)
-- Name: plano_respostas_risco uk_bkqi165w935chtgwpeodyjutt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_respostas_risco
    ADD CONSTRAINT uk_bkqi165w935chtgwpeodyjutt UNIQUE (respostas_risco_id);


--
-- TOC entry 2205 (class 2606 OID 53818)
-- Name: plano_niveis_risco uk_fielyl9tb8wbx8paw7u9eh1mn; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_niveis_risco
    ADD CONSTRAINT uk_fielyl9tb8wbx8paw7u9eh1mn UNIQUE (niveis_risco_id);


--
-- TOC entry 2221 (class 2606 OID 60800)
-- Name: plano_apetite uk_fts600fpu3uveq6dya5xtie1l; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_apetite
    ADD CONSTRAINT uk_fts600fpu3uveq6dya5xtie1l UNIQUE (apetite_id);


--
-- TOC entry 2197 (class 2606 OID 53810)
-- Name: plano_areas uk_jknftqkf7fgvgpia8lhwftejk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_areas
    ADD CONSTRAINT uk_jknftqkf7fgvgpia8lhwftejk UNIQUE (areas_id);


--
-- TOC entry 2199 (class 2606 OID 53812)
-- Name: plano_avaliacoes_controle uk_p4ft838gof0cxqdin24q1l94d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_avaliacoes_controle
    ADD CONSTRAINT uk_p4ft838gof0cxqdin24q1l94d UNIQUE (avaliacoes_controle_id);


--
-- TOC entry 2201 (class 2606 OID 53814)
-- Name: plano_categorias_risco uk_ra98vt06xw9wkxsla9mjxrvnk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_categorias_risco
    ADD CONSTRAINT uk_ra98vt06xw9wkxsla9mjxrvnk UNIQUE (categorias_risco_id);


--
-- TOC entry 2203 (class 2606 OID 53816)
-- Name: plano_impactos uk_rbf0iarh039rhq2h9rhckk7f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_impactos
    ADD CONSTRAINT uk_rbf0iarh039rhq2h9rhckk7f UNIQUE (impactos_id);


--
-- TOC entry 2173 (class 2606 OID 44733)
-- Name: unidade unidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT unidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2177 (class 2606 OID 44744)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 53833)
-- Name: acao fk1d945l2cqr8rhf6qqu35g1q4y; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao
    ADD CONSTRAINT fk1d945l2cqr8rhf6qqu35g1q4y FOREIGN KEY (unidade_id) REFERENCES public.unidade(id);


--
-- TOC entry 2254 (class 2606 OID 53963)
-- Name: plano_niveis_risco fk1da8w16j6gvkv688lpv6xsojg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_niveis_risco
    ADD CONSTRAINT fk1da8w16j6gvkv688lpv6xsojg FOREIGN KEY (niveis_risco_id) REFERENCES public.nivel_risco(id);


--
-- TOC entry 2255 (class 2606 OID 53968)
-- Name: plano_niveis_risco fk1hkchjjs0qmgnorg3lkxjsu8o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_niveis_risco
    ADD CONSTRAINT fk1hkchjjs0qmgnorg3lkxjsu8o FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2223 (class 2606 OID 44922)
-- Name: unidade fk1stvqraetmvo7cxsra0f88hn7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fk1stvqraetmvo7cxsra0f88hn7 FOREIGN KEY (unidade_pai_id) REFERENCES public.unidade(id);


--
-- TOC entry 2232 (class 2606 OID 53853)
-- Name: avaliacao_controle fk24g877n2evqnugsyvk220vpws; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_controle
    ADD CONSTRAINT fk24g877n2evqnugsyvk220vpws FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2239 (class 2606 OID 53888)
-- Name: impacto fk2ibrdg4jps34pxbk5ul2fw619; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impacto
    ADD CONSTRAINT fk2ibrdg4jps34pxbk5ul2fw619 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2275 (class 2606 OID 60806)
-- Name: plano_apetite fk2uvi8xhphognos3d8uw7kfw2v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_apetite
    ADD CONSTRAINT fk2uvi8xhphognos3d8uw7kfw2v FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2271 (class 2606 OID 54048)
-- Name: risco_acoes fk3fxceiyfea654jg51bx06rkkv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco_acoes
    ADD CONSTRAINT fk3fxceiyfea654jg51bx06rkkv FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2253 (class 2606 OID 53958)
-- Name: plano_impactos fk3xpeattrr725kr6xmk7buqxyc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_impactos
    ADD CONSTRAINT fk3xpeattrr725kr6xmk7buqxyc FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2269 (class 2606 OID 60826)
-- Name: risco fk5g9a4l2c3b8d1fxwv597h5547; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fk5g9a4l2c3b8d1fxwv597h5547 FOREIGN KEY (unidade_id) REFERENCES public.unidade(id);


--
-- TOC entry 2267 (class 2606 OID 60816)
-- Name: risco fk61y99igtnpc6drdrsis9h2550; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fk61y99igtnpc6drdrsis9h2550 FOREIGN KEY (plano_tratamento_id) REFERENCES public.plano_tratamento_risco(id);


--
-- TOC entry 2237 (class 2606 OID 53878)
-- Name: avaliacao_risco fk6averwyd64d0mbfr5hhgv8r3x; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fk6averwyd64d0mbfr5hhgv8r3x FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2241 (class 2606 OID 53898)
-- Name: nivel_risco_respostas_risco fk717g6stxvyjpal8opkqcwa7bf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nivel_risco_respostas_risco
    ADD CONSTRAINT fk717g6stxvyjpal8opkqcwa7bf FOREIGN KEY (respostas_risco_id) REFERENCES public.resposta_risco(id);


--
-- TOC entry 2250 (class 2606 OID 53943)
-- Name: plano_categorias_risco fk7astm54sl95tuiajq2p0pdxwq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_categorias_risco
    ADD CONSTRAINT fk7astm54sl95tuiajq2p0pdxwq FOREIGN KEY (categorias_risco_id) REFERENCES public.categoria_risco(id);


--
-- TOC entry 2261 (class 2606 OID 53998)
-- Name: plano_contingencia fk7ph4fihw6hl4chsf0b2bw5o5r; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT fk7ph4fihw6hl4chsf0b2bw5o5r FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2259 (class 2606 OID 53988)
-- Name: plano_respostas_risco fk86nfa9wi1oscockie71ddkign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_respostas_risco
    ADD CONSTRAINT fk86nfa9wi1oscockie71ddkign FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2235 (class 2606 OID 53868)
-- Name: avaliacao_risco fk8p04vtfdmo9bam2nnjk149ukv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fk8p04vtfdmo9bam2nnjk149ukv FOREIGN KEY (probabilidade_id) REFERENCES public.probabilidade(id);


--
-- TOC entry 2264 (class 2606 OID 54013)
-- Name: probabilidade fk94y8khbportscrwr6shlw7s5q; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.probabilidade
    ADD CONSTRAINT fk94y8khbportscrwr6shlw7s5q FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2236 (class 2606 OID 53873)
-- Name: avaliacao_risco fkac0eidmqf57sxh01h1v7484lo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fkac0eidmqf57sxh01h1v7484lo FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2248 (class 2606 OID 53933)
-- Name: plano_avaliacoes_controle fkaia0ctccmktd5vtxwni3odiah; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_avaliacoes_controle
    ADD CONSTRAINT fkaia0ctccmktd5vtxwni3odiah FOREIGN KEY (avaliacoes_controle_id) REFERENCES public.avaliacao_controle(id);


--
-- TOC entry 2257 (class 2606 OID 53978)
-- Name: plano_probabilidades fkaq59ub098cc3456peuq4gptup; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_probabilidades
    ADD CONSTRAINT fkaq59ub098cc3456peuq4gptup FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2270 (class 2606 OID 54043)
-- Name: risco_acoes fkbiixydj2rh201wcvnoj03lyiy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco_acoes
    ADD CONSTRAINT fkbiixydj2rh201wcvnoj03lyiy FOREIGN KEY (acoes_id) REFERENCES public.acao(id);


--
-- TOC entry 2246 (class 2606 OID 53923)
-- Name: plano_areas fkbt46pkk6lw7nr4a05wwcjaxkn; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_areas
    ADD CONSTRAINT fkbt46pkk6lw7nr4a05wwcjaxkn FOREIGN KEY (areas_id) REFERENCES public.area_atuacao(id);


--
-- TOC entry 2260 (class 2606 OID 53993)
-- Name: plano_contingencia fkc7xsuj8rdvjklktqkssyt5lec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT fkc7xsuj8rdvjklktqkssyt5lec FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2251 (class 2606 OID 53948)
-- Name: plano_categorias_risco fkcyju91siokd5otyfeydoprdo0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_categorias_risco
    ADD CONSTRAINT fkcyju91siokd5otyfeydoprdo0 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2272 (class 2606 OID 54053)
-- Name: risco_categorias fkd2dlfs50rft5q86s0u80br866; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco_categorias
    ADD CONSTRAINT fkd2dlfs50rft5q86s0u80br866 FOREIGN KEY (categorias_id) REFERENCES public.categoria_risco(id);


--
-- TOC entry 2273 (class 2606 OID 54058)
-- Name: risco_categorias fkd7elahqatq3x8q9y68kipj6qk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco_categorias
    ADD CONSTRAINT fkd7elahqatq3x8q9y68kipj6qk FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2240 (class 2606 OID 53893)
-- Name: nivel_risco fkdfg4nrp80ka23uhl07pd5nbm9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nivel_risco
    ADD CONSTRAINT fkdfg4nrp80ka23uhl07pd5nbm9 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2243 (class 2606 OID 53908)
-- Name: ocorrencia fkdql38pf2lxd9w8akmkrwj66xv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkdql38pf2lxd9w8akmkrwj66xv FOREIGN KEY (plano_contingencia_id) REFERENCES public.plano_contingencia(id);


--
-- TOC entry 2263 (class 2606 OID 54008)
-- Name: plano_tratamento_risco fkea9f2lo6cfqlo9tk3u7rw41tb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT fkea9f2lo6cfqlo9tk3u7rw41tb FOREIGN KEY (resposta_risco_id) REFERENCES public.resposta_risco(id);


--
-- TOC entry 2230 (class 2606 OID 53843)
-- Name: acao_areas fkeut7bg6irpf8xbk9rgrpxmbu0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao_areas
    ADD CONSTRAINT fkeut7bg6irpf8xbk9rgrpxmbu0 FOREIGN KEY (acao_id) REFERENCES public.acao(id);


--
-- TOC entry 2252 (class 2606 OID 53953)
-- Name: plano_impactos fkexyu4ja7qu7hd9wts7d4jwic; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_impactos
    ADD CONSTRAINT fkexyu4ja7qu7hd9wts7d4jwic FOREIGN KEY (impactos_id) REFERENCES public.impacto(id);


--
-- TOC entry 2245 (class 2606 OID 53918)
-- Name: ocorrencia fkhq7ia56e1v5n7qcjwgb2tj6id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkhq7ia56e1v5n7qcjwgb2tj6id FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2274 (class 2606 OID 60801)
-- Name: plano_apetite fkhyyik975wfs2662uq39xhquwy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_apetite
    ADD CONSTRAINT fkhyyik975wfs2662uq39xhquwy FOREIGN KEY (apetite_id) REFERENCES public.nivel_risco(id);


--
-- TOC entry 2268 (class 2606 OID 60821)
-- Name: risco fkio004nou6go8vqjo2yh8wuoue; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fkio004nou6go8vqjo2yh8wuoue FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2229 (class 2606 OID 53838)
-- Name: acao_areas fkk2knj3ajuplcl7ny0xqn7gej; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao_areas
    ADD CONSTRAINT fkk2knj3ajuplcl7ny0xqn7gej FOREIGN KEY (areas_id) REFERENCES public.area_atuacao(id);


--
-- TOC entry 2222 (class 2606 OID 44917)
-- Name: unidade fkkm5xutfqh8xhlpmunrh0ktd52; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fkkm5xutfqh8xhlpmunrh0ktd52 FOREIGN KEY (chefe_id) REFERENCES public.usuario(id);


--
-- TOC entry 2249 (class 2606 OID 53938)
-- Name: plano_avaliacoes_controle fklfu6f1ctp2xtxw49s203qq0w3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_avaliacoes_controle
    ADD CONSTRAINT fklfu6f1ctp2xtxw49s203qq0w3 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2224 (class 2606 OID 44927)
-- Name: unidade fkmddh6eo6qwvo0ihot8dmj3hth; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fkmddh6eo6qwvo0ihot8dmj3hth FOREIGN KEY (vice_chefe_id) REFERENCES public.usuario(id);


--
-- TOC entry 2266 (class 2606 OID 60811)
-- Name: risco fkmputeb45lflkjbqc925i47gkw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fkmputeb45lflkjbqc925i47gkw FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2258 (class 2606 OID 53983)
-- Name: plano_respostas_risco fkncyh7ekmxwjcmlb5vt14jm8cn; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_respostas_risco
    ADD CONSTRAINT fkncyh7ekmxwjcmlb5vt14jm8cn FOREIGN KEY (respostas_risco_id) REFERENCES public.resposta_risco(id);


--
-- TOC entry 2233 (class 2606 OID 53858)
-- Name: avaliacao_risco fknn8ips562vnag5nmy56yj80yn; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fknn8ips562vnag5nmy56yj80yn FOREIGN KEY (avaliacao_controle_id) REFERENCES public.avaliacao_controle(id);


--
-- TOC entry 2238 (class 2606 OID 53883)
-- Name: categoria_risco fknpgfknqlvfqueukk02g7qv306; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria_risco
    ADD CONSTRAINT fknpgfknqlvfqueukk02g7qv306 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2256 (class 2606 OID 53973)
-- Name: plano_probabilidades fkp353urpr52x56ellx73ieog71; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_probabilidades
    ADD CONSTRAINT fkp353urpr52x56ellx73ieog71 FOREIGN KEY (probabilidades_id) REFERENCES public.probabilidade(id);


--
-- TOC entry 2247 (class 2606 OID 53928)
-- Name: plano_areas fkpyvlb071y2x5l84lucis64cvl; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_areas
    ADD CONSTRAINT fkpyvlb071y2x5l84lucis64cvl FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2244 (class 2606 OID 53913)
-- Name: ocorrencia fkqdlch2956p0g19vl6ltwygdq0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkqdlch2956p0g19vl6ltwygdq0 FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2227 (class 2606 OID 53828)
-- Name: acao fkqws47dpfkswh0iq3svmiuxxo0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao
    ADD CONSTRAINT fkqws47dpfkswh0iq3svmiuxxo0 FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2234 (class 2606 OID 53863)
-- Name: avaliacao_risco fkr2cc8y4fu15e1wyve8ngvx8nm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fkr2cc8y4fu15e1wyve8ngvx8nm FOREIGN KEY (impacto_id) REFERENCES public.impacto(id);


--
-- TOC entry 2231 (class 2606 OID 53848)
-- Name: area_atuacao fkrty9oukj3qtub1fmrg6sl0jpt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_atuacao
    ADD CONSTRAINT fkrty9oukj3qtub1fmrg6sl0jpt FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2226 (class 2606 OID 53823)
-- Name: acao fks4ejoq6ve3o5rlhyjng3k1tyg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.acao
    ADD CONSTRAINT fks4ejoq6ve3o5rlhyjng3k1tyg FOREIGN KEY (gestor_id) REFERENCES public.usuario(id);


--
-- TOC entry 2262 (class 2606 OID 54003)
-- Name: plano_tratamento_risco fks71leg3qxmd5tg3o91d6e0hpb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT fks71leg3qxmd5tg3o91d6e0hpb FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2225 (class 2606 OID 44932)
-- Name: usuario fksfuif7ykkynvxw4aqmk7shy7c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fksfuif7ykkynvxw4aqmk7shy7c FOREIGN KEY (unidade_id) REFERENCES public.unidade(id);


--
-- TOC entry 2265 (class 2606 OID 54018)
-- Name: resposta_risco fksjv7sgs6wc3l9koyf3qtv6xja; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta_risco
    ADD CONSTRAINT fksjv7sgs6wc3l9koyf3qtv6xja FOREIGN KEY (plano_id) REFERENCES public.plano(id);


--
-- TOC entry 2242 (class 2606 OID 53903)
-- Name: nivel_risco_respostas_risco fkt7skrd3ycvgmvcwaw3lx7q0oe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nivel_risco_respostas_risco
    ADD CONSTRAINT fkt7skrd3ycvgmvcwaw3lx7q0oe FOREIGN KEY (nivel_risco_id) REFERENCES public.nivel_risco(id);


-- Completed on 2020-12-21 11:40:47

--
-- PostgreSQL database dump complete
--

