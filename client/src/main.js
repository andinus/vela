import {createApp} from 'vue';
import App from './App.vue';
import router from './router'

import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice';
import Menubar from 'primevue/menubar';
import Divider from 'primevue/divider';
import InputText from 'primevue/inputtext';
import Button from 'primevue/button';
import Card from 'primevue/card';
import Toast from 'primevue/toast';
import ProgressBar from 'primevue/progressbar';

import 'primevue/resources/themes/lara-dark-blue/theme.css';
import 'primevue/resources/primevue.min.css';
import 'primeicons/primeicons.css';
import 'primeflex/primeflex.css';

const app = createApp(App);
app.use(router);

app.use(PrimeVue);
app.use(ToastService);
app.component('Divider', Divider);
app.component('Menubar', Menubar);
app.component('InputText', InputText);
app.component('Button', Button);
app.component('Card', Card);
app.component('Toast', Toast);
app.component('ProgressBar', ProgressBar);

app.mount('#app');
