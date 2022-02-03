import { createRouter, createWebHistory } from 'vue-router';

import Home from '../views/Home.vue';
import NewSmile from '../views/NewSmile.vue';
import GetSmile from '../views/GetSmile.vue';
import UploadSmile from '../views/UploadSmile.vue';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/new',
        name: 'New Smile',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        // component: () => import(/* webpackChunkName: "about" */ '../views/NewSmile.vue')
        component: NewSmile
    },
    {
        path: '/:id',
        name: 'Get Smile',
        component: GetSmile
    },
    {
        path: '/:id/:auth',
        name: 'Upload Smile',
        component: UploadSmile
    }
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
});

export default router;
