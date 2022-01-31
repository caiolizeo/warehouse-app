<template>
  <div class="card" :id="'w-'+id">
    <div class="title">
      <h3>{{ name }} <button @click="visible = !visible, editValue()" class='btn'>{{ value }}</button></h3> 
    </div>

    <p class="w-item" v-show="visible">Código: {{ code }}</p>
    <p class="w-item" v-show="visible">Descrição: {{ description }}</p>
    <p class="w-item" v-show="visible">cidade: {{ city }} - {{ state }}</p>
    <p class="w-item" v-show="visible">CEP: {{ postal_code }}</p>
    <p class="w-item" v-show="visible">Área total: {{ total_area }}</p>
    <p class="w-item" v-show="visible">Área útil: {{ useful_area }}</p>
    <p class="w-item" v-show="visible">Categorias:</p>
    <ul v-for="c in categories" :key=c.id class="w-item" v-show="visible">
      <li>{{ c.name }}</li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    id: Number,
    name: String,
    code: String,
    description: String,
    city: String,
    state: String,
    postal_code: String,
    total_area: Number,
    useful_area: Number,
    categories: Array
  },
  
  data(){
    return{
      visible: false,
      status: true,
      value: '+'
    }
  },

  methods: {
    editValue: function(){
      if(this.status){
        this.status = false
        this.value = '-'
      } else {
        this.status = true
        this.value = '+'
      }
    }
  }
}
</script>

<style scoped>
  .title{
    display: flex;
  }
  
  .btn{
    padding: 1px;
    width: 20px;
    height: 20px;
  }

  h3{
    margin-right: 15px;
  }
</style>