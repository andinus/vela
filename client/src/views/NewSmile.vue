<template>
<div class="new-smile">
  <p id="subtitle">Create a new Smile :)</p>

  <div class="card">
    <div class="grid">
      <div class="col-12 md:col-6">
        <p>
          Filling this form will create a new "Smile Collection" for
          you, you can add your smiles to the collection using
          the <strong>private</strong> and your friends can view them
          using the <strong>public</strong> link.
        </p>
      </div>
      <div class="col-12 md:col-6 flex align-items-center justify-content-center">
        <div class="p-inputgroup">
          <InputText v-model="name" placeholder="Name" />
          <Button @click="createSmile"
                  icon="pi pi-user-plus" label="Create" class="p-button-success" />
        </div>
      </div>
    </div>
    <ProgressBar v-if="showProgress" mode="indeterminate" style="height: .4em;" />
  </div>

  <Toast />
</div>
</template>

<script>
export default {
    data() {
        return {
            name: '',
            showProgress: false
        }
    },
    methods: {
        createSmile() {
            if (this.name === '') {
                this.$toast.add({severity:'warn', summary: 'Invalid Name',
                                 detail:'Empty', life: 2000});
                return;
            }
            this.showProgress = true;
            console.log('Name', this.name);
        }
    }
}
</script>

<style scoped>
#subtitle {
    font-size: 1.5rem;
    text-align: center;
    margin: 2rem 0;
}
</style>
