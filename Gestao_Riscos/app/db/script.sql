--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9 (Ubuntu 10.9-1.pgdg18.10+1)
-- Dumped by pg_dump version 11.4 (Ubuntu 11.4-1.pgdg18.10+1)

-- Started on 2019-09-03 09:51:34 -03

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: riscos_user
--

CREATE SCHEMA IF NOT EXISTS public;;


ALTER SCHEMA public OWNER TO riscos_user;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: riscos_user
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 67412)
-- Name: avaliacao_risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.avaliacao_risco (
    id integer NOT NULL,
    data timestamp without time zone,
    observacoes character varying(255),
    fator_avaliacao_controle_id integer,
    impacto_id integer,
    probabilidade_id integer,
    responsavel_id integer,
    risco_id integer
);


ALTER TABLE public.avaliacao_risco OWNER TO riscos_user;

--
-- TOC entry 197 (class 1259 OID 67410)
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.avaliacao_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.avaliacao_risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 197
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.avaliacao_risco_id_seq OWNED BY public.avaliacao_risco.id;


--
-- TOC entry 200 (class 1259 OID 67420)
-- Name: categoria_risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.categoria_risco (
    id integer NOT NULL,
    nome character varying(255),
    politica_id integer
);


ALTER TABLE public.categoria_risco OWNER TO riscos_user;

--
-- TOC entry 199 (class 1259 OID 67418)
-- Name: categoria_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.categoria_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoria_risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 199
-- Name: categoria_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.categoria_risco_id_seq OWNED BY public.categoria_risco.id;


--
-- TOC entry 202 (class 1259 OID 67428)
-- Name: fator_avaliacao_controle; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.fator_avaliacao_controle (
    id integer NOT NULL,
    descricao character varying(255),
    nome character varying(255),
    valor real,
    politica_id integer
);


ALTER TABLE public.fator_avaliacao_controle OWNER TO riscos_user;

--
-- TOC entry 201 (class 1259 OID 67426)
-- Name: fator_avaliacao_controle_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.fator_avaliacao_controle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fator_avaliacao_controle_id_seq OWNER TO riscos_user;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 201
-- Name: fator_avaliacao_controle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.fator_avaliacao_controle_id_seq OWNED BY public.fator_avaliacao_controle.id;


--
-- TOC entry 196 (class 1259 OID 25246)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO riscos_user;

--
-- TOC entry 204 (class 1259 OID 67439)
-- Name: impacto; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.impacto (
    id integer NOT NULL,
    nome character varying(255),
    valor integer,
    politica_id integer
);


ALTER TABLE public.impacto OWNER TO riscos_user;

--
-- TOC entry 203 (class 1259 OID 67437)
-- Name: impacto_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.impacto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.impacto_id_seq OWNER TO riscos_user;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 203
-- Name: impacto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.impacto_id_seq OWNED BY public.impacto.id;


--
-- TOC entry 206 (class 1259 OID 67447)
-- Name: indicador; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.indicador (
    id integer NOT NULL,
    medicao character varying(255),
    nome_indicador character varying(255),
    periodicidade character varying(255),
    processo_id integer,
    responsavel_id integer
);


ALTER TABLE public.indicador OWNER TO riscos_user;

--
-- TOC entry 205 (class 1259 OID 67445)
-- Name: indicador_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.indicador_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indicador_id_seq OWNER TO riscos_user;

--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 205
-- Name: indicador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.indicador_id_seq OWNED BY public.indicador.id;


--
-- TOC entry 208 (class 1259 OID 67458)
-- Name: matriz; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.matriz (
    id integer NOT NULL,
    impacto_id integer,
    nivel_id integer,
    politica_id integer,
    probabilidade_id integer
);


ALTER TABLE public.matriz OWNER TO riscos_user;

--
-- TOC entry 207 (class 1259 OID 67456)
-- Name: matriz_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.matriz_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matriz_id_seq OWNER TO riscos_user;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 207
-- Name: matriz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.matriz_id_seq OWNED BY public.matriz.id;


--
-- TOC entry 210 (class 1259 OID 67466)
-- Name: nivel_risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.nivel_risco (
    id integer NOT NULL,
    cor character varying(255),
    nome character varying(255),
    valor_final real,
    valor_inicial real,
    politica_id integer
);


ALTER TABLE public.nivel_risco OWNER TO riscos_user;

--
-- TOC entry 209 (class 1259 OID 67464)
-- Name: nivel_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.nivel_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nivel_risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 209
-- Name: nivel_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.nivel_risco_id_seq OWNED BY public.nivel_risco.id;


--
-- TOC entry 212 (class 1259 OID 67477)
-- Name: ocorrencia; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.ocorrencia (
    id integer NOT NULL,
    data timestamp without time zone,
    descricao character varying(255),
    resultados character varying(255),
    solucao character varying(255),
    plano_contingencia_id integer,
    responsavel_id integer,
    risco_id integer
);


ALTER TABLE public.ocorrencia OWNER TO riscos_user;

--
-- TOC entry 211 (class 1259 OID 67475)
-- Name: ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.ocorrencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ocorrencia_id_seq OWNER TO riscos_user;

--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 211
-- Name: ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.ocorrencia_id_seq OWNED BY public.ocorrencia.id;


--
-- TOC entry 214 (class 1259 OID 67488)
-- Name: plano_contingencia; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.plano_contingencia (
    id integer NOT NULL,
    acao character varying(255),
    gatilho character varying(255),
    responsavel_id integer,
    risco_id integer
);


ALTER TABLE public.plano_contingencia OWNER TO riscos_user;

--
-- TOC entry 213 (class 1259 OID 67486)
-- Name: plano_contingencia_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.plano_contingencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plano_contingencia_id_seq OWNER TO riscos_user;

--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 213
-- Name: plano_contingencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.plano_contingencia_id_seq OWNED BY public.plano_contingencia.id;


--
-- TOC entry 216 (class 1259 OID 67499)
-- Name: plano_tratamento_risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.plano_tratamento_risco (
    id integer NOT NULL,
    custos character varying(255),
    data_planejamento timestamp without time zone,
    inicio timestamp without time zone,
    justificativa character varying(255),
    monitoramento character varying(255),
    plano_acao character varying(255),
    responsavel bytea,
    termino timestamp without time zone,
    tratamento_id integer,
    responsavel_id integer,
    tratamento_risco_id integer
);


ALTER TABLE public.plano_tratamento_risco OWNER TO riscos_user;

--
-- TOC entry 215 (class 1259 OID 67497)
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.plano_tratamento_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plano_tratamento_risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 215
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.plano_tratamento_risco_id_seq OWNED BY public.plano_tratamento_risco.id;


--
-- TOC entry 218 (class 1259 OID 67510)
-- Name: politica; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.politica (
    id integer NOT NULL,
    descricao character varying(255),
    nome character varying(255),
    data_fim date,
    data_inicio date
);


ALTER TABLE public.politica OWNER TO riscos_user;

--
-- TOC entry 217 (class 1259 OID 67508)
-- Name: politica_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.politica_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.politica_id_seq OWNER TO riscos_user;

--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 217
-- Name: politica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.politica_id_seq OWNED BY public.politica.id;


--
-- TOC entry 220 (class 1259 OID 67530)
-- Name: probabilidade; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.probabilidade (
    id integer NOT NULL,
    nome character varying(255),
    valor integer,
    politica_id integer
);


ALTER TABLE public.probabilidade OWNER TO riscos_user;

--
-- TOC entry 219 (class 1259 OID 67528)
-- Name: probabilidade_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.probabilidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.probabilidade_id_seq OWNER TO riscos_user;

--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 219
-- Name: probabilidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.probabilidade_id_seq OWNED BY public.probabilidade.id;


--
-- TOC entry 222 (class 1259 OID 67538)
-- Name: processo; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.processo (
    id integer NOT NULL,
    alinhamento character varying(255),
    clientes character varying(255),
    descricao character varying(255),
    entradas character varying(255),
    fornecedores character varying(255),
    inicio_desenho timestamp without time zone,
    inicio_levantamento timestamp without time zone,
    inicio_validacao timestamp without time zone,
    nome character varying(255),
    objetivo character varying(255),
    saidas character varying(255),
    termino_desenho timestamp without time zone,
    termino_levantamento timestamp without time zone,
    termino_validacao timestamp without time zone,
    gerente_id integer,
    tipo_id integer,
    unidade_responsavel_id integer
);


ALTER TABLE public.processo OWNER TO riscos_user;

--
-- TOC entry 223 (class 1259 OID 67547)
-- Name: processo_atividades; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.processo_atividades (
    processo_id integer NOT NULL,
    atividades character varying(255)
);


ALTER TABLE public.processo_atividades OWNER TO riscos_user;

--
-- TOC entry 221 (class 1259 OID 67536)
-- Name: processo_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.processo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.processo_id_seq OWNER TO riscos_user;

--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 221
-- Name: processo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.processo_id_seq OWNED BY public.processo.id;


--
-- TOC entry 224 (class 1259 OID 67550)
-- Name: processo_riscos; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.processo_riscos (
    processo_id integer NOT NULL,
    riscos_id integer NOT NULL
);


ALTER TABLE public.processo_riscos OWNER TO riscos_user;

--
-- TOC entry 225 (class 1259 OID 67553)
-- Name: processo_unidades; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.processo_unidades (
    processo_id integer NOT NULL,
    unidades_id integer NOT NULL
);


ALTER TABLE public.processo_unidades OWNER TO riscos_user;

--
-- TOC entry 227 (class 1259 OID 67558)
-- Name: risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.risco (
    id integer NOT NULL,
    causa character varying(255),
    consequencia character varying(255),
    controles character varying(255),
    fator character varying(255),
    nome character varying(255),
    periodicidade_avaliacao character varying(255),
    tipo character varying(255),
    categoria_id integer,
    responsavel_id integer,
    tratamento_id integer,
    politica_id integer,
    unidade_id integer
);


ALTER TABLE public.risco OWNER TO riscos_user;

--
-- TOC entry 226 (class 1259 OID 67556)
-- Name: risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 226
-- Name: risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.risco_id_seq OWNED BY public.risco.id;


--
-- TOC entry 229 (class 1259 OID 67569)
-- Name: tipo_processo; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.tipo_processo (
    id integer NOT NULL,
    nome character varying(255),
    politica_id integer
);


ALTER TABLE public.tipo_processo OWNER TO riscos_user;

--
-- TOC entry 228 (class 1259 OID 67567)
-- Name: tipo_processo_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.tipo_processo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_processo_id_seq OWNER TO riscos_user;

--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 228
-- Name: tipo_processo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.tipo_processo_id_seq OWNED BY public.tipo_processo.id;


--
-- TOC entry 231 (class 1259 OID 67577)
-- Name: tratamento_risco; Type: TABLE; Schema: public; Owner: riscos_user
--

CREATE TABLE public.tratamento_risco (
    id integer NOT NULL,
    descricao character varying(255),
    nome character varying(255),
    plano_acao boolean NOT NULL,
    tipo_risco character varying(255),
    politica_id integer
);


ALTER TABLE public.tratamento_risco OWNER TO riscos_user;

--
-- TOC entry 230 (class 1259 OID 67575)
-- Name: tratamento_risco_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.tratamento_risco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamento_risco_id_seq OWNER TO riscos_user;

--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 230
-- Name: tratamento_risco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.tratamento_risco_id_seq OWNED BY public.tratamento_risco.id;


--
-- TOC entry 233 (class 1259 OID 67588)
-- Name: unidade; Type: TABLE; Schema: public; Owner: riscos_user
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


ALTER TABLE public.unidade OWNER TO riscos_user;

--
-- TOC entry 232 (class 1259 OID 67586)
-- Name: unidade_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.unidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unidade_id_seq OWNER TO riscos_user;

--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 232
-- Name: unidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.unidade_id_seq OWNED BY public.unidade.id;


--
-- TOC entry 235 (class 1259 OID 67599)
-- Name: usuario; Type: TABLE; Schema: public; Owner: riscos_user
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


ALTER TABLE public.usuario OWNER TO riscos_user;

--
-- TOC entry 234 (class 1259 OID 67597)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: riscos_user
--

CREATE SEQUENCE public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO riscos_user;

--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 234
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: riscos_user
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 2914 (class 2604 OID 67415)
-- Name: avaliacao_risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco ALTER COLUMN id SET DEFAULT nextval('public.avaliacao_risco_id_seq'::regclass);


--
-- TOC entry 2915 (class 2604 OID 67423)
-- Name: categoria_risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.categoria_risco ALTER COLUMN id SET DEFAULT nextval('public.categoria_risco_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 67431)
-- Name: fator_avaliacao_controle id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.fator_avaliacao_controle ALTER COLUMN id SET DEFAULT nextval('public.fator_avaliacao_controle_id_seq'::regclass);


--
-- TOC entry 2917 (class 2604 OID 67442)
-- Name: impacto id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.impacto ALTER COLUMN id SET DEFAULT nextval('public.impacto_id_seq'::regclass);


--
-- TOC entry 2918 (class 2604 OID 67450)
-- Name: indicador id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.indicador ALTER COLUMN id SET DEFAULT nextval('public.indicador_id_seq'::regclass);


--
-- TOC entry 2919 (class 2604 OID 67461)
-- Name: matriz id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz ALTER COLUMN id SET DEFAULT nextval('public.matriz_id_seq'::regclass);


--
-- TOC entry 2920 (class 2604 OID 67469)
-- Name: nivel_risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.nivel_risco ALTER COLUMN id SET DEFAULT nextval('public.nivel_risco_id_seq'::regclass);


--
-- TOC entry 2921 (class 2604 OID 67480)
-- Name: ocorrencia id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.ocorrencia ALTER COLUMN id SET DEFAULT nextval('public.ocorrencia_id_seq'::regclass);


--
-- TOC entry 2922 (class 2604 OID 67491)
-- Name: plano_contingencia id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_contingencia ALTER COLUMN id SET DEFAULT nextval('public.plano_contingencia_id_seq'::regclass);


--
-- TOC entry 2923 (class 2604 OID 67502)
-- Name: plano_tratamento_risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_tratamento_risco ALTER COLUMN id SET DEFAULT nextval('public.plano_tratamento_risco_id_seq'::regclass);


--
-- TOC entry 2924 (class 2604 OID 67513)
-- Name: politica id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.politica ALTER COLUMN id SET DEFAULT nextval('public.politica_id_seq'::regclass);


--
-- TOC entry 2925 (class 2604 OID 67533)
-- Name: probabilidade id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.probabilidade ALTER COLUMN id SET DEFAULT nextval('public.probabilidade_id_seq'::regclass);


--
-- TOC entry 2926 (class 2604 OID 67541)
-- Name: processo id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo ALTER COLUMN id SET DEFAULT nextval('public.processo_id_seq'::regclass);


--
-- TOC entry 2927 (class 2604 OID 67561)
-- Name: risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco ALTER COLUMN id SET DEFAULT nextval('public.risco_id_seq'::regclass);


--
-- TOC entry 2928 (class 2604 OID 67572)
-- Name: tipo_processo id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tipo_processo ALTER COLUMN id SET DEFAULT nextval('public.tipo_processo_id_seq'::regclass);


--
-- TOC entry 2929 (class 2604 OID 67580)
-- Name: tratamento_risco id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tratamento_risco ALTER COLUMN id SET DEFAULT nextval('public.tratamento_risco_id_seq'::regclass);


--
-- TOC entry 2930 (class 2604 OID 67591)
-- Name: unidade id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.unidade ALTER COLUMN id SET DEFAULT nextval('public.unidade_id_seq'::regclass);


--
-- TOC entry 2931 (class 2604 OID 67602)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 3137 (class 0 OID 67412)
-- Dependencies: 198
-- Data for Name: avaliacao_risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3139 (class 0 OID 67420)
-- Dependencies: 200
-- Data for Name: categoria_risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.categoria_risco VALUES (2, 'Financeiro/Orçamentário', 2);
INSERT INTO public.categoria_risco VALUES (3, 'Operacional', 2);
INSERT INTO public.categoria_risco VALUES (4, 'Legal/Conformidade', 2);
INSERT INTO public.categoria_risco VALUES (5, 'Imagem/Reputação', 2);
INSERT INTO public.categoria_risco VALUES (6, 'Imagem/Reputação', 2);


--
-- TOC entry 3141 (class 0 OID 67428)
-- Dependencies: 202
-- Data for Name: fator_avaliacao_controle; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.fator_avaliacao_controle VALUES (6, 'Controles inexistentes, mal desenhados ou mal implantados, isto é,
não funcionais.', 'Inexistente', 1, 2);
INSERT INTO public.fator_avaliacao_controle VALUES (7, 'Controles têm abordagens ad hoc, tendem a ser aplicados caso a caso, a responsabilidade é individual, havendo elevado grau de confiança no conhecimento das pessoas.', 'Fraco', 0.800000012, 2);
INSERT INTO public.fator_avaliacao_controle VALUES (8, 'Controles implementados mitigam alguns aspectos do risco, mas não contemplam todos os aspectos relevantes do risco devido a deficiências no desenho ou nas ferramentas utilizadas.', 'Mediano', 0.600000024, 2);
INSERT INTO public.fator_avaliacao_controle VALUES (9, 'Controles implementados e sustentados por ferramentas adequadas e embora passíveis de aperfeiçoamento, mitigam o risco satisfatoriamente.', 'Satisfatório', 0.400000006, 2);
INSERT INTO public.fator_avaliacao_controle VALUES (10, 'Controles implementados podem ser considerados a “melhor prática”, mitigando todos os aspectos relevantes do risco', 'Forte', 0.200000003, 2);


--
-- TOC entry 3143 (class 0 OID 67439)
-- Dependencies: 204
-- Data for Name: impacto; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.impacto VALUES (9, 'Baixo', 2, 2);
INSERT INTO public.impacto VALUES (10, 'Muito Baixo', 1, 2);
INSERT INTO public.impacto VALUES (6, 'Muito alto', 10, 2);
INSERT INTO public.impacto VALUES (7, 'Alto', 8, 2);
INSERT INTO public.impacto VALUES (8, 'Médio', 5, 2);


--
-- TOC entry 3145 (class 0 OID 67447)
-- Dependencies: 206
-- Data for Name: indicador; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3147 (class 0 OID 67458)
-- Dependencies: 208
-- Data for Name: matriz; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3149 (class 0 OID 67466)
-- Dependencies: 210
-- Data for Name: nivel_risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.nivel_risco VALUES (5, '#38761d', 'Baixo', 9.98999977, 0, 2);
INSERT INTO public.nivel_risco VALUES (6, '#f1c232', 'Médio', 39.9900017, 10, 2);
INSERT INTO public.nivel_risco VALUES (7, '#ff9900', 'Alto', 79.9899979, 40, 2);
INSERT INTO public.nivel_risco VALUES (8, '#cc0000', 'Extremo', 100, 80, 2);


--
-- TOC entry 3151 (class 0 OID 67477)
-- Dependencies: 212
-- Data for Name: ocorrencia; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3153 (class 0 OID 67488)
-- Dependencies: 214
-- Data for Name: plano_contingencia; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3155 (class 0 OID 67499)
-- Dependencies: 216
-- Data for Name: plano_tratamento_risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3157 (class 0 OID 67510)
-- Dependencies: 218
-- Data for Name: politica; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.politica VALUES (2, 'Política UFC 2019', 'Política UFC 2019', '2019-12-31', '2019-01-01');


--
-- TOC entry 3159 (class 0 OID 67530)
-- Dependencies: 220
-- Data for Name: probabilidade; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.probabilidade VALUES (9, 'Baixa', 2, 2);
INSERT INTO public.probabilidade VALUES (10, 'Muito baixa', 1, 2);
INSERT INTO public.probabilidade VALUES (6, 'Alta', 8, 2);
INSERT INTO public.probabilidade VALUES (7, 'Muito Alta', 10, 2);
INSERT INTO public.probabilidade VALUES (8, 'Média', 5, 2);


--
-- TOC entry 3161 (class 0 OID 67538)
-- Dependencies: 222
-- Data for Name: processo; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3162 (class 0 OID 67547)
-- Dependencies: 223
-- Data for Name: processo_atividades; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3163 (class 0 OID 67550)
-- Dependencies: 224
-- Data for Name: processo_riscos; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3164 (class 0 OID 67553)
-- Dependencies: 225
-- Data for Name: processo_unidades; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3166 (class 0 OID 67558)
-- Dependencies: 227
-- Data for Name: risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--



--
-- TOC entry 3168 (class 0 OID 67569)
-- Dependencies: 229
-- Data for Name: tipo_processo; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.tipo_processo VALUES (2, 'Primário', 2);
INSERT INTO public.tipo_processo VALUES (3, 'Gerencial', 2);
INSERT INTO public.tipo_processo VALUES (1, 'Apoio', 2);


--
-- TOC entry 3170 (class 0 OID 67577)
-- Dependencies: 231
-- Data for Name: tratamento_risco; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.tratamento_risco VALUES (3, 'Um risco normalmente é evitado quando é classificado como “Alto” ou “Extremo”, e a implementação de controles apresenta um custo muito elevado, inviabilizando sua mitigação, ou não há entidades dispostas a compartilhar o risco com a UFC.', 'Evitar', false, NULL, 2);
INSERT INTO public.tratamento_risco VALUES (2, 'Um risco normalmente é aceito quando seu nível está nas faixas de apetite a risco. Nessa situação, nenhum novo controle precisa ser implementado para mitigar o risco.', 'Aceitar', false, NULL, 2);
INSERT INTO public.tratamento_risco VALUES (4, 'Um risco normalmente é mitigado quando é classificado como “Alto” ou “Extremo”. Mitigar o risco significa implementar controles que possam diminuir as causas ou as consequências dos riscos, identificadas na etapa de Identificação e Análise de Riscos.', 'Mitigar', true, NULL, 2);
INSERT INTO public.tratamento_risco VALUES (5, 'Um risco normalmente é transferido quando é classificado como “Alto” ou “Extremo”, e identificado uma unidade que tenha mais robustez para tratar deste risco.', 'Transferir', false, NULL, 2);


--
-- TOC entry 3172 (class 0 OID 67588)
-- Dependencies: 233
-- Data for Name: unidade; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.unidade VALUES (1, false, 'PRÓ-REITORIA DE GESTÃO DE PESSOAS', 'PROGEP', 4, 22, NULL);
INSERT INTO public.unidade VALUES (2, false, 'COORDENADORIA DE ADMINISTRAÇÃO DE PESSOAL', 'CAPES', 8, 1, NULL);
INSERT INTO public.unidade VALUES (11, false, 'DIVISÃO DE CARREIRA E AVALIAÇÃO DE DESEMPENHO', 'DICAD', 178, 8, NULL);
INSERT INTO public.unidade VALUES (13, false, 'DIVISÃO DE FORMAÇÃO PROFISSIONAL', 'DIFOP', 189, 8, NULL);
INSERT INTO public.unidade VALUES (14, false, 'COORDENADORIA DE QUALIDADE DE VIDA NO TRABALHO', 'COQVT', 19, 1, NULL);
INSERT INTO public.unidade VALUES (12, false, 'DIVISÃO DE GESTÃO POR COMPETÊNCIAS', 'DIGEC', 180, 8, NULL);
INSERT INTO public.unidade VALUES (19, false, 'COORDENADORIA DE PERÍCIA E ASSISTÊNCIA AO SERVIDOR', 'CPASE', 71, 1, NULL);
INSERT INTO public.unidade VALUES (18, false, 'DIVISÃO DE PROGRAMAS E PROJETOS CULTURAIS', 'DIPPC', 218, 14, NULL);
INSERT INTO public.unidade VALUES (9, false, 'DIVISÃO DE DIMENSIONAMENTO E MOVIMENTAÇÃO', 'DIMOV', 165, 8, NULL);
INSERT INTO public.unidade VALUES (17, false, 'DIVISÃO DE APOIO PSICOSSOCIAL', 'DIAPS', 209, 14, NULL);
INSERT INTO public.unidade VALUES (5, false, 'DIVISÃO DE PROVIMENTO DE APOSENTADORIAS E PENSÕES', 'DIPAP', 142, 2, NULL);
INSERT INTO public.unidade VALUES (16, false, 'DIVISÃO DE ENGENHARIA DE SEGURANÇA E MEDICINA DO TRABALHO', 'DESMT', 200, 14, NULL);
INSERT INTO public.unidade VALUES (15, false, 'DIVISÃO DE ADMINISTRAÇÃO DE BENEFÍCIOS', 'DIBEN', 193, 14, NULL);
INSERT INTO public.unidade VALUES (4, false, 'DIVISÃO DE PAGAMENTO DE PESSOAL ATIVO', 'DIPAG', 137, 2, NULL);
INSERT INTO public.unidade VALUES (8, false, 'COORDENADORIA DE DESENVOLVIMENTO E CAPACITAÇÃO', 'CODEC', 13, 1, NULL);
INSERT INTO public.unidade VALUES (6, false, 'DIVISÃO DE PAGAMENTO DE APOSENTADORIAS E PENSÕES', 'DPAPP', 148, 2, NULL);
INSERT INTO public.unidade VALUES (3, false, 'DIVISÃO DE INFORMAÇÃO DE PESSOAL ATIVO', 'DIPAT', 120, 2, NULL);
INSERT INTO public.unidade VALUES (7, false, 'DIVISÃO DE ATENDIMENTO E CONTROLE EXTERNO', 'DIACE', 158, 2, NULL);
INSERT INTO public.unidade VALUES (26, false, 'CENTRAL DE SERVIÇOS AO SERVIDOR', 'CENSER', 111, 1, NULL);
INSERT INTO public.unidade VALUES (22, false, 'UNIVERSIDADE FEDERAL DO CEARÁ', 'UFC', 222, NULL, NULL);
INSERT INTO public.unidade VALUES (24, false, 'COMISSÃO PERMANENTE DE ACUMULAÇÃO DE CARGOS', 'CPAC', 89, 1, NULL);
INSERT INTO public.unidade VALUES (25, false, 'SECRETARIA ADMINISTRATIVA/PROGEP', 'SECAD', 95, 1, NULL);
INSERT INTO public.unidade VALUES (23, false, 'COMISSÃO PERMANENTE DE PESSOAL DOCENTE', 'CPPD', 88, 1, NULL);
INSERT INTO public.unidade VALUES (20, false, 'ASSESSORIA TÉCNICA', 'ATA', 76, 1, NULL);
INSERT INTO public.unidade VALUES (21, false, 'ASSESSORIA DE LEGISLAÇÃO E NORMAS', 'ALN', 86, 1, NULL);
INSERT INTO public.unidade VALUES (28, false, 'COMISSÃO DE AVALIAÇÃO DE CERTIFICADOS E TÍTULOS', 'CAVCT', 159, 8, NULL);
INSERT INTO public.unidade VALUES (10, false, 'DIVISÃO DE CONCURSOS E PROVIMENTO', 'DICON', 173, 8, NULL);


--
-- TOC entry 3174 (class 0 OID 67599)
-- Dependencies: 235
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: riscos_user
--

INSERT INTO public.usuario VALUES (24, NULL, 'alexandredutra@mail.com', true, 'ALEXANDRE DUTRA DA COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (26, NULL, 'anacarlafreitas@mail.com', true, 'ANA CARLA FREITAS DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (27, NULL, 'anaclea@mail.com', true, 'ANA CLEA DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (28, NULL, 'anapatriciagurgel@mail.com', true, 'ANA PATRICIA GURGEL BARRETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (29, NULL, 'anapatriciapierre@mail.com', true, 'ANA PATRICIA PIERRE JUSTO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (30, NULL, 'andreluiz@mail.com', true, 'ANDRE LUIZ GOMES AIRES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (31, NULL, 'antonionardielo@mail.com', true, 'ANTONIO NARDIELO GOMES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (32, NULL, 'dorismaria@mail.com', true, 'DORIS MARIA SOARES SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (33, NULL, 'elienemaria@mail.com', true, 'ELIENE MARIA SARAIVA MACIEL', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (40, NULL, 'fraciscojose@mail.com', true, 'FRANCISCO JOSE CARNEIRO TELES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (41, NULL, 'francisojuliao@mail.com', true, 'FRANCISCO JULIÃO MOREIRA BARRETO CAVALCANTE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (87, NULL, 'analucia@mail.com', true, 'ANA LUCIA VITORIANO LOPES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 23);
INSERT INTO public.usuario VALUES (88, NULL, 'josefontaine@mail.com', true, 'JOSE FONTAINE TAVARES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 23);
INSERT INTO public.usuario VALUES (148, NULL, 'danieltorres@mail.com', true, 'DANIEL TORRES MEDEIROS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (116, NULL, 'alexbruno@mail.com', true, 'ALEX BRUNO QUEIROZ MACIEL', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (89, NULL, 'joaofelipe@mail.com', true, 'JOAO FELIPE ARAUJO SCHMITT', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 24);
INSERT INTO public.usuario VALUES (90, NULL, 'marialinekely@mail.com', true, 'MARIA LINEKELY DA SILVA AGUIAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 24);
INSERT INTO public.usuario VALUES (91, NULL, 'marinaldapinheiro@mail.com', true, 'MARINALDA PINHEIRO DA COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 24);
INSERT INTO public.usuario VALUES (92, NULL, 'robertamedeiros@mail.com', true, 'ROBERTA MEDEIROS DE QUEIROZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 24);
INSERT INTO public.usuario VALUES (72, NULL, 'anacristina@mail.com', true, 'ANA CRISTINA TEIXEIRA DE BRITO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (159, NULL, 'alineverissimo@mail.com', true, 'ALINE VERISSIMO DE ALMEIDA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 28);
INSERT INTO public.usuario VALUES (160, NULL, 'mariadosocorro@mail.com', true, 'MARIA DO SOCORRO FERREIRA ALBUQUERQUE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 28);
INSERT INTO public.usuario VALUES (79, NULL, 'pedropaulobarbosa@mail.com', true, 'PEDRO PAULO BARBOSA FEITOSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (73, NULL, 'cledsonalexandre@mail.com', true, 'CLEDSON ALEXANDRE NOGUEIRA NOBRE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (74, NULL, 'denilsonsales@mail.com', true, 'DENILSON SALES DO NASCIMENTO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (75, NULL, 'florilenechaves@mail.com', true, 'FLORILENE CHAVES MARINHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (76, NULL, 'leopoldoviana@mail.com', true, 'LEOPOLDO VIANA FROTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (77, NULL, 'mariado@mail.com', true, 'MARIA DO SOCORRO XIMENES AGUIAR MELO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (78, NULL, 'marlonbruno@mail.com', true, 'MARLON BRUNO MATOS PAIVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (80, NULL, 'rafaelde@mail.com', true, 'RAFAEL DE FREITAS PEREIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (81, NULL, 'teresacristina@mail.com', true, 'TERESA CRISTINA AGUIAR LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (82, NULL, 'ygorfrota@mail.com', true, 'YGOR FROTA DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 20);
INSERT INTO public.usuario VALUES (119, NULL, 'anacristinacaminha@mail.com', true, 'ANA CRISTINA CAMINHA VIANA LOPES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (117, NULL, 'alissonmatheus@mail.com', true, 'ALISSON MATHEUS NOGUEIRA DA ROCHA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (118, NULL, 'amauriportela@mail.com', true, 'AMAURI PORTELA SOARES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (83, NULL, 'camilaarraes@mail.com', true, 'CAMILA ARRAES DE ALENCAR PIMENTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 21);
INSERT INTO public.usuario VALUES (84, NULL, 'leticiafernandes@mail.com', true, 'LETICIA FERNANDES DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 21);
INSERT INTO public.usuario VALUES (85, NULL, 'mariatereza@mail.com', true, 'MARIA TEREZA ARRUDA SILVA DO NASCIMENTO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 21);
INSERT INTO public.usuario VALUES (86, NULL, 'williampaiva@mail.com', true, 'WILLIAM PAIVA MARQUES JUNIOR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 21);
INSERT INTO public.usuario VALUES (120, NULL, 'augustomilton@mail.com', true, 'AUGUSTO MILTON BARRETO SILVA JUNIOR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (121, NULL, 'claudiafabiane@mail.com', true, 'CLAUDIA FABIANE BANDEIRA DE ALMEIDA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (122, NULL, 'esaucavalcante@mail.com', true, 'ESAU CAVALCANTE NETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (123, NULL, 'marceloeugenio@mail.com', true, 'MARCELO EUGENIO SILVA LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (162, NULL, 'alexiaaguiar@mail.com', true, 'ALEXIA AGUIAR DE MOURA FERREIRA GOMES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (124, NULL, 'mauriciosousa@mail.com', true, 'MAURICIO SOUSA VIANA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (125, NULL, 'raquelda@mail.com', true, 'RAQUEL DA SILVA COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (166, NULL, 'marianabanhos@mail.com', true, 'MARIANA BANHOS DE MENEZES FORTE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (167, NULL, 'rebekamaria@mail.com', true, 'REBEKA MARIA SOTERO SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (192, NULL, 'lucasde@mail.com', true, 'LUCAS DE OLIVEIRA MACHADO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (193, NULL, 'manoelfernandes@mail.com', true, 'MANOEL FERNANDES DE LIMA NETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (154, NULL, 'camilasouzacordeiro@mail.com', true, 'CAMILA DE SOUZA CORDEIRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 7);
INSERT INTO public.usuario VALUES (222, NULL, 'henrydeholanda@mail.com', true, 'HENRY DE HOLANDA CAMPOS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 22);
INSERT INTO public.usuario VALUES (39, NULL, 'franciscofelipe@mail.com', true, 'FRANCISCO FELIPE ARAUJO COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (47, NULL, 'joseronier@mail.com', true, 'JOSE RONIER DE FRANCA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (46, NULL, 'josehenrique@mail.com', true, 'JOSE HENRIQUE SOUSA LUZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (194, NULL, 'renande@mail.com', true, 'RENAN DE CALDAS HONORATO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (195, NULL, 'teanafatima@mail.com', true, 'TEANA FATIMA BRANDAO DE SOUZA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (196, NULL, 'ameliamaria@mail.com', true, 'AMELIA MARIA SANTOS SPINDOLA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (197, NULL, 'antonialidiane@mail.com', true, 'ANTONIA LIDIANE DE SOUSA LEITAO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (198, NULL, 'diegoazevedo@mail.com', true, 'DIEGO AZEVEDO MAIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (199, NULL, 'elizangeladavila@mail.com', true, 'ELIZANGELA DAVILA ROCHA VIEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (8, NULL, 'camilasouza@mail.com', true, 'CAMILA DE SOUZA AQUINO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 2);
INSERT INTO public.usuario VALUES (9, NULL, 'josedelmiro@mail.com', true, 'JOSE DELMIRO VASCONCELOS NETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 2);
INSERT INTO public.usuario VALUES (10, NULL, 'vanessaluana@mail.com', true, 'VANESSA LUANA DE FREITAS MELO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 2);
INSERT INTO public.usuario VALUES (11, NULL, 'anacarla@mail.com', true, 'ANA CARLA PEREIRA DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (12, NULL, 'mariaroseane@mail.com', true, 'MARIA ROSEANE MENEZES DA COSTA FONTES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (13, NULL, 'marthapinheiro@mail.com', true, 'MARTHA PINHEIRO GOIANA DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (126, NULL, 'rosimarisouza@mail.com', true, 'ROSIMARI SOUZA RODRIGUES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (174, NULL, 'anacelia@mail.com', true, 'ANA CELIA MONTEIRO XAVIER', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (175, NULL, 'camilaizidorio@mail.com', true, 'CAMILA IZIDORIO DE SOUSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (176, NULL, 'jessicaoliveira@mail.com', true, 'JESSICA OLIVEIRA LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (177, NULL, 'luanabatista@mail.com', true, 'LUANA BATISTA RODRIGUES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (178, NULL, 'mariade@mail.com', true, 'MARIA DE FATIMA GONDIM CRUZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (179, NULL, 'synaralayana@mail.com', true, 'SYNARA LAYANA ROCHA BARBOSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 11);
INSERT INTO public.usuario VALUES (180, NULL, 'denisevasconcelos@mail.com', true, 'DENISE VASCONCELOS LANDIM', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 12);
INSERT INTO public.usuario VALUES (181, NULL, 'ioneiryviana@mail.com', true, 'IONEIRY VIANA LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 12);
INSERT INTO public.usuario VALUES (127, NULL, 'ruthmara@mail.com', true, 'RUTH MARA BARROS FERREIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (128, NULL, 'sergioluiz@mail.com', true, 'SERGIO LUIZ SAMPAIO COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 3);
INSERT INTO public.usuario VALUES (129, NULL, 'adrianoleite@mail.com', true, 'ADRIANO LEITE BARBOSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (130, NULL, 'claubercosta@mail.com', true, 'CLAUBER COSTA DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (131, NULL, 'emanueldade@mail.com', true, 'EMANUELDA DE LIMA MEDEIROS SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (140, NULL, 'aeciocosta@mail.com', true, 'AECIO COSTA DO NASCIMENTO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (143, NULL, 'diegoguedes@mail.com', true, 'DIEGO GUEDES FIRMINO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (34, NULL, 'ellencristine@mail.com', true, 'ELLEN CRISTINE MENDES OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (35, NULL, 'emanuellalustosa@mail.com', true, 'EMANUELLA LUSTOSA BANDEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (36, NULL, 'evaldarodrigues@mail.com', true, 'EVALDA RODRIGUES DA SILVA DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (37, NULL, 'fernandosergio@mail.com', true, 'FERNANDO SERGIO STUDART LEITAO FILHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (38, NULL, 'francimeirearaujo@mail.com', true, 'FRANCIMEIRE ARAUJO DE SOUSA FERREIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (42, NULL, 'idaliamaria@mail.com', true, 'IDALIA MARIA BRASIL BURLAMAQUI', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (43, NULL, 'imeldasales@mail.com', true, 'IMELDA SALES DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (44, NULL, 'izabelcristina@mail.com', true, 'IZABEL CRISTINA RIBEIRO GONCALVES DE MEDEIROS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (45, NULL, 'joaohermeto@mail.com', true, 'JOAO HERMETO LOURENCO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (48, NULL, 'ledamaria@mail.com', true, 'LEDA MARIA JUSTINO DE AGUIAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (49, NULL, 'marcelopinheiro@mail.com', true, 'MARCELO PINHEIRO TEIXEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (50, NULL, 'marciamusy@mail.com', true, 'MARCIA MUSY ARAUJO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (51, NULL, 'mariasandra@mail.com', true, 'MARIA SANDRA DOS SANTOS BRITO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (52, NULL, 'mariliacavalcanti@mail.com', true, 'MARILIA CAVALCANTI DA TRINDADE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (53, NULL, 'mayarafontenele@mail.com', true, 'MAYARA FONTENELE ALBUQUERQUE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (54, NULL, 'narafabiola@mail.com', true, 'NARA FABIOLA COSTA DE BRITO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (55, NULL, 'nellygomes@mail.com', true, 'NELLY GOMES DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (56, NULL, 'neylemoara@mail.com', true, 'NEYLE MOARA BRITO CRAVEIRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (190, NULL, 'franciscotiago@mail.com', true, 'FRANCISCO TIAGO DE SOUSA MOURA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (191, NULL, 'kelanebezerra@mail.com', true, 'KELANE BEZERRA DE AGUIAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 15);
INSERT INTO public.usuario VALUES (164, NULL, 'ligiamaria@mail.com', true, 'LIGIA MARIA ALENCAR DE FREITAS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (165, NULL, 'luzimararaujo@mail.com', true, 'LUZIMAR ARAUJO DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (14, NULL, 'paulofernandes@mail.com', true, 'PAULO FERNANDES DE FREITAS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (15, NULL, 'raimundononato@mail.com', true, 'RAIMUNDO NONATO BEZERRA DE MENDONCA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (16, NULL, 'sylvanaholanda@mail.com', true, 'SYLVANA HOLANDA MOURA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (17, NULL, 'vanessatorres@mail.com', true, 'VANESSA TORRES MATOS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 8);
INSERT INTO public.usuario VALUES (18, NULL, 'gerusaholanda@mail.com', true, 'GERUSA HOLANDA BORGES PINHEIRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 14);
INSERT INTO public.usuario VALUES (19, NULL, 'renatamendes@mail.com', true, 'RENATA MENDES LUNA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 14);
INSERT INTO public.usuario VALUES (25, NULL, 'alineoliveira@mail.com', true, 'ALINE OLIVEIRA MAIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (163, NULL, 'gladialorena@mail.com', true, 'GLADIA LORENA LIMA MAIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (168, NULL, 'brunataiane@mail.com', true, 'BRUNA TAIANE FERREIRA DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (169, NULL, 'erikaserpa@mail.com', true, 'ERIKA SERPA DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (170, NULL, 'gliciellebezerra@mail.com', true, 'GLICIELLE BEZERRA DE QUEIROZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (171, NULL, 'lorenabraga@mail.com', true, 'LORENA BRAGA ALVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (172, NULL, 'patriciaaraujo@mail.com', true, 'PATRICIA ARAUJO SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (161, NULL, 'abrahaoscarcela@mail.com', true, 'ABRAHAO SCARCELA DE CARVALHO NETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 9);
INSERT INTO public.usuario VALUES (173, NULL, 'renatamelo@mail.com', true, 'RENATA MELO SILVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 10);
INSERT INTO public.usuario VALUES (201, NULL, 'helanenascimento@mail.com', true, 'HELANE NASCIMENTO E SILVA TELES DA FONSECA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (202, NULL, 'idayanesouza@mail.com', true, 'IDAYANE SOUZA DE ARAUJO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (203, NULL, 'igorarcanjo@mail.com', true, 'IGOR ARCANJO CHAVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (204, NULL, 'marcosfabio@mail.com', true, 'MARCOS FABIO PINTO BANDEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (205, NULL, 'marioleidede@mail.com', true, 'MARIOLEIDE DE FARIAS XAVIER', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (206, NULL, 'palomalira@mail.com', true, 'PALOMA LIRA PINTO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (207, NULL, 'raimundoosmarino@mail.com', true, 'RAIMUNDO OSMARINO ALMEIDA LEMOS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (208, NULL, 'rebecamatos@mail.com', true, 'REBECA MATOS FREIRE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (1, NULL, 'editineteandre@mail.com', true, 'EDITINETE ANDRE DA ROCHA GARCIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (2, NULL, 'franciscosilva@mail.com', true, 'FRANCISCO SILVA QUEIROZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (3, NULL, 'ingridmatela@mail.com', true, 'INGRID MATELA BRAQUEHAIS MENDONCA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (4, NULL, 'marilenefeitosa@mail.com', true, 'MARILENE FEITOSA SOARES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (5, NULL, 'nearcobarroso@mail.com', true, 'NEARCO BARROSO GUEDES DE ARAUJO FILHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (6, NULL, 'rosaleide@mail.com', true, 'ROSA LEIDE GOES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 1);
INSERT INTO public.usuario VALUES (7, NULL, 'anarodrigues@mail.com', true, 'ANA RODRIGUES SANTANA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 2);
INSERT INTO public.usuario VALUES (57, NULL, 'patriciaaparecida@mail.com', true, 'PATRICIA APARECIDA DA SILVA ALVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (58, NULL, 'pedropaulo@mail.com', true, 'PEDRO PAULO GOMES VIANA FILHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (59, NULL, 'rachelteixeira@mail.com', true, 'RACHEL TEIXEIRA LEAL NUNES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (60, NULL, 'raimundoaldemir@mail.com', true, 'RAIMUNDO ALDEMIR LIMA DO VALE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (61, NULL, 'raimundoevandro@mail.com', true, 'RAIMUNDO EVANDRO SOLEDADE SOUSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (62, NULL, 'raqueltelles@mail.com', true, 'RAQUEL TELLES QUIXADA LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (63, NULL, 'reginalucia@mail.com', true, 'REGINA LUCIA MOURA DE ARAUJO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (64, NULL, 'robertohaniery@mail.com', true, 'ROBERTO HANIERY PONTE ALVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (65, NULL, 'rosemarydamasceno@mail.com', true, 'ROSEMARY DAMASCENO BARRETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (66, NULL, 'sandramaria@mail.com', true, 'SANDRA MARIA EUGENIO DE SOUSA LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (104, NULL, 'rosamaria@mail.com', true, 'ROSA MARIA NOGUEIRA ROCHA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (67, NULL, 'terciomenezes@mail.com', true, 'TERCIO MENEZES GURGEL', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (68, NULL, 'valeskamaria@mail.com', true, 'VALESKA MARIA ALEXANDRE SANT ANNA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (69, NULL, 'vaneidemaria@mail.com', true, 'VANEIDE MARIA DE JESUS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (70, NULL, 'veralucia@mail.com', true, 'VERA LUCIA PEREIRA GARCIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (71, NULL, 'vicenteaguiar@mail.com', true, 'VICENTE AGUIAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 19);
INSERT INTO public.usuario VALUES (149, NULL, 'evaldosilva@mail.com', true, 'EVALDO SILVA DA COSTA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (150, NULL, 'franciscofreitas@mail.com', true, 'FRANCISCO FREITAS CABRAL', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (151, NULL, 'franciscomarcio@mail.com', true, 'FRANCISCO MARCIO LOBO DE SOUSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (152, NULL, 'mariada@mail.com', true, 'MARIA DA CONCEICAO SANTOS FREITAS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (153, NULL, 'sulannyde@mail.com', true, 'SULANNY DE SOUZA SAMPAIO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 6);
INSERT INTO public.usuario VALUES (105, NULL, 'brunade@mail.com', true, 'BRUNA DE MESQUITA VERAS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (106, NULL, 'carlosalberto@mail.com', true, 'CARLOS ALBERTO MARCELINO DINIZ DE SOUSA CRUZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (107, NULL, 'carolinerodrigues@mail.com', true, 'CAROLINE RODRIGUES ARAUJO HOLANDA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (108, NULL, 'edigleysilva@mail.com', true, 'EDIGLEY SILVA BARBOSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (109, NULL, 'ericodias@mail.com', true, 'ERICO DIAS DE SALES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (110, NULL, 'estevaode@mail.com', true, 'ESTEVAO DE SOUSA MARTINS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (111, NULL, 'franciscopaceli@mail.com', true, 'FRANCISCO PACELI LUNA GOMES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (112, NULL, 'julianamontezuma@mail.com', true, 'JULIANA MONTEZUMA BARBOSA MONTEIRO TINEL', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (113, NULL, 'juracypereira@mail.com', true, 'JURACY PEREIRA DE ANDRADE FILHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (114, NULL, 'kamillanathasha@mail.com', true, 'KAMILLA NATHASHA CORDEIRO ROCHA MAGALHAES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (115, NULL, 'niveafranklin@mail.com', true, 'NIVEA FRANKLIN CHAVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 26);
INSERT INTO public.usuario VALUES (93, NULL, 'annacarollyna@mail.com', true, 'ANNA CAROLLYNA DE BULHOES MOREIRA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (94, NULL, 'attilapinheiro@mail.com', true, 'ATTILA PINHEIRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (95, NULL, 'ciroregis@mail.com', true, 'CIRO REGIS LIMA TEIXEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (96, NULL, 'edvelinjessica@mail.com', true, 'EDVELIN JESSICA TEOTONIO DE ANDRADE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (97, NULL, 'franciscojorge@mail.com', true, 'FRANCISCO JORGE GURGEL DE LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (98, NULL, 'idalinanonato@mail.com', true, 'IDALINA NONATO DE QUEIROZ', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (99, NULL, 'iolanyestevao@mail.com', true, 'IOLANY ESTEVAO DE SOUZA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (100, NULL, 'joanadarc@mail.com', true, 'JOANA DARC ALVES BRANDAO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (101, NULL, 'juliannecampos@mail.com', true, 'JULIANNE CAMPOS MARINHO DE CASTRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (102, NULL, 'kibadanleite@mail.com', true, 'KIBADAN LEITE ANDRADE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (103, NULL, 'mariaaparecida@mail.com', true, 'MARIA APARECIDA DANTAS LOPES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 25);
INSERT INTO public.usuario VALUES (155, NULL, 'ericacavalcante@mail.com', true, 'ERICA CAVALCANTE LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 7);
INSERT INTO public.usuario VALUES (156, NULL, 'gerlaniafelix@mail.com', true, 'GERLANIA FELIX DE ALMEIDA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 7);
INSERT INTO public.usuario VALUES (157, NULL, 'robertoalcantara@mail.com', true, 'ROBERTO ALCANTARA VIEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 7);
INSERT INTO public.usuario VALUES (158, NULL, 'thaishelena@mail.com', true, 'THAIS HELENA CAVALCANTE LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 7);
INSERT INTO public.usuario VALUES (132, NULL, 'erickhenrique@mail.com', true, 'ERICK HENRIQUE AGUIAR ARAUJO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (133, NULL, 'euzenetealencar@mail.com', true, 'EUZENETE ALENCAR RODRIGUES PEREIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (134, NULL, 'franciscofernando@mail.com', true, 'FRANCISCO FERNANDO ALENCAR DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (135, NULL, 'ivanaserra@mail.com', true, 'IVANA SERRA RODRIGUES SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (136, NULL, 'josejoaquim@mail.com', true, 'JOSE JOAQUIM VIEIRA JUNIOR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (137, NULL, 'luizdavid@mail.com', true, 'LUIZ DAVID RICARTE DE SOUZA CUSTODIO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (138, NULL, 'mariaclara@mail.com', true, 'MARIA CLARA CUNHA ARAGAO DE ALBUQUERQUE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (139, NULL, 'teresinhaduarte@mail.com', true, 'TERESINHA DUARTE DE LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 4);
INSERT INTO public.usuario VALUES (146, NULL, 'ledamariapereira@mail.com', true, 'LEDA MARIA PEREIRA BARBOSA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (141, NULL, 'anajamille@mail.com', true, 'ANA JAMILLE TOMAZ VIANA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (142, NULL, 'antoniomarconieliton@mail.com', true, 'ANTONIO MARCONIELITON DE LIMA PESSOA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (144, NULL, 'endersonfelipe@mail.com', true, 'ENDERSON FELIPE RODRIGUES ANDRADE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (145, NULL, 'josefalaura@mail.com', true, 'JOSEFA LAURA CABRAL FIGUEIREDO RODRIGUES LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (147, NULL, 'vanderleialucia@mail.com', true, 'VANDERLEIA LUCIA DE SOUZA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 5);
INSERT INTO public.usuario VALUES (200, NULL, 'fabianeda@mail.com', true, 'FABIANE DA SILVA SEVERINO LIMA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 16);
INSERT INTO public.usuario VALUES (218, NULL, 'amandanobre@mail.com', true, 'AMANDA NOBRE DE AGUIAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 18);
INSERT INTO public.usuario VALUES (219, NULL, 'francimayrede@mail.com', true, 'FRANCIMAYRE DE SOUSA SABOIA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 18);
INSERT INTO public.usuario VALUES (220, NULL, 'pedroharrison@mail.com', true, 'PEDRO HARRISON DE FREITAS TEIXEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 18);
INSERT INTO public.usuario VALUES (221, NULL, 'renataalves@mail.com', true, 'RENATA ALVES DE OLIVEIRA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 18);
INSERT INTO public.usuario VALUES (209, NULL, 'anapaula@mail.com', true, 'ANA PAULA OLIVEIRA DE CARVALHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (210, NULL, 'andreiaserafim@mail.com', true, 'ANDREIA SERAFIM DE NEGREIROS TAISSUKE', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (211, NULL, 'deuciangelaangelo@mail.com', true, 'DEUCIANGELA ANGELO CARVALHO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (212, NULL, 'fannyabitbol@mail.com', true, 'FANNY ABITBOL DE MENEZES ROLIM', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (213, NULL, 'isaacvilanova@mail.com', true, 'ISAAC VILANOVA E SILVA NETO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (214, NULL, 'lidiacyntia@mail.com', true, 'LIDIA CYNTIA COELHO DE FARIAS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (215, NULL, 'pamellabeserra@mail.com', true, 'PAMELLA BESERRA DE MELO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (183, NULL, 'analuciasilva@mail.com', true, 'ANA LUCIA DA SILVA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (182, NULL, 'anaclarice@mail.com', true, 'ANA CLARICE MONTENEGRO UCHOA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (184, NULL, 'danielecirilo@mail.com', true, 'DANIELE CIRILO SULIANO DE MELO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (185, NULL, 'jamyledos@mail.com', true, 'JAMYLE DOS SANTOS MONTEIRO', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (186, NULL, 'jazetede@mail.com', true, 'JAZETE DE FREITAS ALENCAR', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (187, NULL, 'karinenascimento@mail.com', true, 'KARINE NASCIMENTO PORTELA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (188, NULL, 'luande@mail.com', true, 'LUAN DE OLIVEIRA ALMEIDA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);
INSERT INTO public.usuario VALUES (216, NULL, 'richellybarbosa@mail.com', true, 'RICHELLY BARBOSA DE MEDEIROS', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (217, NULL, 'shirleydias@mail.com', true, 'SHIRLEY DIAS GONCALVES', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 17);
INSERT INTO public.usuario VALUES (189, NULL, 'ritadecassia@mail.com', true, 'RITA DE CASSIA BRAGA CAVALCANTE CUNHA', '$2a$12$NMgLwu8bqUNT5sZjQPYfXehBWCKRJp4soaRtcZ6cFmnYNZD/o1fiu', 13);


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 197
-- Name: avaliacao_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.avaliacao_risco_id_seq', 1, false);


--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 199
-- Name: categoria_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.categoria_risco_id_seq', 6, true);


--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 201
-- Name: fator_avaliacao_controle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.fator_avaliacao_controle_id_seq', 10, true);


--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 196
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 203
-- Name: impacto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.impacto_id_seq', 10, true);


--
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 205
-- Name: indicador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.indicador_id_seq', 1, false);


--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 207
-- Name: matriz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.matriz_id_seq', 1, false);


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 209
-- Name: nivel_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.nivel_risco_id_seq', 8, true);


--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 211
-- Name: ocorrencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.ocorrencia_id_seq', 1, false);


--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 213
-- Name: plano_contingencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.plano_contingencia_id_seq', 1, false);


--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 215
-- Name: plano_tratamento_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.plano_tratamento_risco_id_seq', 1, false);


--
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 217
-- Name: politica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.politica_id_seq', 4, true);


--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 219
-- Name: probabilidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.probabilidade_id_seq', 10, true);


--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 221
-- Name: processo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.processo_id_seq', 9, true);


--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 226
-- Name: risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.risco_id_seq', 1, true);


--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 228
-- Name: tipo_processo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.tipo_processo_id_seq', 3, true);


--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 230
-- Name: tratamento_risco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.tratamento_risco_id_seq', 5, true);


--
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 232
-- Name: unidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.unidade_id_seq', 1, false);


--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 234
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: riscos_user
--

SELECT pg_catalog.setval('public.usuario_id_seq', 1, false);


--
-- TOC entry 2933 (class 2606 OID 67417)
-- Name: avaliacao_risco avaliacao_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT avaliacao_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2935 (class 2606 OID 67425)
-- Name: categoria_risco categoria_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.categoria_risco
    ADD CONSTRAINT categoria_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2937 (class 2606 OID 67436)
-- Name: fator_avaliacao_controle fator_avaliacao_controle_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.fator_avaliacao_controle
    ADD CONSTRAINT fator_avaliacao_controle_pkey PRIMARY KEY (id);


--
-- TOC entry 2939 (class 2606 OID 67444)
-- Name: impacto impacto_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.impacto
    ADD CONSTRAINT impacto_pkey PRIMARY KEY (id);


--
-- TOC entry 2941 (class 2606 OID 67455)
-- Name: indicador indicador_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.indicador
    ADD CONSTRAINT indicador_pkey PRIMARY KEY (id);


--
-- TOC entry 2943 (class 2606 OID 67463)
-- Name: matriz matriz_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz
    ADD CONSTRAINT matriz_pkey PRIMARY KEY (id);


--
-- TOC entry 2945 (class 2606 OID 67474)
-- Name: nivel_risco nivel_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.nivel_risco
    ADD CONSTRAINT nivel_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2947 (class 2606 OID 67485)
-- Name: ocorrencia ocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT ocorrencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2949 (class 2606 OID 67496)
-- Name: plano_contingencia plano_contingencia_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT plano_contingencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2951 (class 2606 OID 67507)
-- Name: plano_tratamento_risco plano_tratamento_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT plano_tratamento_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2953 (class 2606 OID 67518)
-- Name: politica politica_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.politica
    ADD CONSTRAINT politica_pkey PRIMARY KEY (id);


--
-- TOC entry 2955 (class 2606 OID 67535)
-- Name: probabilidade probabilidade_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.probabilidade
    ADD CONSTRAINT probabilidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2957 (class 2606 OID 67546)
-- Name: processo processo_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo
    ADD CONSTRAINT processo_pkey PRIMARY KEY (id);


--
-- TOC entry 2959 (class 2606 OID 67566)
-- Name: risco risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2961 (class 2606 OID 67574)
-- Name: tipo_processo tipo_processo_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tipo_processo
    ADD CONSTRAINT tipo_processo_pkey PRIMARY KEY (id);


--
-- TOC entry 2963 (class 2606 OID 67585)
-- Name: tratamento_risco tratamento_risco_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tratamento_risco
    ADD CONSTRAINT tratamento_risco_pkey PRIMARY KEY (id);


--
-- TOC entry 2967 (class 2606 OID 67615)
-- Name: usuario uk_5171l57faosmj8myawaucatdw; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uk_5171l57faosmj8myawaucatdw UNIQUE (email);


--
-- TOC entry 2965 (class 2606 OID 67596)
-- Name: unidade unidade_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT unidade_pkey PRIMARY KEY (id);


--
-- TOC entry 2969 (class 2606 OID 67607)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3007 (class 2606 OID 67811)
-- Name: tipo_processo fk1qpvkqnae8qmjwu5xsfh4w3mj; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tipo_processo
    ADD CONSTRAINT fk1qpvkqnae8qmjwu5xsfh4w3mj FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 3011 (class 2606 OID 67831)
-- Name: unidade fk1stvqraetmvo7cxsra0f88hn7; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fk1stvqraetmvo7cxsra0f88hn7 FOREIGN KEY (unidade_pai_id) REFERENCES public.unidade(id);


--
-- TOC entry 2999 (class 2606 OID 67781)
-- Name: processo_riscos fk1uyjt11f66ntgmfbf1qfwc01x; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo_riscos
    ADD CONSTRAINT fk1uyjt11f66ntgmfbf1qfwc01x FOREIGN KEY (processo_id) REFERENCES public.processo(id);


--
-- TOC entry 2982 (class 2606 OID 67676)
-- Name: matriz fk31flsjxsqyuemrjii19b3xd47; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz
    ADD CONSTRAINT fk31flsjxsqyuemrjii19b3xd47 FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 3008 (class 2606 OID 67816)
-- Name: tratamento_risco fk38v4hk1f1eovpjismg2qo6pdf; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.tratamento_risco
    ADD CONSTRAINT fk38v4hk1f1eovpjismg2qo6pdf FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2979 (class 2606 OID 67661)
-- Name: indicador fk4hicd1tcqk68egf2vogu0jmtc; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.indicador
    ADD CONSTRAINT fk4hicd1tcqk68egf2vogu0jmtc FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 3003 (class 2606 OID 67854)
-- Name: risco fk5g9a4l2c3b8d1fxwv597h5547; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fk5g9a4l2c3b8d1fxwv597h5547 FOREIGN KEY (unidade_id) REFERENCES public.unidade(id);


--
-- TOC entry 2974 (class 2606 OID 67636)
-- Name: avaliacao_risco fk6averwyd64d0mbfr5hhgv8r3x; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fk6averwyd64d0mbfr5hhgv8r3x FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2989 (class 2606 OID 67711)
-- Name: plano_contingencia fk7ph4fihw6hl4chsf0b2bw5o5r; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT fk7ph4fihw6hl4chsf0b2bw5o5r FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2995 (class 2606 OID 67761)
-- Name: processo fk8loj0njew9073ri573fliqicv; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo
    ADD CONSTRAINT fk8loj0njew9073ri573fliqicv FOREIGN KEY (tipo_id) REFERENCES public.tipo_processo(id);


--
-- TOC entry 2972 (class 2606 OID 67626)
-- Name: avaliacao_risco fk8p04vtfdmo9bam2nnjk149ukv; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fk8p04vtfdmo9bam2nnjk149ukv FOREIGN KEY (probabilidade_id) REFERENCES public.probabilidade(id);


--
-- TOC entry 2997 (class 2606 OID 67771)
-- Name: processo_atividades fk9oooc5r44ke9fn4jrvqrg02yf; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo_atividades
    ADD CONSTRAINT fk9oooc5r44ke9fn4jrvqrg02yf FOREIGN KEY (processo_id) REFERENCES public.processo(id);


--
-- TOC entry 3002 (class 2606 OID 67849)
-- Name: risco fkab01bb1qrx97fiktkq79xesjc; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fkab01bb1qrx97fiktkq79xesjc FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2973 (class 2606 OID 67631)
-- Name: avaliacao_risco fkac0eidmqf57sxh01h1v7484lo; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fkac0eidmqf57sxh01h1v7484lo FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2970 (class 2606 OID 67616)
-- Name: avaliacao_risco fkajl0gjduuhol4o3v3ejq2w1u0; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fkajl0gjduuhol4o3v3ejq2w1u0 FOREIGN KEY (fator_avaliacao_controle_id) REFERENCES public.fator_avaliacao_controle(id);


--
-- TOC entry 3001 (class 2606 OID 67791)
-- Name: processo_unidades fkapkx2vq7v15f7ro74dn6408rv; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo_unidades
    ADD CONSTRAINT fkapkx2vq7v15f7ro74dn6408rv FOREIGN KEY (processo_id) REFERENCES public.processo(id);


--
-- TOC entry 2998 (class 2606 OID 67776)
-- Name: processo_riscos fkauuvrcbtfhjd3h7ve8ym7w0sd; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo_riscos
    ADD CONSTRAINT fkauuvrcbtfhjd3h7ve8ym7w0sd FOREIGN KEY (riscos_id) REFERENCES public.risco(id);


--
-- TOC entry 2975 (class 2606 OID 67641)
-- Name: categoria_risco fkb2xlsrtyufxkqmfwf3x0jdtnq; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.categoria_risco
    ADD CONSTRAINT fkb2xlsrtyufxkqmfwf3x0jdtnq FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2996 (class 2606 OID 67766)
-- Name: processo fkb5d3qkdx20tf878kgadlpg30y; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo
    ADD CONSTRAINT fkb5d3qkdx20tf878kgadlpg30y FOREIGN KEY (unidade_responsavel_id) REFERENCES public.unidade(id);


--
-- TOC entry 2988 (class 2606 OID 67706)
-- Name: plano_contingencia fkc7xsuj8rdvjklktqkssyt5lec; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_contingencia
    ADD CONSTRAINT fkc7xsuj8rdvjklktqkssyt5lec FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 3004 (class 2606 OID 67796)
-- Name: risco fkcecwf8g7l2j9ehjdjk8s5nr2h; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fkcecwf8g7l2j9ehjdjk8s5nr2h FOREIGN KEY (categoria_id) REFERENCES public.categoria_risco(id);


--
-- TOC entry 2978 (class 2606 OID 67656)
-- Name: indicador fkddjuhwi1hdjcsriep10a7bubw; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.indicador
    ADD CONSTRAINT fkddjuhwi1hdjcsriep10a7bubw FOREIGN KEY (processo_id) REFERENCES public.processo(id);


--
-- TOC entry 2977 (class 2606 OID 67651)
-- Name: impacto fkdewx1b9o1se3sxihd4d6trdlr; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.impacto
    ADD CONSTRAINT fkdewx1b9o1se3sxihd4d6trdlr FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2985 (class 2606 OID 67691)
-- Name: ocorrencia fkdql38pf2lxd9w8akmkrwj66xv; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkdql38pf2lxd9w8akmkrwj66xv FOREIGN KEY (plano_contingencia_id) REFERENCES public.plano_contingencia(id);


--
-- TOC entry 2993 (class 2606 OID 67751)
-- Name: probabilidade fkfxmtmcw52stqhttyyrabuy89i; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.probabilidade
    ADD CONSTRAINT fkfxmtmcw52stqhttyyrabuy89i FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2981 (class 2606 OID 67671)
-- Name: matriz fkh94b06dud9io56fut1jwumg15; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz
    ADD CONSTRAINT fkh94b06dud9io56fut1jwumg15 FOREIGN KEY (nivel_id) REFERENCES public.nivel_risco(id);


--
-- TOC entry 2987 (class 2606 OID 67701)
-- Name: ocorrencia fkhq7ia56e1v5n7qcjwgb2tj6id; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkhq7ia56e1v5n7qcjwgb2tj6id FOREIGN KEY (risco_id) REFERENCES public.risco(id);


--
-- TOC entry 2983 (class 2606 OID 67681)
-- Name: matriz fki5m3wqx1ol2p5tc4o6oft8i1t; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz
    ADD CONSTRAINT fki5m3wqx1ol2p5tc4o6oft8i1t FOREIGN KEY (probabilidade_id) REFERENCES public.probabilidade(id);


--
-- TOC entry 3005 (class 2606 OID 67801)
-- Name: risco fkio004nou6go8vqjo2yh8wuoue; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fkio004nou6go8vqjo2yh8wuoue FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 2991 (class 2606 OID 76122)
-- Name: plano_tratamento_risco fkivwu469b6hc3gkx4v91hi68h0; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT fkivwu469b6hc3gkx4v91hi68h0 FOREIGN KEY (tratamento_risco_id) REFERENCES public.tratamento_risco(id);


--
-- TOC entry 3010 (class 2606 OID 67821)
-- Name: unidade fkkm5xutfqh8xhlpmunrh0ktd52; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fkkm5xutfqh8xhlpmunrh0ktd52 FOREIGN KEY (chefe_id) REFERENCES public.usuario(id);


--
-- TOC entry 3012 (class 2606 OID 67836)
-- Name: unidade fkmddh6eo6qwvo0ihot8dmj3hth; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.unidade
    ADD CONSTRAINT fkmddh6eo6qwvo0ihot8dmj3hth FOREIGN KEY (vice_chefe_id) REFERENCES public.usuario(id);


--
-- TOC entry 2994 (class 2606 OID 67756)
-- Name: processo fkmqa7fp3n8ku56m5pusavurvte; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo
    ADD CONSTRAINT fkmqa7fp3n8ku56m5pusavurvte FOREIGN KEY (gerente_id) REFERENCES public.usuario(id);


--
-- TOC entry 2992 (class 2606 OID 67716)
-- Name: plano_tratamento_risco fkp2fx30vrdecpf6gpvfmx576oy; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT fkp2fx30vrdecpf6gpvfmx576oy FOREIGN KEY (tratamento_id) REFERENCES public.tratamento_risco(id);


--
-- TOC entry 2976 (class 2606 OID 67646)
-- Name: fator_avaliacao_controle fkp8vrvt7fqcajymvvibkk9gygp; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.fator_avaliacao_controle
    ADD CONSTRAINT fkp8vrvt7fqcajymvvibkk9gygp FOREIGN KEY (politica_id) REFERENCES public.politica(id);


--
-- TOC entry 2980 (class 2606 OID 67666)
-- Name: matriz fkpggijyluqc7wr79xlru2w57t3; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.matriz
    ADD CONSTRAINT fkpggijyluqc7wr79xlru2w57t3 FOREIGN KEY (impacto_id) REFERENCES public.impacto(id);


--
-- TOC entry 2986 (class 2606 OID 67696)
-- Name: ocorrencia fkqdlch2956p0g19vl6ltwygdq0; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.ocorrencia
    ADD CONSTRAINT fkqdlch2956p0g19vl6ltwygdq0 FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 3000 (class 2606 OID 67786)
-- Name: processo_unidades fkqu1iucl87hlxw08xkphv3kfc9; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.processo_unidades
    ADD CONSTRAINT fkqu1iucl87hlxw08xkphv3kfc9 FOREIGN KEY (unidades_id) REFERENCES public.unidade(id);


--
-- TOC entry 2971 (class 2606 OID 67621)
-- Name: avaliacao_risco fkr2cc8y4fu15e1wyve8ngvx8nm; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.avaliacao_risco
    ADD CONSTRAINT fkr2cc8y4fu15e1wyve8ngvx8nm FOREIGN KEY (impacto_id) REFERENCES public.impacto(id);


--
-- TOC entry 2990 (class 2606 OID 76117)
-- Name: plano_tratamento_risco fks71leg3qxmd5tg3o91d6e0hpb; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.plano_tratamento_risco
    ADD CONSTRAINT fks71leg3qxmd5tg3o91d6e0hpb FOREIGN KEY (responsavel_id) REFERENCES public.usuario(id);


--
-- TOC entry 3013 (class 2606 OID 67841)
-- Name: usuario fksfuif7ykkynvxw4aqmk7shy7c; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fksfuif7ykkynvxw4aqmk7shy7c FOREIGN KEY (unidade_id) REFERENCES public.unidade(id);


--
-- TOC entry 3006 (class 2606 OID 67806)
-- Name: risco fktfmo9y0h0g7rwwj3a3jtl4afq; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.risco
    ADD CONSTRAINT fktfmo9y0h0g7rwwj3a3jtl4afq FOREIGN KEY (tratamento_id) REFERENCES public.plano_tratamento_risco(id);


--
-- TOC entry 2984 (class 2606 OID 67686)
-- Name: nivel_risco fktnkudqht2unix3w7u8yt06p4; Type: FK CONSTRAINT; Schema: public; Owner: riscos_user
--

ALTER TABLE ONLY public.nivel_risco
    ADD CONSTRAINT fktnkudqht2unix3w7u8yt06p4 FOREIGN KEY (politica_id) REFERENCES public.politica(id);


-- Completed on 2019-09-03 09:51:34 -03

--
-- PostgreSQL database dump complete
--

