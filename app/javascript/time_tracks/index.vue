<template>
  <div>
    <b-alert :show="showSucessMessage"
              dismissible
              fade
              variant="success"
              @dismissed="showSucessMessage=0">
      <p>{{successMessage}}</p>
    </b-alert>
    <h5>Time Tracks</h5>
    <b-table id="time-tracking-table"
             show-empty
             striped
             fixed
             responsive
             no-provider-paging
             hover
             :fields="fields"
             :items="timeTracks"
             :current-page="currentPage"
             :per-page="perPage">
    </b-table>
    <b-row>
      <b-col md="6">
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage"/>
      </b-col>
    </b-row>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        timeTracks: [],
        sortDesc: true,
        fields: [
          { key: 'first_name', label: 'First Name' },
          { key: 'last_name', label: 'Last Name' },
          { key: 'clock_in', label: 'Clock In' },
          { key: 'clock_out', label: 'Clock Out' }
        ],
        currentPage: 1,
        totalRows: 0,
        perPage: 10,
        pageOptions: [ 5, 10, 15 ],
        showSucessMessage: 0,
        successMessage: ''
      }
    },
    mounted () {
      this.getTimeTracks()
    },
    created () {
      this.$eventHub.$on('successful-clock-in-clock-out', message => {
        this.getTimeTracks()
        this.successMessage = message
        this.showSucessMessage = 10 //in seconds
      })
    },
    methods: {
      getTimeTracks () {
        let promise = this.$http.get('/time_tracks.json')

        return promise.then((data) => {
          this.totalRows  = data.body.length
          this.timeTracks = data.body
        }).catch(error => {
          return []
        })
      }
    }
  }
</script>
