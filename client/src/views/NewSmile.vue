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

            // const options = {
            //     method: 'POST',
            //     body: JSON.stringify( {
            //         param1: "d",
            //         param2: "d"
            //     } )
            // };

            fetch('flowers.jpg')
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('HTTP error, status = ' + response.status);
                    }
                    console.log(response);
                    return response.blob();

                })
                .then(function(myBlob) {
                    console.log(myBlob)
                })
                .catch(function(error) {
                    console.log(error)
                });

            // fetch( '/path/', options )
            //     .then( response => response.json() )
            //     .then( response => {
            //         console.log(response);
            //         // Do something with response.
            //     } );
        }
    }
    }
</script>
