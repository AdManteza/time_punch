<template>
  <digital-clock style="color: green; font-size: 25px;"
                 :displaySeconds="true"
                 :twelveHour="true"/>
</template>

<script>
import DigitalClock from "vue-digital-clock";

export default {
  components: {
    DigitalClock
  }
};
</script>
