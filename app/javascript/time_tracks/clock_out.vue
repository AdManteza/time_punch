<template>
  <div>
    <b-button v-b-modal.clockOutModal
              ok-title="Clock Out!"
              size="lg"
              variant="warning"
              block>
      CLOCK OUT
    </b-button>

    <b-modal id="clockOutModal"
             title="Clock Out"
             @cancel="clearForm"
             @shown="clearForm"
             @ok="handleOk"
             v-bind:ok-disabled="!timePunchCodeValid"
             centered>
      <b-alert show variant="danger" v-if="errors.length">
        <li v-for="error in errors">
          {{ error }}
        </li>
      </b-alert>
      <b-form-group label="Please Enter your unique Time Punch Code"
                    label-for="time-punch-code">
        <b-form-input id="time-punch-code"
                     v-model.trim="timePunchCode"
                     :state="timePunchCodeValid"
                     type="text"
                     aria-describedby="inputErrorFeedback"
                     placeholder="Time Punch Code"/>
        <b-form-invalid-feedback id="inputErrorFeedback">
          This is a required field.
        </b-form-invalid-feedback>
      </b-form-group>
    </b-modal>
  </div>
</template>

<script>
  export default {
    computed: {
      timePunchCodeValid () {
        return this.timePunchCode.length > 0 ? true : false
      }
    },
    data() {
      return {
        timePunchCode: '',
        errors: []
      }
    },
    methods: {
      clearForm () {
        this.timePunchCode = ''
        this.errors = []
      },
      closeForm () {
        this.clearForm()
        this.$root.$emit('bv::hide::modal', 'clockOutModal')
      },
      handleOk (event) {
        event.preventDefault()
        this.errors = []

        let clockOut = new Date
        let params   = { clock_out: clockOut.toUTCString() }
        let promise  = this.$http.put(`/teachers/${this.timePunchCode}/time_tracks.json`, { time_track: params })

        return promise.then((data) => {
          this.closeForm()
          let successMessage = `Successful Clock Out for ${data.body.first_name}`

          this.$eventHub.$emit('successful-clock-in-clock-out', successMessage)
        }).catch(error => {
          this.errors = error.body
        })
      }
    }
  }
</script>
