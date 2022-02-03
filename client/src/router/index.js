import { createRouter, createWebHistory } from 'vue-router';

import Home from '../views/Home.vue';
import CreateSmiles from '../views/CreateSmiles.vue';
import GetSmile from '../views/GetSmile.vue';
import ManageSmiles from '../views/ManageSmiles.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/create',
        name: 'CreateSmiles',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        // component: () => import(/* webpackChunkName: "about" */ '../views/NewSmile.vue')
        component: CreateSmiles
    },
    {
        path: '/:id',
        name: 'GetSmile',
        component: GetSmile
    },
    {
        path: '/:id/:auth',
        name: 'ManageSmiles',
        component: ManageSmiles
    }
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
});

export default router;
