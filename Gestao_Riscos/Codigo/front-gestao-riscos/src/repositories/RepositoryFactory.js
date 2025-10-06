import UsuarioRepository from "./usuarioRepository";
import PlanoRepository from "./planoRepository";
import RiscoRepository from "./riscoRepository";
import AvaliacaoRepository from "./avaliacaoRepository";
import AcoesRepository from "./acoesRepository";
import AreaAtuacaoRepository from "./areaAtuacaoRepository";
import CategoriaRiscoRepository from "./categoriaRiscoRepository";
import ImpactoRepository from './impactoRepository';
import ProbabilidadeRepository from './probabilidadeRepository'
import NivelRiscoRepository from './nivelRiscoRepository'
import AvaliacaoControleRepository from './avaliacaoControleRepository'
import RespostaRiscoRepository from './respostaRiscoRepository'
import PlanoTratamentoRepository from './planoTratamentoRepository'
import PlanoContingenciaRepository from './planoContingenciaRepository'
import UnidadeRepository from './unidadeRepository'
import OcorrenciaRepository from './ocorrenciaRepository'

const repositories = {
    usuario: UsuarioRepository,
    plano: PlanoRepository,
    risco: RiscoRepository,
    avaliacao: AvaliacaoRepository,
    acao: AcoesRepository,
    areaAtuacao: AreaAtuacaoRepository,
    categoriaRisco : CategoriaRiscoRepository,
    impacto : ImpactoRepository,
    probabilidade : ProbabilidadeRepository,
    nivel : NivelRiscoRepository,
    avaliacaoControle : AvaliacaoControleRepository,
    resposta : RespostaRiscoRepository,
    planoTratamento : PlanoTratamentoRepository,
    planoContingencia : PlanoContingenciaRepository,
    ocorrencia : OcorrenciaRepository,
    unidade : UnidadeRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};
