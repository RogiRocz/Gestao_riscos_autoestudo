// Composables
import {
	createRouter,
	createWebHistory,
	type RouteRecordRaw,
} from 'vue-router';

const routes: Array<RouteRecordRaw> = [
	{
		path: '/',
		name: 'home',
		redirect: { name: 'login' },
	},
	{
		path: '/login',
		component: () => import('@/layouts/default/DefaultLayout.vue'),
		children: [
			{
				path: '',
				name: 'login',
				component: () => import('@/views/LoginView.vue'),
			},
		],
	},
	{
		path: '/admin',
		name: 'admin',
		meta: { requireAuth: true, role: ['admin'] },
		component: () => import('@/views/AdminView.vue'),
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

router.beforeEach((to, from, next) => {
	if (to.name == 'admin') {
		console.log('meta: ', to.meta);
	}

	next();
});

export default router;
