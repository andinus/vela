<template>
<div class="new-smile">
  <p id="subtitle">Create Smiles :)</p>

  <div class="card">
    <Message v-if="smileCreated" severity="success">Smile Created.</Message>
    <div class="grid">
      <div class="col-12 md:col-6">
        <div v-if="smileCreated">
          <ul>
            <li>Click to copy the links.</li>
            <li>Share the <strong>public</strong> link with your friends.</li>
            <li>Keep the <strong>private</strong> link for yourself.</li>
          </ul>
        </div>
        <div v-else>
          <p>
            Filling this form will create a new "Smile Collection" for
            you, you can add your smiles to the collection using
            the <strong>private</strong> and your friends can view them
            using the <strong>public</strong> link.
          </p>
        </div>
      </div>
      <div class="col-12 md:col-6 flex align-items-center
                  justify-content-center">
        <div v-if="smileCreated" class="smile-links">
          <div class="grid">
            <div class="col-12 lg:col-6">
              <h5>Public</h5>
              <span class="p-input-icon-left">
                <i class="pi pi-share-alt" />
                <InputText @click="copyPublic" v-model="id"
                           type="text" placeholder="ID" readonly />
              </span>
            </div>
            <div class="col-12 lg:col-6">
              <h5>Private</h5>
              <span class="p-input-icon-left">
                <i class="pi pi-lock" />
                <InputText @click="copyPrivate" v-model="auth"
                           type="text" placeholder="Auth" readonly />
              </span>
            </div>
          </div>
        </div>
        <div v-else class="p-inputgroup">
          <InputText v-model="name" placeholder="Name" />
          <Button @click="createSmile"
                  icon="pi pi-user-plus" label="Create"
                  class="p-button-success" />
        </div>
      </div>
    </div>
    <div v-if="smileCreated" style="text-align: center;">
      <router-link :to="{ name: `ManageSmiles`, params: { id: `${id}`, auth: `${auth}` } }">
        <Button label="Upload Smiles"  icon="pi pi-upload" />
      </router-link>
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
            showProgress: false,
            id: '',
            auth: '',
        }
    },
    methods: {
        copyPublic() {
            navigator.clipboard.writeText(this.publicLink());
            this.$toast.add({severity: 'success', icon: 'pi-user-plus',
                             summary: 'Copied Public link to clipboard',
                             life: 2000});
        },
        copyPrivate() {
            navigator.clipboard.writeText(this.privateLink());
            this.$toast.add({severity: 'success',
                             summary: 'Copied Private link to clipboard',
                             life: 2000});
        },
        publicLink() {
            return window.location.href.replace('/create', '') + '/' + this.id;
        },
        privateLink() {
            return window.location.href.replace('/create', '') + '/' + this.id + '/' + this.auth;
        },
        createSmile() {
            if (this.name === '') {
                this.$toast.add({severity: 'warn', summary: 'Invalid Name',
                                 detail: 'Empty', life: 2000});
                return;
            }

            const data = { name: this.name };
            const toast = this.$toast;

            this.showProgress = true;
            fetch('http://localhost:9090/create', {
                method: 'POST',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                referrerPolicy: 'no-referrer',
                body: JSON.stringify(data)
            }).then(response => {
                if (!response.ok)
                    throw new Error('HTTP error, status = ' + response.status);
                return response.json();
            }).then(res => {
                this.id = res.id;
                this.auth = res.auth;
            }).catch(function(error) {
                console.log(error)
                toast.add({severity: 'error', summary: 'Service error', detail: error});
            }).finally(() => {
                this.showProgress = false;
            });
            // <<<< -- fat arrows mess with polymode formatting.
        }
    },
    computed: {
        smileCreated() {
            return this.id.length > 0 && this.auth.length > 0;
        },
    }
}
</script>

<style scoped>
.new-smile li {
    line-height: 1.6;
}
</style>
