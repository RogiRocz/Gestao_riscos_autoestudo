import store from '../store'
import LoginPage from '../views/Login'
import Home from '../views/Home'
import ConfigurarPlanosRiscos from '../views/plano/ConfiguracaoPlano'
import CadastrarPlanosRiscos from '../views/plano/CadastrarPlanosRiscos'
import ListarRiscos from "../views/risco/ListaRisco";
import CadastroRisco from '../views/risco/CadastroRisco'
import DetalheRisco from '../views/risco/DetalheRisco'
import DetalheTratamento from '../views/risco/DetalhePlanoTratamento'

import ListaAcao from '../views/acao/ListaAcao';
import CadastroAcao from '../views/acao/CadastroAcao'
import DetalheAcao from "../views/acao/DetalheAcao";
import router from "@/router/index";
export default [
  /* Geral */
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/login",
    meta: {
      public: true,
    },
    props: true,
    name: "Login",
    component: LoginPage,
  },
  {
    path: "/logout",
    meta: { breadcrumb: true },
    name: "Logout",
    beforeEnter () {
      store.dispatch('auth/removeToken', false)
          .then(() => {
            router.push({ name: 'Login'});
          });
    }
  },
    // Plano de  Gestão de Riscos
  {
      path: '/planos',
      meta: {
          breadcrumb: true,
          requiresAuth: false
      },
      name: 'ConfigurarPlanosRiscos',
      component: ConfigurarPlanosRiscos
  },
  {
      path: '/planos/cadastrar',
      meta: {
          breadcrumb: true,
          requiresAuth: true
      },
      name: 'CadastrarPlanosRiscos',
      component: CadastrarPlanosRiscos
  },

    // Riscos
  {
    path: "/riscos",
    meta: {
      breadcrumb: true,
      requiresAuth: true,
    },
    name: "ListaRiscos",
    component: ListarRiscos,
  },

  {
    path: "/riscos/cadastrar",
    meta:{
      breadcrumb: true,
      requiresAuth: true,
    },
    name: "CadastroRisco",
    component: CadastroRisco
  },

  {
    path: '/riscos/:riscoId',
    meta: {
      breadcrumb: true,
      requiresAuth: true
    },
    name: 'DetalheRisco',
    component: DetalheRisco,
    props: true,
  },

  {
    path: '/riscos/:riscoId/tratamentos/:tratamentoId',
    meta: {
      breadcrumb: true,
      requiresAuth: true
    },
    name: 'DetalheTratamento',
    component: DetalheTratamento,
    props: true,
  },

    // Ações
  {
    path: "/acoes",
    meta: {
      breadcrumb: true,
      requiresAuth: true,
    },
    name: "ListaAcoes",
    component: ListaAcao
  },

  {
    path: "/acoes/cadastrar",
    meta:{
      breadcrumb: true,
      requiresAuth: true,
    },
    name: "CadastroAcao",
    component: CadastroAcao
  },

  {
    path: '/acoes/:acaoId',
    meta: {
      breadcrumb: true,
      requiresAuth: true
    },
    name: 'DetalheAcao',
    component: DetalheAcao,
    props: true,
  },
]
