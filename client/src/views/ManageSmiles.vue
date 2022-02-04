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
        <FileUpload @error="onError" @before-send="beforeSend" @upload="onUpload"
                    name="images" url="http://localhost:9090/upload"
                    :multiple="true" accept="image/*"
                    :maxFileSize="2097152"> <!-- 1024 * 1024 * 2 -->
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
        beforeSend(xhr) {
            xhr.formData.append('id', this.id);
            xhr.formData.append('auth', this.auth);
        },
        onError(error) {
            this.$toast.add(
                {severity: 'error',
                 summary: 'Upload failed',
                 detail: `${error.xhr.status} ${error.xhr.statusText} | ${error.xhr.response}`});
        },
        onUpload(res) {
            const response = JSON.parse(res.xhr.response);
            for(let i = 0; i < response.length; i++) {
                const x = response[i];
                if (x.stored === false) {
                    this.$toast.add(
                        {
                            severity: 'error',
                            summary: 'Upload failed',
                            detail: `${x.filename}: ${x.messages}`
                        }
                    );
                } else if (x.messages.length !== 0) {
                    this.$toast.add(
                        {
                            severity: 'warn',
                            summary: 'Upload Issues',
                            detail: `${x.filename}: ${x.messages}`
                        }
                    );
                }
            }
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
                if (response.status === 401)
                    throw new Error(response.status + ' # ' + 'Authentication Failed');
                if (response.status === 404)
                    throw new Error(response.status + ' # ' + 'Smiles deleted or invalid link');
                if (!response.ok)
                    throw new Error('HTTP error, status = ' + response.status);
                return response.json();
            }).then(res => {
                this.name = res.name;
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
