<template>
<div class="get-smile">
  <p id="subtitle">Get a Smile :)</p>
  <ProgressBar v-if="showLoading" mode="indeterminate" style="height: .4em;" />

  <div v-if="!gotSmile && !showLoading" style="text-align: center;">
    <Button @click="getSmile" label="Try Again"
            class="p-button-outlined  p-button-info p-button-lg" icon="pi pi-refresh" />
  </div>

  <div v-if="gotSmile" style="text-align: center;">
    <Button @click="again" label="Again!" icon="pi pi-refresh" />
  </div>
  <div v-if="gotSmile" id="smile">
  </div>
  <Toast />
</div>
</template>

<script>
export default {
    data() {
        return {
            name: '',
            showLoading: true,
            gotSmile: false,
            id: this.$route.params.id,
        }
    },
    methods: {
        beforeSend(xhr) {
            xhr.formData.append('id', this.id);

        },
        again() {
            document.getElementById('smile').innerHTML = '';
            this.getSmile();
        },
        getSmile() {
            const toast = this.$toast;

            this.showLoading = true;
            fetch(
                `../smile/${this.id}`,
                { cache: 'no-cache', referrerPolicy: 'no-referrer', responseType: 'blob' }
            ).then(response => {
                if (response.status === 404)
                    throw new Error(response.status + ' # ' + 'Smiles deleted or invalid link');
                if (response.status === 406)
                    throw new Error(response.status + ' # ' + 'No smiles available');
                if (!response.ok)
                    throw new Error('HTTP error, status = ' + response.status);
                return response;
            }).then(res => {
                (async () => {
                    const blob = await res.blob();
                    const img = new Image();
                    img.src = URL.createObjectURL(blob);
                    await img.decode();
                    document.getElementById('smile').append(img);
                    URL.revokeObjectURL(img.src);
                })();

                this.gotSmile = true;
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
        this.getSmile();
    },
}
</script>

<style>
img { max-width: 100%; padding: 1em; }
</style>
