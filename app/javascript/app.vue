<template>
  <div id="body">
    <h1>Buscar galpão</h1>

    <input type="search" class="filter" @input="filter = $event.target.value" >

    <div v-for='w in warehouseFilter' :key='w.id'>
      <wItem :name=w.name :code=w.code :description=w.description :city=w.city 
       :state=w.state :postal_code=w.postal_code :total_area=w.total_area
       :useful_area=w.useful_area :categories=w.categories :id=w.id />
    </div>
  </div>
</template>

<script>
import WarehouseItem from './components/WarehouseItem.vue'

export default {
  components: {
    'wItem' : WarehouseItem
  },

  data() {
    return {
      warehouses: [],
      filter: ''
    }
  },

  created(){
    let promise = this.$http.get('http://localhost:3000/api/v1/warehouses')
      .then(resp => resp.json())
      .then(w => this.warehouses = w, err => console.log(err))
  },

  computed: {
    warehouseFilter(){
      if(this.filter) {
        let exp = new RegExp(this.filter.trim(), 'i')
        return this.warehouses.filter(w => exp.test(w.name))
      } else {
        return this.warehouses
      }
    }
  }
}
</script>

<style scoped>

</style>
