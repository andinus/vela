<template>
<div class="manage-smile">
  <p id="subtitle">Manage Smiles :)</p>
  <ProgressBar v-if="showLoading" mode="indeterminate" style="height: .4em;" />

  <div v-if="!verified && !showLoading" style="text-align: center;">
    <Button @click="verify" label="Try Again"
            class="p-button-outlined  p-button-info p-button-lg" icon="pi pi-refresh" />
  </div>

  <div v-if="verified" class="card">
    <div class="grid">
      <div class="col-12 md:col-6">
        <div class="col-12">
          <span class="p-input-icon-left">
            <i class="pi pi-user" />
            <InputText v-model="name" type="text" readonly />
          </span>
        </div>
        <div class="col-12">
          <span class="p-input-icon-left">
            <i class="pi pi-share-alt" />
            <InputText @click="copyPublic" v-model="id" type="text" readonly />
          </span>
        </div>
      </div>
      <div class="col-12 md:col-6">
        <FileUpload name="demo[]" url="/upload" @upload="onUpload" :multiple="true" accept="image/*" :maxFileSize="1000000">
          <template #empty>
            <p>Drag and drop files to here to upload.</p>
          </template>
        </FileUpload>
      </div>
    </div>
  </div>

  <Toast />
</div>
</template>

<script>
export default {
    data() {
        return {
            name: '',
            verified: false,
            showLoading: true,
            id: this.$route.params.id,
            auth: this.$route.params.auth,
        }
    },
    methods: {
        copyPublic() {
            navigator.clipboard.writeText(this.publicLink());
            this.$toast.add({severity: 'success', icon: 'pi-user-plus',
                             summary: 'Copied Public link to clipboard',
                             life: 2000});
        },
        publicLink() {
            let link = window.location.href.split('/').slice(0, -2);
            link.push(this.id);
            return link.join('/');
        },
        verify() {
            const data = { id: this.id, auth: this.auth };
            const toast = this.$toast;

            this.showLoading = true;
            fetch('http://localhost:9090/verify', {
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
                this.name = res.name;
                console.log(res);
                this.verified = true;
            }).catch(error => {
                console.log(error)
                toast.add({severity: 'error', summary: 'Service error', detail: error});
            }).finally(() => {
                this.showLoading = false;
                // <<<< -- fat arrows mess with polymode formatting.
            });
        },
    },
    beforeMount() {
        this.verify();
    },
}
</script>
