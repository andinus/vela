<template>
<div class="home">
  <p id="subtitle">Vela is a place to share smiles :)</p>

  <div class="card">
    <div class="grid">
      <div class="col-12 md:col-8 lg:col-6">
        <p>
          The idea is simple, users create a <em>Smile</em> and receive two
          links: public, upload. They can share the public link with their
          friends. The upload link should be kept private.
        </p>
        <p>
          They can upload pictures of them or anything that they want to
          share with the private link. Visitors on the public link can view
          the <em>Smiles</em> but only once, pictures are deleted after it's
          viewed once.
        </p>
      </div>
      <div class="col-12 md:col-4 lg:col-6 flex align-items-center
                  justify-content-center">
        <router-link to="/create">
          <Button label="Create Smiles" icon="pi pi-user-plus" />
        </router-link>
      </div>
    </div>
  </div>
</div>
</template>
