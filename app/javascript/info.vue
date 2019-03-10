<template>
  <div>
    <b-button v-b-modal.infoModal size="sm" variant="info">Click for Info</b-button>

    <b-modal id="infoModal" title="Info">
      <p>
        For <strong>Time Punch</strong>, Teachers(or potentially Employees?) use "Time Punch Codes", which are basically 6-digit unique alphanumeric codes, to "Clock In" or "Clock Out" of the system.
      </p>
      <hr/>
      <p>For demonstration purposes, These are the sample Teachers with their corresponding Time Punch codes:</p>
      <ul>
        <li>Teacher_1 => 950DFA</li>
        <li>Teacher_2 => 59D916</li>
        <li>Teacher_3 => A971C8</li>
      </ul>
      <hr/>
      <p>
        In the future Iteration of this app, these codes would be automatically generated
        everytime a Teacher is added. These codes can be then "issued" to the Teacher thru
        email.
      </p>
    </b-modal>
  </div>
</template>
