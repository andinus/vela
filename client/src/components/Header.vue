<template>
<div>
  <Menubar :model="items">
    <template #start>
      <p id="header-title">Vela</p>
    </template>
  </Menubar>
</div>
</template>

<script>
export default {
    data() {
        return {
            items: [
                {
                    label: 'Home',
                    icon: 'pi pi-fw pi-home',
                    to: '/'
                },
                {
                    label: 'Create Smiles',
                    icon: 'pi pi-fw pi-user-plus',
                    to: '/create'
                },
                {
                    label: 'huh',
                    icon: 'pi pi-fw pi-user-plus',
                    to: '/5a1PNZAMafXGGEFU17xcRX3bx6wyebeK/lNtEBCOd5yLlXT5enRQoh4ai4q3vcg7F'
                }
            ]
        }
    }
}
</script>

<style scoped>
#header-title {
    margin: 0 1ch 0 0;
    font-size: 150%;
    font-family: "Iosevka Etoile", serif;
}
</style>
