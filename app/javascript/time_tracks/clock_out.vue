<template>
  <div>
    <b-button v-b-modal.clockOutModal
              ok-title="Clock Out!"
              size="lg"
              variant="warning">
      CLOCK OUT
    </b-button>

    <b-modal id="clockOutModal"
             title="Clock Out"
             @cancel="clearForm"
             @shown="clearForm"
             @ok="handleOk"
             v-bind:ok-disabled="!teacherIdValid"
             centered>
      <b-alert show variant="danger" v-if="errors.length">
        <li v-for="error in errors">
          {{ error }}
        </li>
      </b-alert>
      <b-form-group label="Please Enter your unique Teacher ID"
                    label-for="teacher-id">
        <b-form-input id="teacher-id"
                     v-model.trim="teacherId"
                     :state="teacherIdValid"
                     type="text"
                     aria-describedby="inputErrorFeedback"
                     placeholder="Teacher ID"/>
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
      teacherIdValid () {
        return this.teacherId.length > 0 ? true : false
      }
    },
    data() {
      return {
        teacherId: '',
        errors: []
      }
    },
    methods: {
      clearForm () {
        this.teacherId = ''
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
        let params  = { clock_out: clockOut.toUTCString() }
        let promise = this.$http.put(`/teachers/${this.teacherId}/time_tracks.json`, { time_track: params })

        return promise.then((data) => {
          this.closeForm()
          console.log(`${this.teacherId} CLOCKED OUT!`)
        }).catch(error => {
          this.errors = error.body
        })
      }
    }
  }
</script>
