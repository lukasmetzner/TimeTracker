<template>
  <h1>Button Table</h1>
  <label>Current Project: {{ currentProject }}</label>
  <br>
  <button @click="startDay">Clear Table</button>
  <br>
  <button @click="endDay">End Current Project</button>
  <div id="button-table-div">
    <button @click="addProject">Add Project</button>
    <input type="text" v-model="newProjectName">
    <button @click="removeProject">Remove Project</button>
    <div>
      <button v-for="project in projects" :key="project" class="projectButton" @click="addProjectButtonHandler">
        {{ project }}
      </button>
    </div>
  </div>
  <hr>
  <h1>Time Table</h1>
  <div id="time-table-div">
    <table id="time-table">
      <tr>
        <th>Project Name</th>
        <th>Working Time</th>
      </tr>
      <tr v-for="[project, time] in Object.entries(trackedTimes)" :key="project">
        <td>{{ project }}</td>
        <td>{{ this.msToTime(time) }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: "HelloWorld",
  data() {
    return {
      newProjectName: "",
      gridWidthAndHeight: 2,
      projects: [],
      trackedTimes: {},
      currentProject: "",
      currentProjectStart: null,
    };
  },
  mounted() {
    var timesFromStorage = localStorage.getItem("trackedTimes");
    if (timesFromStorage != null) {
      this.trackedTimes = JSON.parse(timesFromStorage);
    } else {
      this.trackedTimes = {};
    }

    var projectsFromStorage = localStorage.getItem("projects");
    if (projectsFromStorage != null) {
      this.projects = JSON.parse(projectsFromStorage);
    } else {
      this.projects = [];
    }
  },
  methods: {
    addProject() {
      if (!this.projects.includes(this.newProjectName)) {
        this.projects.push(this.newProjectName);
        localStorage.setItem("projects", JSON.stringify(this.projects));
      } else {
        alert("Project already added!");
      }
    },
    removeProject() {
      this.projects = this.projects.filter(p => p != this.newProjectName);
      localStorage.setItem("projects", JSON.stringify(this.projects));
    },
    addProjectButtonHandler(event) {
      var projectName = event.srcElement.innerText;
      if (this.currentProjectStart != null) {
        var now = new Date();
        var diff = now - this.currentProjectStart;
        if (Object.keys(this.trackedTimes).includes(this.currentProject)) {
          this.trackedTimes[this.currentProject] += diff;
        } else {
          this.trackedTimes[this.currentProject] = diff;
        }
        localStorage.setItem("trackedTimes", JSON.stringify(this.trackedTimes));
      }

      this.currentProject = projectName;
      this.currentProjectStart = new Date();
    },
    msToTime(duration) {
      var milliseconds = Math.floor((duration % 1000) / 100),
        seconds = Math.floor((duration / 1000) % 60),
        minutes = Math.floor((duration / (1000 * 60)) % 60),
        hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

      hours = hours < 10 ? "0" + hours : hours;
      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;

      return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
    },
    endDay() {
      if (this.currentProjectStart == null) {
        alert("You haven't even started yet! Get to work!");
        return;
      }
      var now = new Date();
      var diff = now - this.currentProjectStart;
      if (Object.keys(this.trackedTimes).includes(this.currentProject)) {
        this.trackedTimes[this.currentProject] += diff;
      } else {
        this.trackedTimes[this.currentProject] = diff;
      }
      localStorage.setItem("trackedTimes", JSON.stringify(this.trackedTimes));
      this.currentProject = "";
      this.currentProjectStart = null;
    },
    startDay() {
      localStorage.removeItem("trackedTimes");
      this.trackedTimes = {};
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
#button-table-div {
  margin: auto;
  width: 50%;
}
#button-table {
  margin: auto;
}
#time-table-div {
  margin: auto;
  width: 50%;
}
#time-table {
  margin: auto;
  width: 50%;
}
button {
  margin: 5px;
}
.projectButton {
  min-width: 5em;
  min-height: 5em;
}
</style>
