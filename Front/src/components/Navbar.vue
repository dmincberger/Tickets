<script>
import { userTokenStore } from "../store/token.js"
import router from '../router';
import { sendLogoutRequest } from "../js/logout.js";
import { postArchive } from "../api/index.js";

export default {

  data() {
    return {
      admin: false,
      // admin: true,
      // panel: "/admin-archive",
      panel: "/user",
      // panel: "/admin-archive",
    }
  },
  methods: {
    showDownloadArchiveModal() {
      this.$refs.downloadArchive.showModal()
    },
    cancelDownloadArchive() {
      this.$refs.downloadArchive.close();

    },
    async downloadArchiveConfirm() {
      let year = document.getElementById("yearChosen").value
      let getArchive = await postArchive("http://localhost:3001/make_table/" + year)
      console.log(getArchive)
    },
    async logout() {


      let boolean_redirect = await sendLogoutRequest()
      console.log("REDIRECDT: " + boolean_redirect);

      if (boolean_redirect) {
        alert("RESOLVE")
        // userTokenStore().clear()
        // router.push("/")
      } else {
        alert("REJECT")
      }


    },
    changePanel(panel) {
      window.location.href = panel;
    }
  },

  mounted() {
    const currentTimeP = document.getElementById("currentTime")
    setInterval(() => {
      let date = new Date()
      let time = ''
      time += date.getHours()
      if (date.getMinutes() < 10) {
        time += ':0' + date.getMinutes()
      } else {
        time += ':' + date.getMinutes()
      }

      if (date.getSeconds() < 10) {
        time += ':0' + date.getSeconds()
      } else {
        time += ':' + date.getSeconds()
      }
      currentTimeP.innerHTML = time
    }, 1000)

    let token = userTokenStore()
    this.panel = location.pathname
    if (token.getRole() == "admin") {
      this.admin = true
    } else {
      this.admin = false
    }

  }
}
</script>

<template>
  <div class="w-full h-24 navbar flex items-center justify-between">

    <!-- Left element - Logo and Title -->
    <div id="logoTitle" class="flex items-center space-x-2 min-w-0 flex-shrink p-2 bg-zslblue-700 z-10">
      <img src="../assets/logo-zsl-white.png" class="h-16 object-contain" alt="Logo">
      <p id="navTitle" class="text-sm whitespace-nowrap overflow-hidden overflow-ellipsis">ZSŁ
        Ticket
        System
      </p>
    </div>

    <!-- Center element - Current Time -->
    <div class="absolute w-full h-24 flex flex-row justify-center items-center">
      <p id="currentTime" class="text-white text-2xl"></p>
    </div>

    <!-- Right element -->
    <div id="actionsWide" class="whitespace-nowrap flex-shrink-0 p-2 bg-zslblue-700 z-10 flex flex-row justify-center gap-4"
      :class="[{ ['archiveStyle']: admin && this.panel == '/admin-archive' }, { ['adminTicketStyle']: admin && this.panel == '/ticket' }]">
      <button v-if="panel == '/admin' && admin" style="display: flex; justify-content: center; align-items: center;"
        class="w-auto flex justify-center align-middle text-center text-zslblue-200 hover:text-white" @click="changePanel('admin-archive')">
        <p>Pokaż Archiwum</p> <i class="pl-1 pi pi-book"></i>
      </button>
      <button v-if="panel == '/admin-archive' && admin" style="display: flex; justify-content: center; align-items: center;"
        class="w-auto flex justify-center align-middle text-center text-zslblue-200 hover:text-white" @click="changePanel('admin')">
        <p>Pokaż Aktywne</p> <i class="pl-1 pi pi-list"></i>
      </button>
      <button v-if="(panel == '/admin' || panel == '/admin-archive') && admin" style="display: flex; justify-content: center; align-items: center;"
        class="w-auto flex justify-center align-middle text-center text-green-400 hover:text-white" @click="changePanel('user')">
        <p>Dodaj Ticket</p> <i class="pl-1 pi pi-plus-circle"></i>
      </button>
      <button v-if="(panel == '/admin-archive') && admin" style="display: flex; justify-content: center; align-items: center;"
        class="w-auto flex justify-center align-middle text-center text-blue-400 hover:text-white" @click="showDownloadArchiveModal()">
        <p>Pobierz Archwium</p> <i class="pl-1 pi pi-arrow-down"></i>
      </button>
      <button v-if="panel == '/user' && admin" style="display: flex; justify-content: center; align-items: center;"
        class="w-auto flex justify-center align-middle text-center text-green-400 hover:text-white" @click="changePanel('admin')">
        <p>Panel Admina</p> <i class="pl-1 pi pi-bookmark-fill"></i>
      </button>
      <div id="logoutDivider" class="border-l-2 border-zslblue-500"></div>
      <button style="display: flex; justify-content: center; align-items: center;"
        class="logoutB w-auto flex justify-center align-middle text-center text-red-400 hover:text-white" @click="logout">
        <p>Wyloguj</p> <i class="pl-1 pi pi-sign-out"></i>
      </button>
    </div>

  </div>
  <dialog ref="downloadArchive" class="downloadArchiveModal">
    <p>Z którego roku pobrać archiwum? (n.p "2024-2025")</p>
    <input type="text" id="yearChosen" name="yearChosen" class="yearInput" placeholder="2024-2025">
    <div class="absolute bottom-2 right-2 flex flex-row gap-2">
      <button class="zslblueBtn" @click="cancelDownloadArchive">anuluj</button>
      <button class="zslorangeBtn" @click="downloadArchiveConfirm">wyślij</button>
    </div>
  </dialog>
</template>

<style scoped>
/* specific for /admin-archive */
@media screen and (max-width: 750px) {
  #navTitle.archiveStyle {
    @apply whitespace-normal max-w-16
  }

  #actionsWide.archiveStyle {
    @apply gap-1
  }

  #actionsWide.archiveStyle Button {
    @apply flex-col w-9 px-0 w-14
  }

  #actionsWide.archiveStyle p {
    @apply overflow-hidden overflow-ellipsis w-14
  }

  #actionsWide.archiveStyle #logoutDivider {
    @apply hidden
  }

}


/* Specific for user - only logout button */
@media screen and (max-width: 500px) {
  #navTitle.adminTicketStyle {
    @apply whitespace-normal max-w-16
  }

  #actionsWide.adminTicketStyle {
    @apply gap-1
  }

  #actionsWide.adminTicketStyle Button {
    @apply flex-col w-9 px-0 w-14
  }

  #actionsWide.adminTicketStyle p {
    @apply overflow-hidden overflow-ellipsis w-14
  }

  #actionsWide.adminTicketStyle #logoutDivider {
    @apply hidden
  }
}

@media screen and (max-width: 300px) {
  #navTitle {
    @apply whitespace-normal max-w-16
  }

  #actionsWide {
    @apply gap-0
  }

  #actionsWide Button {
    @apply flex-col w-9 px-0 w-14
  }

  #actionsWide p {
    @apply overflow-hidden overflow-ellipsis w-14
  }

  #actionsWide #logoutDivider {
    @apply hidden
  }

}

.navbar {
  @apply bg-zslblue-700 text-zslblue-200
}

.logoutBt:hover {
  @apply text-white
}

.sideBarBtn {
  @apply rounded-sm hover:bg-slate-400 transition-all duration-100 p-2
}

.downloadArchiveModal {
  position: absolute;
  left: 50% - 150px;
  top: 50% - 100px;
  width: 300px;
  height: 200px;
  padding: 30px;
  border-radius: 10px;
}

.yearInput {
  margin-top: 20px;
  border: 1px solid black;
}
</style>