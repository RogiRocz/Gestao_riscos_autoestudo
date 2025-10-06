import store from '../store'
import DashboardPage from '../views/Dashboard'
import LoginPage from '../views/Login'
import NotFoundPage from '../views/utils/NotFoundPage'
import AccessDeniedPage from '../views/utils/AccessDeniedPage'
import ServerErrorPage from '../views/utils/ServerErrorPage'
import ListarPoliticas from '../views/politica/ListarPoliticas'
import CadastrarPolitica from '../views/politica/CadastrarPolitica'
import ConfigurarPolitica from '../views/politica/ConfiguracaoPolitica'
import ListarProcessos from '../views/processo/ListarProcessos'
import CadastrarProcesso from '../views/processo/CadastrarProcesso'
import ListarRiscos from '../views/risco/ListarRiscos'
import CadastrarRisco from '../views/risco/CadastrarRisco'
import ListarComunicacoes from '../views/comunicacao/ListarComunicacoes'
import Risco from "../views/risco/Risco"
import ListarAvaliacoes from "../views/risco/ListarAvaliacoes"


export default [

    {
        path: '/',
        name: 'Root',
        redirect: {
            name: 'Dashboard'
        }
    },
    {
        path: '/dashboard',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'Dashboard',
        component: DashboardPage
    },

    // Políticas
    {
        path: '/politicas',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'ListarPoliticas',
        component: ListarPoliticas
    },
    {
        path: '/politicas/cadastrar',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'CadastrarPolitica',
        component: CadastrarPolitica
    },
    {
        path: '/politicas/configuracaoPolitica/:id',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'ConfigurarPolitica',
        component: ConfigurarPolitica
    },

    //Processos
    {
        path: '/processos/',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'ListarProcessos',
        component: ListarProcessos
    },
    {
        path: '/processos/cadastrar',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'CadastrarProcesso',
        component: CadastrarProcesso
    },

    // Riscos
    {
        path: '/riscos',
        name: 'ListarRiscos',
        component: ListarRiscos
    },

    {
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        path: '/riscos/cadastrar',
        name: 'CadastrarRisco',
        component: CadastrarRisco
    },
    {
        path: '/riscos/:id',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'Risco',
        component: Risco
    },

    {
        path: '/riscos/editarRisco/:id',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'Risco',
        component: Risco
    },
    

    //Comunicações
    {
        path: '/comunicacoes',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'ListarComunicacoes',
        component: ListarComunicacoes
    },
    {
        path: '/avaliacoes/:id',
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'ListarAvaliacoes',
        component: ListarAvaliacoes
    },

    // Outras páginas
    {
        path: '/404',
        meta: {
            public: true,
        },
        name: 'NotFound',
        component: NotFoundPage
    },
    {
        path: '/403',
        meta: {
            public: true,
        },
        name: 'AccessDenied',
        component: AccessDeniedPage
    },
    {
        path: '/500',
        meta: {
            public: true,
        },
        name: 'ServerError',
        component: ServerErrorPage
    },
    {
        path: '/login',
        meta: {
            public: true,
        },
        name: 'Login',
        component: LoginPage
    },
    {
        path: '/logout',
        meta: { breadcrumb: true },
        name: 'Logout',
        beforeEnter (to, from, next) {
            store.dispatch('auth/logout')
        }
    },
    {
        path: '*',
        meta: {
            public: true,
        },
        redirect: {
            path: '/404'
        }
    },
    
    /*{
        path: '/riscos/detalhes/:id' ,
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'DetalhesRisco',
        component: DetalhesRisco
    },
    {
        meta: {
            breadcrumb: true,
            requiresAuth: true
        },
        name: 'EditarRisco',
        component: EditarRisco,
        path: '/riscos/editar'
    },*/,

  ];