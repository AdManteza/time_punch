<template>
  <div>
    <b-button v-b-modal.clockInModal
              ok-title="Clock In!"
              size="lg"
              variant="primary">
      CLOCK IN
    </b-button>

    <b-modal id="clockInModal"
             title="Clock In"
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
        this.$root.$emit('bv::hide::modal', 'clockInModal')
      },
      handleOk (event) {
        event.preventDefault()
        this.errors = []

        let clockIn = new Date
        let params  = { clock_in: clockIn.toUTCString() }
        let promise = this.$http.post(`/teachers/${this.teacherId}/time_tracks.json`, { time_track: params })

        return promise.then((data) => {
          this.closeForm()
          console.log(`${this.teacherId} CLOCKED IN!`)
        }).catch(error => {
          this.errors = error.body
        })
      }
    }
  }
</script>
