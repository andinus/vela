<template>
<Header />
<div class="content-wrapper">
  <router-view />
</div>
</template>

<script>
import Header from '@/components/Header.vue'

export default {
    components: {
        Header
    }
}
</script>

<style>
body {
    background-color: var(--surface-b);
    font-family: "Iosevka Aile", sans-serif;
    color: var(--text-color);
}
.title { font-family: "Iosevka Etoile", serif; }
h1, h2, h3, h4, h5,  h6 {
    margin: 1.5rem 0 1rem 0;
    font-family: "Iosevka Etoile", serif;
    font-weight: 600;
    line-height: 1.2;
    color: inherit;
}
h1:first-child, h2:first-child, h3:first-child,
h4:first-child, h5:first-child, h6:first-child { margin-top: 0; }
h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.75rem; }
h4 { font-size: 1.5rem; }
h5 { font-size: 1.25rem; }
h6 { font-size: 1rem; }
p {
    line-height:1.5;
    margin:0 0 1rem 0;
}
.content-wrapper { padding: 1rem; }
@media screen and (min-width: 35.5em) {
    .content-wrapper { padding: 2rem; }
}
@media screen and (min-width: 48em) {
    .content-wrapper { padding: 3rem; }
}
@media screen and (min-width: 64em) {
    .content-wrapper { padding: 4rem; }
}
@media screen and (min-width: 80em) {
    .content-wrapper { padding: 6rem; }
}

.card {
    background: var(--surface-e);
    padding: 2rem;
    -webkit-box-shadow: 0 2px 1px -1px rgba(0,0,0,.2),0 1px 1px 0 rgba(0,0,0,.14),0 1px 3px 0 rgba(0,0,0,.12);
    box-shadow: 0 2px 1px -1px rgba(0,0,0,.2),0 1px 1px 0 rgba(0,0,0,.14),0 1px 3px 0 rgba(0,0,0,.12);
    border-radius: 4px;
    margin-bottom: 2rem;
}
#subtitle {
    font-size: 1.5rem;
    text-align: center;
    margin: 2rem 0;
}
</style>
